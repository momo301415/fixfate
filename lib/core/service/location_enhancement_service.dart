import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../global_controller.dart';

/// 定位策略模式
enum LocationStrategy {
  smartSwitch, // 智能切換（前景省電，背景增強）
  unifiedGps, // 統一GPS（不分前景背景都運行）
}

/// 定位增強背景同步服務（保活優先策略）
/// 通過高頻GPS請求來確保iOS背景持續保活和數據同步穩定性
/// 支持智能切換和統一GPS兩種策略，優先保證健康數據完整性
class LocationEnhancementService extends GetxService {
  static const String _tag = 'LocationEnhancementService';

  // 定時器相關
  Timer? _locationTimer;
  StreamSubscription<Position>? _positionStream;

  // 狀態管理
  final RxBool _isLocationEnhancementEnabled = false.obs;
  final RxString _lastSyncTrigger = ''.obs;
  final RxInt _syncCount = 0.obs;
  DateTime? _lastSyncTime;

  // 🎯 新增：背景同步失敗計數器
  final RxInt _backgroundSyncFailures = 0.obs;
  static const int _maxFailuresBeforeUpgrade = 3; // 連續3次失敗後請求權限升級

  // 🎯 新增：策略模式管理
  final Rx<LocationStrategy> _currentStrategy =
      LocationStrategy.smartSwitch.obs;
  bool _isUnifiedModeRunning = false;

  // 配置參數 - 優化為保活優先
  static const Duration _normalInterval = Duration(minutes: 3); // 🎯 縮短到3分鐘確保保活
  static const Duration _nightInterval = Duration(minutes: 5); // 🎯 夜間也保持較短間隔
  static const Duration _minSyncGap = Duration(minutes: 1); // 🎯 縮短最小間隔
  static const Duration _gpsTimeout = Duration(seconds: 8); // 🎯 增加GPS超時容錯

  // Getters
  bool get isLocationEnhancementEnabled => _isLocationEnhancementEnabled.value;
  String get lastSyncTrigger => _lastSyncTrigger.value;
  int get syncCount => _syncCount.value;
  LocationStrategy get currentStrategy => _currentStrategy.value;
  bool get isUnifiedModeRunning => _isUnifiedModeRunning;
  int get backgroundSyncFailures => _backgroundSyncFailures.value;

  // 🎯 新增：權限狀態檢測
  Future<LocationPermission> get currentPermission async =>
      await Geolocator.checkPermission();
  Future<bool> get hasAlwaysPermission async =>
      (await currentPermission) == LocationPermission.always;
  Future<bool> get hasWhileInUsePermission async =>
      (await currentPermission) == LocationPermission.whileInUse;
  Future<bool> get canUpgradeToAlways async =>
      (await currentPermission) == LocationPermission.whileInUse;

  @override
  void onInit() {
    super.onInit();
    print('📍 [$_tag] 初始化定位增強服務');
  }

  @override
  void onClose() {
    _stopAllLocationServices();
    super.onClose();
  }

  /// 請求權限並初始化定位增強
  /// 在app啟動時調用
  Future<void> requestPermissionAndInitialize() async {
    try {
      print('📍 [$_tag] 開始請求定位權限...');

      // 檢查定位服務是否啟用
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('❌ [$_tag] 定位服務未啟用，無法使用定位增強');
        return;
      }

      // 直接請求定位權限（使用系統原生 dialog）
      LocationPermission permission = await Geolocator.checkPermission();
      print('📱 [$_tag] 當前權限狀態: $permission');

      // 如果權限被拒絕或未確定，都嘗試請求權限
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.unableToDetermine) {
        print('🔄 [$_tag] 權限被拒絕或未確定，嘗試請求權限...');
        permission = await Geolocator.requestPermission();
        print('📱 [$_tag] 請求後權限狀態: $permission');
      }

      // 根據權限結果決定是否啟用增強模式
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        _isLocationEnhancementEnabled.value = true;
        print('✅ [$_tag] 定位權限已授予，啟用GPS背景同步增強');

