import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../global_controller.dart';

/// 優化版定位增強背景同步服務
/// 基於實際測試數據的智能頻率調整
class LocationEnhancementServiceV2 extends GetxService {
  static const String _tag = 'LocationEnhancementV2';

  Timer? _primaryLocationTimer; // 主要GPS定時器
  Timer? _secondaryLocationTimer; // 次要GPS定時器
  StreamSubscription<Position>? _positionStream;

  // 狀態管理
  final RxBool _isEnabled = false.obs;
  final RxString _lastSyncTrigger = ''.obs;
  final RxInt _syncCount = 0.obs;
  final RxInt _gpsSuccessCount = 0.obs;
  final RxInt _gpsFailCount = 0.obs;
  DateTime? _lastSyncTime;
  DateTime? _lastSuccessfulGpsTime;

  // 🎯 基於實測數據的配置參數
  static const Duration _primaryInterval = Duration(minutes: 8); // 主要頻率：8分鐘
  static const Duration _secondaryInterval = Duration(minutes: 3); // 次要頻率：3分鐘
  static const Duration _nightInterval = Duration(minutes: 20); // 夜間頻率：20分鐘
  static const Duration _aggressiveInterval = Duration(minutes: 2); // 激進頻率：2分鐘
  static const Duration _minSyncGap = Duration(seconds: 90); // 最小間隔：90秒
  static const Duration _gpsTimeout = Duration(seconds: 3); // GPS超時：3秒

  // Getters
  bool get isEnabled => _isEnabled.value;
  String get lastSyncTrigger => _lastSyncTrigger.value;
  int get syncCount => _syncCount.value;
  double get gpsSuccessRate => (_gpsSuccessCount.value + _gpsFailCount.value) >
          0
      ? _gpsSuccessCount.value / (_gpsSuccessCount.value + _gpsFailCount.value)
      : 0.0;

  @override
  void onInit() {
    super.onInit();
    print('📍 [$_tag] 初始化優化版定位增強服務');
  }

  @override
  void onClose() {
    _stopAllLocationServices();
    super.onClose();
  }

  /// 請求權限並初始化
  Future<void> requestPermissionAndInitialize() async {
    try {
      print('📍 [$_tag] 開始請求定位權限...');

      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('❌ [$_tag] 定位服務未啟用');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        _isEnabled.value = true;
        print('✅ [$_tag] 定位權限已授予，啟用優化背景同步');

        await _startOptimizedLocationSync();
      } else {
        print('📱 [$_tag] 定位權限被拒絕，使用標準模式');
        _handlePermissionDenied(permission);
      }
    } catch (e) {
      print('❌ [$_tag] 初始化失敗: $e');
      _isEnabled.value = false;
    }
  }

  /// 啟動優化的定位同步策略
  Future<void> _startOptimizedLocationSync() async {
    try {
      // 🎯 分層頻率策略
      _startPrimaryLocationRequests(); // 主要頻率：8分鐘
      _startSecondaryLocationRequests(); // 次要頻率：3分鐘（條件觸發）
      _startLocationChangeMonitoring(); // 位置變化監聽

      print('🌍 [$_tag] 優化GPS背景同步已啟動');
    } catch (e) {
      print('❌ [$_tag] 啟動優化同步失敗: $e');
    }
  }

  /// 主要GPS請求 - 穩定的8分鐘間隔
  void _startPrimaryLocationRequests() {
    final interval = _getCurrentPrimaryInterval();

    _primaryLocationTimer = Timer.periodic(interval, (timer) async {
      await _attemptLocationWakeupSync('主要GPS', isPrimary: true);
    });

    print('⏰ [$_tag] 主要GPS請求已啟動 (間隔: ${interval.inMinutes}分鐘)');
  }

  /// 次要GPS請求 - 智能3分鐘間隔（條件觸發）
  void _startSecondaryLocationRequests() {
    _secondaryLocationTimer = Timer.periodic(_secondaryInterval, (timer) async {
      // 🎯 只在特定條件下觸發次要請求
      if (_shouldTriggerSecondaryGps()) {
        await _attemptLocationWakeupSync('次要GPS', isPrimary: false);
      }
    });

    print('⚡ [$_tag] 次要GPS請求已啟動 (條件觸發)');
  }

  /// 判斷是否應該觸發次要GPS
  bool _shouldTriggerSecondaryGps() {
    // 條件1: GPS成功率低於70%時，增加頻率
    if (gpsSuccessRate < 0.7 &&
        _gpsSuccessCount.value + _gpsFailCount.value >= 5) {
      return true;
    }

    // 條件2: 距離上次成功GPS超過10分鐘
    if (_lastSuccessfulGpsTime != null) {
      final timeSinceSuccess =
          DateTime.now().difference(_lastSuccessfulGpsTime!);
      if (timeSinceSuccess.inMinutes >= 10) {
        return true;
      }
    }

    // 條件3: 在工作時間（8:00-22:00）且距離上次同步超過5分鐘
    final hour = DateTime.now().hour;
    if (hour >= 8 && hour <= 22) {
      if (_lastSyncTime != null) {
        final timeSinceSync = DateTime.now().difference(_lastSyncTime!);
        if (timeSinceSync.inMinutes >= 5) {
          return true;
        }
      }
    }

    return false;
  }

  /// 位置變化監聽 - 用戶移動時觸發
  void _startLocationChangeMonitoring() {
    try {
      const locationSettings = LocationSettings(
        accuracy: LocationAccuracy.low,
        distanceFilter: 300, // 移動300m才觸發（降低頻率）
      );

      _positionStream = Geolocator.getPositionStream(
        locationSettings: locationSettings,
      ).listen(
        (position) {
          _triggerSyncIfNeeded('位置變化');
        },
        onError: (error) {
          print('⚠️ [$_tag] 位置監聽錯誤: $error');
        },
      );

      print('📡 [$_tag] 位置變化監聽已啟動');
    } catch (e) {
      print('❌ [$_tag] 啟動位置監聽失敗: $e');
    }
  }

  /// 嘗試GPS喚醒同步 - 優化版本
  Future<void> _attemptLocationWakeupSync(String source,
      {bool isPrimary = true}) async {
    try {
      print('🔄 [$_tag] 執行${source}喚醒同步...');

      final startTime = DateTime.now();

      // 🎯 更短的GPS超時時間，快速失敗
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        timeLimit: _gpsTimeout,
      );

      final gpsTime = DateTime.now().difference(startTime);
      print(
          '📍 [$_tag] GPS請求成功 (${gpsTime.inMilliseconds}ms): ${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}');

      _gpsSuccessCount.value++;
      _lastSuccessfulGpsTime = DateTime.now();

      // 🎯 利用GPS成功後的背景執行時間
      await _triggerSyncIfNeeded('$source成功');
    } catch (e) {
      final errorTime = DateTime.now();
      print('⚠️ [$_tag] ${source}請求失敗: $e');

      _gpsFailCount.value++;

      // 🎯 即使GPS失敗也嘗試同步 - 可能仍有短暫執行時間
      await _triggerSyncIfNeeded('${source}失敗備援');
    }
  }

  /// 觸發同步（優化的節流機制）
  Future<void> _triggerSyncIfNeeded(String source) async {
    if (!_shouldTriggerSync()) {
      return;
    }

    try {
      print('🚀 [$_tag] $source 觸發背景同步');

      final syncStartTime = DateTime.now();
      final gc = Get.find<GlobalController>();

      // 🎯 關鍵：在有限的背景時間內快速同步
      await gc.safeRunSync();

      final syncDuration = DateTime.now().difference(syncStartTime);

      // 更新狀態
      _lastSyncTime = DateTime.now();
      _lastSyncTrigger.value = source;
      _syncCount.value++;

      print(
          '✅ [$_tag] 背景同步完成 (${syncDuration.inMilliseconds}ms, 來源: $source, 總計: ${_syncCount.value}次)');
    } catch (e) {
      print('❌ [$_tag] 背景同步失敗: $e');
    }
  }

  /// 節流機制 - 避免過度同步
  bool _shouldTriggerSync() {
    if (_lastSyncTime == null) {
      return true;
    }

    final timeSinceLastSync = DateTime.now().difference(_lastSyncTime!);
    return timeSinceLastSync >= _minSyncGap;
  }

  /// 獲取當前主要間隔（智能調整）
  Duration _getCurrentPrimaryInterval() {
    final hour = DateTime.now().hour;

    // 夜間（23:00-06:00）降低頻率
    if (hour >= 23 || hour <= 6) {
      return _nightInterval;
    }

    // GPS成功率低時，使用激進頻率
    if (gpsSuccessRate < 0.5 &&
        _gpsSuccessCount.value + _gpsFailCount.value >= 10) {
      return _aggressiveInterval;
    }

    return _primaryInterval;
  }

  /// 動態調整頻率
  void adjustSyncFrequency() {
    if (!_isEnabled.value) return;

    final newPrimaryInterval = _getCurrentPrimaryInterval();

    _primaryLocationTimer?.cancel();
    _primaryLocationTimer = Timer.periodic(newPrimaryInterval, (timer) async {
      await _attemptLocationWakeupSync('主要GPS調整', isPrimary: true);
    });

    print('🔄 [$_tag] 主要同步頻率已調整為 ${newPrimaryInterval.inMinutes}分鐘');
  }

  /// 處理權限被拒絕
  void _handlePermissionDenied(LocationPermission permission) {
    _isEnabled.value = false;
    print('📱 [$_tag] 權限被拒絕: $permission，降級到標準模式');
  }

  /// 停止所有定位服務
  void _stopAllLocationServices() {
    _primaryLocationTimer?.cancel();
    _secondaryLocationTimer?.cancel();
    _positionStream?.cancel();

    _primaryLocationTimer = null;
    _secondaryLocationTimer = null;
    _positionStream = null;

    print('🛑 [$_tag] 所有定位服務已停止');
  }

  /// 獲取詳細服務狀態
  Map<String, dynamic> getDetailedServiceStatus() {
    return {
      'isEnabled': _isEnabled.value,
      'lastSyncTrigger': _lastSyncTrigger.value,
      'syncCount': _syncCount.value,
      'gpsSuccessCount': _gpsSuccessCount.value,
      'gpsFailCount': _gpsFailCount.value,
      'gpsSuccessRate': '${(gpsSuccessRate * 100).toStringAsFixed(1)}%',
      'lastSyncTime': _lastSyncTime?.toIso8601String(),
      'lastSuccessfulGpsTime': _lastSuccessfulGpsTime?.toIso8601String(),
      'currentPrimaryInterval': '${_getCurrentPrimaryInterval().inMinutes}分鐘',
      'secondaryInterval': '${_secondaryInterval.inMinutes}分鐘',
      'shouldTriggerSecondary': _shouldTriggerSecondaryGps(),
    };
  }

  /// 手動觸發測試
  Future<void> manualTriggerSync() async {
    await _triggerSyncIfNeeded('手動觸發測試');
  }
}