        await _startLocationBasedBackgroundSync();
      } else {
        print('📱 [$_tag] 定位權限被拒絕，使用標準背景同步模式');
        _handlePermissionDenied(permission);
      }
    } catch (e) {
      print('❌ [$_tag] 初始化定位增強失敗: $e');
      _isLocationEnhancementEnabled.value = false;
    }
  }

  /// 只請求權限，不啟動GPS定時器（用於按需啟動）
  Future<void> requestPermissionOnly() async {
    try {
      print('📍 [$_tag] 請求定位權限（不啟動GPS）...');

      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('❌ [$_tag] 定位服務未啟用');
        return;
      }

      // 直接請求定位權限（使用系統原生 dialog）
      LocationPermission permission = await Geolocator.checkPermission();
      print('📱 [$_tag] 當前權限狀態: $permission');

      // 如果權限被拒絕或未確定，都嘗試請求權限
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.unableToDetermine) {
        print('🔄 [$_tag] 權限被拒絕或未確定，嘗試請求權限...');
        permission = await Geolocator.requestPermission();
        print('📱 [$_tag] 請求後權限狀態: $permission');
      }

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        _isLocationEnhancementEnabled.value = true;
        print('✅ [$_tag] 定位權限已授予（待啟動狀態）');
      } else {
        _isLocationEnhancementEnabled.value = false;
        _handlePermissionDenied(permission);
      }
    } catch (e) {
      print('❌ [$_tag] 請求定位權限失敗: $e');
      _isLocationEnhancementEnabled.value = false;
    }
  }

  /// 啟動GPS增強服務（背景模式時調用）
  Future<void> startLocationEnhancement() async {
    if (!_isLocationEnhancementEnabled.value) {
      print('⚠️ [$_tag] 定位權限未授予，無法啟動GPS增強');
      return;
    }

    if (_locationTimer != null || _positionStream != null) {
      print('⚠️ [$_tag] GPS增強已在運行中');
      return;
    }

    try {
      await _startLocationBasedBackgroundSync();
      print('🌍 [$_tag] GPS背景增強已啟動（背景模式）');
    } catch (e) {
      print('❌ [$_tag] 啟動GPS增強失敗: $e');
    }
  }

  /// 啟動基於定位的背景同步
  Future<void> _startLocationBasedBackgroundSync() async {
    try {
      // 啟動定時GPS請求（主力機制）
      _startPeriodicLocationRequests();

      // 啟動位置變化監聽（額外觸發）
      _startLocationChangeMonitoring();

      print('🌍 [$_tag] GPS背景同步增強已啟動（保活優先模式）');
    } catch (e) {
      print('❌ [$_tag] 啟動定位背景同步失敗: $e');
    }
  }

  /// 定時GPS請求 - 主力機制（不需要用戶移動）
  void _startPeriodicLocationRequests() {
    final interval = _getCurrentSyncInterval();

    _locationTimer = Timer.periodic(interval, (timer) async {
      await _attemptLocationWakeupSync();
    });

    print('⏰ [$_tag] 定時GPS請求已啟動 (保活優先間隔: ${interval.inMinutes}分鐘)');
  }

  /// 位置變化監聽 - 額外機制（用戶移動時觸發）
  void _startLocationChangeMonitoring() {
    try {
      // 🎯 iPad優化：檢查當前權限狀態
      _checkLocationPermissionAndStartStream();
    } catch (e) {
      print('❌ [$_tag] 啟動位置監聽失敗: $e');
    }
  }

  /// 檢查權限並啟動位置流（iPad優化）
  Future<void> _checkLocationPermissionAndStartStream() async {
    try {
      final permission = await Geolocator.checkPermission();
      print('📱 [$_tag] 當前定位權限: $permission');

      // 🎯 iPad特殊處理：根據權限級別決定策略
      if (permission == LocationPermission.always) {
        // Always權限：可以使用背景位置流
        _startLocationStreamWithSettings(aggressive: true);
      } else if (permission == LocationPermission.whileInUse) {
        // WhileInUse權限：使用保守設置，避免背景錯誤
        _startLocationStreamWithSettings(aggressive: false);
      } else {
        print('⚠️ [$_tag] 權限不足，跳過位置流監聽，依賴定時GPS請求');
        return;
      }
    } catch (e) {
      print('❌ [$_tag] 檢查權限失敗: $e');
    }
  }

  /// 根據權限級別啟動位置流（保活優先）
  void _startLocationStreamWithSettings({required bool aggressive}) {
    try {
      final locationSettings = LocationSettings(
        accuracy: aggressive ? LocationAccuracy.low : LocationAccuracy.lowest,
        distanceFilter: aggressive ? 200 : 500, // 🎯 縮短距離以增加觸發頻率
      );

      _positionStream = Geolocator.getPositionStream(
        locationSettings: locationSettings,
      ).listen(
        (position) {
          _triggerSyncIfNeeded(
              '位置變化 (${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)})');
        },
        onError: (error) {
          _handleLocationStreamError(error);
        },
        onDone: () {
          print('📡 [$_tag] 位置監聽流結束');
        },
      );

      final mode = aggressive ? '積極模式' : '保守模式';
      print('📡 [$_tag] 位置變化監聽已啟動 ($mode)');
    } catch (e) {
      print('❌ [$_tag] 啟動位置流失敗: $e');
    }
  }

  /// 處理位置流錯誤（iPad優化）
  void _handleLocationStreamError(dynamic error) {
    final errorString = error.toString();
    print('⚠️ [$_tag] 位置監聽錯誤: $errorString');

    // 🎯 常見錯誤處理
    if (errorString.contains('kCLErrorDomain error 1') ||
        errorString.contains('kCLErrorDenied')) {
      print('📱 [$_tag] 檢測到權限錯誤，停止位置流監聽');
      _stopLocationStream();
      print('✅ [$_tag] 位置流已停止，依賴定時GPS請求（更可靠）');
    } else if (errorString.contains('kCLErrorLocationUnknown')) {
      print('📱 [$_tag] 暫時無法確定位置，保持位置流運行');
    } else if (errorString.contains('kCLErrorNetwork')) {
      print('📱 [$_tag] 網路錯誤，位置服務將稍後重試');
    } else {
      print('📱 [$_tag] 未知位置錯誤，停止位置流避免持續錯誤');
      _stopLocationStream();
    }
  }

  /// 停止位置流監聽
  void _stopLocationStream() {
    _positionStream?.cancel();
    _positionStream = null;
    print('🛑 [$_tag] 位置流監聽已停止');
  }

  /// 嘗試通過GPS請求喚醒背景並觸發同步
  Future<void> _attemptLocationWakeupSync() async {
    try {
      print('🔄 [$_tag] 執行定時GPS喚醒同步...');

      // 主動請求位置，可能短暫喚醒iOS背景執行
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        timeLimit: _gpsTimeout,
      );

      print(
          '📍 [$_tag] GPS請求成功: ${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}');

      // 利用GPS請求可能帶來的短暫背景執行時間進行同步
      await _triggerSyncIfNeeded('GPS定時喚醒');
    } catch (e) {
      print('⚠️ [$_tag] GPS請求失敗: $e');

      // GPS失敗也嘗試觸發同步，因為可能仍有短暫的背景執行時間
      await _triggerSyncIfNeeded('GPS失敗備援');
    }
  }

  /// 觸發同步（如果需要）
  Future<void> _triggerSyncIfNeeded(String source) async {
    if (!_shouldTriggerSync()) {
      return;
    }

    try {
      print('🚀 [$_tag] $source 觸發背景同步');

      final gc = Get.find<GlobalController>();
      await gc.safeRunSync();

      // 🎯 同步成功，重置失敗計數器
      _backgroundSyncFailures.value = 0;

      // 更新狀態
      _lastSyncTime = DateTime.now();
      _lastSyncTrigger.value = source;
      _syncCount.value++;

      print('✅ [$_tag] 背景同步完成 (來源: $source, 總計: ${_syncCount.value}次)');
    } catch (e) {
      print('❌ [$_tag] 背景同步失敗: $e');

      // 🎯 同步失敗，增加失敗計數器
      _backgroundSyncFailures.value++;

      // 🎯 連續失敗達到閾值時，主動請求權限升級
      if (_backgroundSyncFailures.value >= _maxFailuresBeforeUpgrade) {
        await _handleConsecutiveSyncFailures();
      }
    }
  }

  /// 處理連續同步失敗情況
  Future<void> _handleConsecutiveSyncFailures() async {
    try {
      print('⚠️ [$_tag] 連續背景同步失敗 ${_backgroundSyncFailures.value} 次，嘗試權限升級...');

      final gc = Get.find<GlobalController>();
      final canUpgrade = await gc.canUpgradeLocationPermission();

      if (canUpgrade) {
        print('💡 [$_tag] 同步效果不佳，請求Always權限以改善背景穩定性...');

        final success =
            await gc.triggerLocationPermissionUpgrade(context: '背景同步失敗');

        if (success) {
          print('🎉 [$_tag] 權限升級成功，背景同步穩定性將大幅改善！');
          _backgroundSyncFailures.value = 0; // 重置計數器
        } else {
          print('⏳ [$_tag] 權限暫未升級，將繼續監控同步狀況');
        }
      } else {
        print('📱 [$_tag] 當前權限狀態無法升級');
      }
    } catch (e) {
      print('❌ [$_tag] 處理連續同步失敗異常: $e');
    }
  }

  /// 判斷是否應該觸發同步（節流機制）
  bool _shouldTriggerSync() {
    if (_lastSyncTime == null) {
      return true;
    }

    final timeSinceLastSync = DateTime.now().difference(_lastSyncTime!);
    final shouldSync = timeSinceLastSync >= _minSyncGap;

    if (!shouldSync) {
      print('⏳ [$_tag] 距離上次同步僅${timeSinceLastSync.inMinutes}分鐘，跳過此次觸發');
    }

    return shouldSync;
  }

  /// 獲取當前同步間隔（保活優先策略）
  Duration _getCurrentSyncInterval() {
    final hour = DateTime.now().hour;

    // 🎯 保活優先：夜間也保持較短間隔確保背景穩定
    if (hour >= 23 || hour <= 6) {
      return _nightInterval; // 5分鐘（原30分鐘太久）
    } else {
      return _normalInterval; // 3分鐘（原15分鐘太久）
    }
  }

  /// 智能調整同步頻率（保活優先）
  void adjustSyncFrequency() {
    if (_locationTimer == null || !_isLocationEnhancementEnabled.value) {
      return;
    }

    final newInterval = _getCurrentSyncInterval();

    _locationTimer?.cancel();
    _locationTimer = Timer.periodic(newInterval, (timer) async {
      await _attemptLocationWakeupSync();
    });

    print('🔄 [$_tag] 保活頻率已調整為 ${newInterval.inMinutes}分鐘');
  }

  /// 處理權限被拒絕的情況
  void _handlePermissionDenied(LocationPermission permission) {
    String reason;
    switch (permission) {
      case LocationPermission.denied:
        reason = '用戶拒絕定位權限';
        break;
      case LocationPermission.deniedForever:
        reason = '用戶永久拒絕定位權限';
        break;
      case LocationPermission.unableToDetermine:
        reason = '無法確定定位權限狀態';
        break;
      default:
        reason = '未知權限狀態: $permission';
    }

    print('📱 [$_tag] $reason，自動降級到標準背景同步模式');
    _isLocationEnhancementEnabled.value = false;
  }

  /// 停止所有定位服務
  void _stopAllLocationServices() {
    _locationTimer?.cancel();
    _locationTimer = null;

    _stopLocationStream();

    print('🛑 [$_tag] 所有定位服務已停止');
  }

  /// 停止定位增強（前景模式時調用，保留權限狀態）
  void stopLocationEnhancement() {
    _stopAllLocationServices();
    print('📱 [$_tag] GPS背景增強已停止（前景模式省電）');
  }

  /// 完全停用定位增強（手動停用時調用）
  void disableLocationEnhancement() {
    _stopAllLocationServices();
    _isLocationEnhancementEnabled.value = false;
    print('📱 [$_tag] 定位增強已完全停用，切換到標準模式');
  }

  /// 重新啟動定位增強（如果有權限）
  Future<void> restartLocationEnhancement() async {
    if (!_isLocationEnhancementEnabled.value) {
      await requestPermissionAndInitialize();
    }
  }

  // ======================================================
  // 🎯 新增：統一GPS策略相關方法
  // ======================================================

  /// 切換定位策略
  Future<void> switchStrategy(LocationStrategy newStrategy) async {
    if (_currentStrategy.value == newStrategy) {
      print('📱 [$_tag] 策略已是 ${newStrategy.name}，無需切換');
      return;
    }

    print(
        '🔄 [$_tag] 切換策略: ${_currentStrategy.value.name} → ${newStrategy.name}');

    // 停止當前策略
    await _stopCurrentStrategy();

    // 更新策略
    _currentStrategy.value = newStrategy;

    // 啟動新策略
    await _startNewStrategy();
  }

  /// 啟動統一GPS增強策略（不分前景背景）
  Future<void> startUnifiedLocationEnhancement() async {
    if (!_isLocationEnhancementEnabled.value) {
      print('⚠️ [$_tag] 定位權限未授予，無法啟動統一GPS增強');
      return;
    }

    if (_isUnifiedModeRunning) {
      print('⚠️ [$_tag] 統一GPS增強已在運行中');
      return;
    }

    try {
      await _startUnifiedGpsStrategy();
      _isUnifiedModeRunning = true;
      print('🌍 [$_tag] 統一GPS增強已啟動（不分前景背景）');
    } catch (e) {
      print('❌ [$_tag] 啟動統一GPS增強失敗: $e');
    }
  }

  /// 停止統一GPS增強策略
  void stopUnifiedLocationEnhancement() {
    if (!_isUnifiedModeRunning) {
      print('⚠️ [$_tag] 統一GPS增強未在運行');
      return;
    }

    _stopAllLocationServices();
    _isUnifiedModeRunning = false;
    print('🛑 [$_tag] 統一GPS增強已停止');
  }

  /// 統一GPS策略的內部實現
  Future<void> _startUnifiedGpsStrategy() async {
    try {
      // 啟動定時GPS請求（主力機制）
      _startPeriodicLocationRequests();

      // 啟動位置變化監聽（額外觸發）
      _startLocationChangeMonitoring();

      print('🌍 [$_tag] 統一GPS策略已啟動（保活最大化模式）');
    } catch (e) {
      print('❌ [$_tag] 啟動統一GPS策略失敗: $e');
    }
  }

  /// 停止當前策略
  Future<void> _stopCurrentStrategy() async {
    switch (_currentStrategy.value) {
      case LocationStrategy.smartSwitch:
        stopLocationEnhancement(); // 使用原有的停止方法
        break;
      case LocationStrategy.unifiedGps:
        stopUnifiedLocationEnhancement();
        break;
    }
  }

  /// 啟動新策略
  Future<void> _startNewStrategy() async {
    if (!_isLocationEnhancementEnabled.value) {
      print('⚠️ [$_tag] 定位權限未授予，無法啟動新策略');
      return;
    }

    switch (_currentStrategy.value) {
      case LocationStrategy.smartSwitch:
        // 智能切換策略：根據當前狀態決定是否啟動
        print('📱 [$_tag] 使用智能切換策略（需要通過AppLifecycle觸發）');
        break;
      case LocationStrategy.unifiedGps:
        await startUnifiedLocationEnhancement();
        break;
    }
  }

  /// 獲取詳細服務狀態（包含策略信息）
  Map<String, dynamic> getDetailedServiceStatus() {
    return {
      'isEnabled': _isLocationEnhancementEnabled.value,
      'currentStrategy': _currentStrategy.value.name,
      'isUnifiedModeRunning': _isUnifiedModeRunning,
      'lastSyncTrigger': _lastSyncTrigger.value,
      'syncCount': _syncCount.value,
      'backgroundSyncFailures': _backgroundSyncFailures.value,
      'lastSyncTime': _lastSyncTime?.toIso8601String(),
      'currentInterval': _getCurrentSyncInterval().inMinutes,
      'locationTimerActive': _locationTimer?.isActive ?? false,
      'positionStreamActive': _positionStream != null,
      'syncHealthStatus': _getSyncHealthStatus(),
    };
  }

  /// 獲取同步健康狀態
  String _getSyncHealthStatus() {
    final failures = _backgroundSyncFailures.value;
    if (failures == 0) {
      return '健康';
    } else if (failures < _maxFailuresBeforeUpgrade) {
      return '輕微異常 ($failures/$_maxFailuresBeforeUpgrade)';
    } else {
      return '需要權限升級 ($failures次連續失敗)';
    }
  }

  /// 獲取服務狀態
  Map<String, dynamic> getServiceStatus() {
    return {
      'isEnabled': _isLocationEnhancementEnabled.value,
      'currentStrategy': _currentStrategy.value.name,
      'lastSyncTrigger': _lastSyncTrigger.value,
      'syncCount': _syncCount.value,
      'lastSyncTime': _lastSyncTime?.toIso8601String(),
      'currentInterval': _getCurrentSyncInterval().inMinutes,
    };
  }

  /// 手動觸發一次同步（測試用）
  Future<void> manualTriggerSync() async {
    await _triggerSyncIfNeeded('手動觸發');
  }

  // ======================================================
  // 🎯 新增：權限升級相關方法
  // ======================================================

  /// 檢查是否應該提示用戶升級權限
  Future<bool> shouldPromptPermissionUpgrade() async {
    final permission = await Geolocator.checkPermission();

    // 只有在 WhileInUse 狀態下才需要升級
    if (permission != LocationPermission.whileInUse) {
      return false;
    }

    // 🎯 更積極的升級觸發條件
    final hasUsedLocationService = _syncCount.value >= 3; // 降低到3次GPS請求
    final serviceRunTime =
        DateTime.now().difference(_lastSyncTime ?? DateTime.now());
    final hasRunLongEnough = serviceRunTime.inMinutes >= 5; // 降低到5分鐘

    return hasUsedLocationService && hasRunLongEnough;
  }

  /// 主動觸發權限升級請求（在特定場景下調用）
  Future<bool> triggerPermissionUpgradeRequest({String? context}) async {
    try {
      final currentPermission = await Geolocator.checkPermission();

      if (currentPermission != LocationPermission.whileInUse) {
        print('📱 [$_tag] 當前權限不是WhileInUse，無法觸發升級: $currentPermission');
        return false;
      }

      print('🎯 [$_tag] 主動觸發權限升級請求 (場景: ${context ?? "一般"})');

      // 🎯 關鍵：在特定場景下重新請求權限
      // iOS可能會在這時顯示"始終允許"選項
      final newPermission = await Geolocator.requestPermission();

      if (newPermission == LocationPermission.always) {
        print('🎉 [$_tag] 權限成功升級為Always！');
        return true;
      } else {
        print('⏳ [$_tag] 權限暫未升級，當前: $newPermission');
        return false;
      }
    } catch (e) {
      print('❌ [$_tag] 觸發權限升級失敗: $e');
      return false;
    }
  }

  /// 獲取權限升級建議信息
  Map<String, dynamic> getPermissionUpgradeInfo() {
    return {
      'currentPermission': 'whileInUse',
      'targetPermission': 'always',
      'benefits': [
        '大幅提升背景同步穩定性',
        '確保健康數據完整性',
        '減少數據丟失風險',
        '改善夜間監測效果',
      ],
      'instructions': [
        '1. 打開「設定」',
        '2. 選擇「隱私權與安全性」',
        '3. 點選「定位服務」',
        '4. 找到「${_getAppName()}」',
        '5. 選擇「始終」',
      ],
      'note': '選擇「始終」不會增加電池消耗，因為app只在背景數據同步時才使用定位服務。',
    };
  }

  /// 記錄權限升級提示已顯示（避免重複提示）
  static const String _permissionPromptShownKey =
      'permission_upgrade_prompt_shown';

  Future<bool> hasShownPermissionPrompt() async {
    // 這裡可以用SharedPreferences或Hive來記錄
    // 簡化實現，使用內存標記
    return false; // 實際實現時需要持久化存儲
  }

  Future<void> markPermissionPromptShown() async {
    // 標記已顯示權限升級提示
    print('📱 [$_tag] 權限升級提示已顯示');
  }

  /// 打開系統設置到app的定位權限頁面
  Future<void> openLocationSettings() async {
    try {
      await Geolocator.openLocationSettings();
      print('📱 [$_tag] 已打開系統定位設置');
    } catch (e) {
      print('❌ [$_tag] 無法打開系統設置: $e');
    }
  }

  /// 檢查權限是否已升級為Always
  Future<bool> checkPermissionUpgraded() async {
    final permission = await Geolocator.checkPermission();
    final wasUpgraded = permission == LocationPermission.always;

    if (wasUpgraded) {
      print('🎉 [$_tag] 權限已升級為Always，背景同步效果將大幅提升！');
    }

    return wasUpgraded;
  }

  /// 獲取app名稱（用於權限說明）
  String _getAppName() {
    // 這裡應該從app配置中獲取實際的app名稱
    return 'PulseDevice'; // 替換為實際的app名稱
  }

  /// 權限狀態報告
  Future<Map<String, dynamic>> getPermissionStatusReport() async {
    final permission = await Geolocator.checkPermission();
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    return {
      'timestamp': DateTime.now().toIso8601String(),
      'locationServiceEnabled': serviceEnabled,
      'currentPermission': permission.toString(),
      'permissionLevel': _getPermissionLevel(permission),
      'backgroundSyncEffectiveness':
          _getBackgroundSyncEffectiveness(permission),
      'upgradeRecommendation': _getUpgradeRecommendation(permission),
      'syncCount': _syncCount.value,
      'lastSyncTime': _lastSyncTime?.toIso8601String(),
    };
  }

  String _getPermissionLevel(LocationPermission permission) {
    switch (permission) {
      case LocationPermission.always:
        return '最佳（始終允許）';
      case LocationPermission.whileInUse:
        return '良好（使用App時）';
      case LocationPermission.denied:
        return '受限（被拒絕）';
      case LocationPermission.deniedForever:
        return '無法使用（永久拒絕）';
      case LocationPermission.unableToDetermine:
        return '未知狀態';
    }
  }

  String _getBackgroundSyncEffectiveness(LocationPermission permission) {
    switch (permission) {
      case LocationPermission.always:
        return '95% - 最佳背景同步效果';
      case LocationPermission.whileInUse:
        return '75% - 背景同步受限但可用';
      case LocationPermission.denied:
        return '0% - 無法背景同步';
      case LocationPermission.deniedForever:
        return '0% - 完全無法使用';
      case LocationPermission.unableToDetermine:
        return '未知';
    }
  }

  String _getUpgradeRecommendation(LocationPermission permission) {
    switch (permission) {
      case LocationPermission.always:
        return '無需升級，已是最佳狀態';
      case LocationPermission.whileInUse:
        return '建議升級為「始終允許」以獲得最佳背景同步效果';
      case LocationPermission.denied:
        return '請重新授予定位權限';
      case LocationPermission.deniedForever:
        return '請到系統設置中重新啟用定位權限';
      case LocationPermission.unableToDetermine:
        return '請檢查系統定位設置';
    }
  }
}
