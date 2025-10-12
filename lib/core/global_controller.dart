import 'dart:async';
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pp_bluetooth_kit_flutter/ble/pp_bluetooth_kit_manager.dart';
import 'package:pp_bluetooth_kit_flutter/enums/pp_scale_enums.dart';
import 'package:pp_bluetooth_kit_flutter/model/pp_device_model.dart';
import 'package:pp_bluetooth_kit_flutter/utils/pp_bluetooth_kit_logger.dart';
import 'package:pulsedevice/core/app_export.dart';
import 'package:pulsedevice/core/hiveDb/alert_record.dart';
import 'package:pulsedevice/core/hiveDb/alert_record_list.dart';
import 'package:pulsedevice/core/hiveDb/blood_oxygen_setting.dart';
import 'package:pulsedevice/core/hiveDb/body_temperature_setting.dart';
import 'package:pulsedevice/core/hiveDb/device_profile.dart';
import 'package:pulsedevice/core/hiveDb/family_member.dart';
import 'package:pulsedevice/core/hiveDb/goal_profile.dart';
import 'package:pulsedevice/core/service/firebase_analytics_service.dart';
import 'package:pulsedevice/core/hiveDb/heart_rate_setting.dart';
import 'package:pulsedevice/core/hiveDb/listen_setting.dart';
import 'package:pulsedevice/core/hiveDb/pressure_setting.dart';
import 'package:pulsedevice/core/hiveDb/remider_setting.dart';
import 'package:pulsedevice/core/hiveDb/sport_record.dart';
import 'package:pulsedevice/core/hiveDb/sport_record_list.dart';
import 'package:pulsedevice/core/hiveDb/user_profile.dart';
import 'package:pulsedevice/core/hiveDb/pp_device_profile.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/service/pp_scale_service.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/service/app_lifecycle_observer.dart';
import 'package:pulsedevice/core/service/location_enhancement_service.dart';
import 'package:pulsedevice/core/service/notification_service.dart';
import 'package:pulsedevice/core/service/pressure_calculation_service.dart';
import 'package:pulsedevice/core/service/sync_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';
import 'package:pulsedevice/core/sqliteDb/blood_pressure_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/combined_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/health_data_sync_service.dart';
import 'package:pulsedevice/core/sqliteDb/heart_rate_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/invasive_comprehensive_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/pressure_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/sleep_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/step_data_service.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/core/utils/firebase_helper.dart';
import 'package:pulsedevice/core/utils/permission_helper.dart';
import 'package:pulsedevice/core/utils/sync_background_taskhandler.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';

class GlobalController extends GetxController {
  static const platform = MethodChannel('firebase_notifications');

  ///--- life
  late AppLifecycleObserver lifecycleObserver;

  ///---- Db相關
  late final AppDatabase db;
  late final StepDataService stepDataService;
  late final SleepDataService sleepDataService;
  late final HeartRateDataService heartRateDataService;
  late final BloodPressureDataService bloodPressureDataService;
  late final CombinedDataService combinedDataService;
  late final InvasiveComprehensiveDataService invasiveComprehensiveDataService;
  late final HealthDataSyncService healthDataSyncService;
  late final PressureDataService pressureDataService;
  late final PressureCalculationService pressureCalculationService;
  late final SyncDataService syncDataService;
  ApiService apiService = ApiService();

  ///--- 藍牙狀態
  RxInt blueToolStatus = 0.obs;
  RxBool isBleConnect = false.obs;
  RxBool isBleLefuConnect = false.obs;
  Rx<PPBlePermissionState> isBleLefuPermission =
      Rx(PPBlePermissionState.unknown);

  ///--- 用戶資料
  RxString userEmail = ''.obs;

  ///--- 是否初始化sqlite
  var isSqfliteInit = false.obs;

  ///--- 用戶ID
  var userId = ''.obs;

  ///--- 登入後取得的API Token
  var apiToken = ''.obs;
  var apiId = ''.obs;

  ///--- Firebase Token
  var firebaseToken = ''.obs;

  ///--- 記錄bottombar index
  var bottomBarIndex = 0.obs;

  ///--- 紀錄是否已經
  var isSendSyncApi = "Y".obs;

  bool _isInitFuncRunning = false;

  int _previousBluetoothStatus = -1;

  DateTime? _lastSyncTime;

  /// 🎯 新增：通用防抖動管理器
  final Map<String, DateTime> _debounceTimers = {};

  ///--- 定位增強服務
  late LocationEnhancementService locationEnhancementService;

  ///--- 用戶基本資料
  var userName = "".obs;
  var userGender = "".obs;
  var userAge = "".obs;

  ///--- 從firebase取得的主用戶名
  var mainAcc = "".obs;

  ///--- 從firebase取得的副用戶名
  var subAcc = "".obs;

  ///--- 頭像url
  var avatarUrl = "".obs;

  ///--- 藍牙資料同步是否準備就緒
  final isBleDataReady = false.obs;

  ///--- 是否在運動
  final isSporting = false.obs;

  ///--- 家族ID
  final familyId = "".obs;
  final familyName = "".obs;

  ///--- 是否登出，影響自動登入
  final isLogout = false.obs;

  ///--- 諮詢暫存輸入字串
  final chatInput = "".obs;
  final chatApiKeyValue = "".obs;

  ///--- 磅秤設備管理（已遷移到 PPScaleService）

  ///--- 體重
  final bodyWeight = "".obs;

  ///--- 性別
  final gender = "".obs;

  ///--- 出生日期
  final birth = "".obs;

  ///--- 身高
  final bodyHeight = "".obs;

  // ✅ 添加事件分發系統
  final Map<String, List<Function(Map)>> _eventHandlers = {};

  /// 註冊事件處理器
  void registerEventHandler(String eventType, Function(Map) handler) {
    if (!_eventHandlers.containsKey(eventType)) {
      _eventHandlers[eventType] = [];
    }
    _eventHandlers[eventType]!.add(handler);
    print("✅ 註冊事件處理器: $eventType，目前共 ${_eventHandlers[eventType]!.length} 個");
  }

  /// 取消註冊事件處理器
  void unregisterEventHandler(String eventType, Function(Map) handler) {
    if (_eventHandlers.containsKey(eventType)) {
      _eventHandlers[eventType]!.remove(handler);
      print("❌ 取消事件處理器: $eventType，目前共 ${_eventHandlers[eventType]!.length} 個");
    }
  }

  @override
  void onInit() {
    super.onInit();
    lifecycleObserver = AppLifecycleObserver(this);
    WidgetsBinding.instance.addObserver(lifecycleObserver);
    init();

    // ✅ 監聽條件是否同時成立
    everAll([userId, blueToolStatus], (_) {
      if (userId.value.isNotEmpty && blueToolStatus.value == 2) {
        Future.delayed(const Duration(seconds: 2), () {
          initFunc();
        });
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    YcProductPlugin().cancelListening();

    // 磅秤 keepAlive 已由 PPScaleService 管理

    WidgetsBinding.instance.removeObserver(lifecycleObserver);
    db.close();
  }

  void init() async {
    await forceStopAllTasks();

    /// 初始化firebase
    hiveInit();
    sqfliteInit();
    YcProductPluginInit();
    lefuInit();

    /// 註冊 PPScaleService
    Get.put(PPScaleService());

    /// 初始化 Firebase Analytics
    await FirebaseAnalyticsService.instance.initialize();

    /// 🎯 順序權限請求：先通知權限，再位置權限
    await initNotificationWithLocationPermission();

    initBackgroundFetch();
    if (Platform.isIOS) {
      setupIosMessageChannel();
      print("✅ setupIosMessageChannel called from GlobalController");
    }
  }

  /// 初始化穿戴式sdk
  void YcProductPluginInit() async {
    // 初始化穿戴式sdk
    YcProductPlugin().initPlugin(isReconnectEnable: true, isLogEnable: true);
    // 啟動監聽
    YcProductPlugin().onListening((event) {
      print("=== GlobalController 統一監聽 Event: $event");
      print("=== Event keys: ${event.keys}");

      _distributeEvent(event);
    });
  }

  /// 事件分發核心邏輯
  void _distributeEvent(Map event) {
    try {
      // 處理每個事件類型
      for (String eventType in event.keys) {
        print("🔄 處理事件類型: $eventType");

        // 內建藍牙事件處理
        if (eventType == NativeEventType.bluetoothStateChange) {
          _handleInternalBluetoothEvent(event);
        }

        // 分發給註冊的處理器
        if (_eventHandlers.containsKey(eventType)) {
          final handlers = _eventHandlers[eventType]!;
          print("📨 分發給 ${handlers.length} 個處理器");

          for (Function(Map) handler in handlers) {
            try {
              handler(event);
            } catch (e) {
              print("❌ 事件處理器執行失敗 ($eventType): $e");
            }
          }
        }
      }
    } catch (e, stackTrace) {
      print("❌ 事件分發失敗: $e");
      print("❌ Stack trace: $stackTrace");
    }
  }

  void lefuInit() async {
    // Monitor logs
    PPBluetoothKitLogger.addListener(callBack: (log) {
      print('SDK-Log:$log');
    });
    final path = 'config/lefu.config';
    String content = await rootBundle.loadString(path);

    PPBluetoothKitManager.initSDK('lefub60060202a15ac8a',
        'UCzWzna/eazehXaz8kKAC6WVfcL25nIPYlV9fXYzqDM=', content);

    PPBluetoothKitManager.addBlePermissionListener(callBack: (permission) {
      print('Bluetooth permission state changed:$permission');
      isBleLefuPermission.value = permission;
    });

    PPBluetoothKitManager.addScanStateListener(callBack: (scanning) {
      print('Bluetooth scanning state changed:$scanning');
      isBleLefuConnect.value = scanning;
    });
  }

  /// 內部藍牙事件處理
  void _handleInternalBluetoothEvent(Map event) {
    final st = event[NativeEventType.bluetoothStateChange];
    print("🔵 處理藍牙狀態變化: $st (${st.runtimeType})");

    try {
      int bluetoothState;

      if (st is int) {
        bluetoothState = st;
        print("📱 使用 int 格式：$bluetoothState");
      } else if (st is Map && st.containsKey('bluetoothStateChange')) {
        bluetoothState = st['bluetoothStateChange'];
        print("📱 使用 Map 格式：$bluetoothState");
      } else {
        print("❌ 未知的藍牙狀態數據格式：$st");
        return;
      }

      _handleBluetoothStateChange(bluetoothState);
    } catch (e) {
      print("❌ 處理藍牙狀態變化時發生異常: $e");
    }
  }

  /// 初始化sqlite
  void sqfliteInit() async {
    if (isSqfliteInit.value) return;
    db = AppDatabase();
    stepDataService = StepDataService(db);
    sleepDataService = SleepDataService(db);
    heartRateDataService = HeartRateDataService(db);
    bloodPressureDataService = BloodPressureDataService(db);
    combinedDataService = CombinedDataService(db);
    invasiveComprehensiveDataService = InvasiveComprehensiveDataService(db);
    healthDataSyncService = HealthDataSyncService(db);
    syncDataService = SyncDataService(db: db, gc: this);
    pressureDataService = PressureDataService(db);
    pressureCalculationService = PressureCalculationService(db: db, gc: this);
    isSqfliteInit.value = true;
  }

  /// 初始化hive
  void hiveInit() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserProfileAdapter());
    Hive.registerAdapter(GoalProfileAdapter());
    Hive.registerAdapter(HeartRateSettingAdapter());
    Hive.registerAdapter(BloodOxygenSettingAdapter());
    Hive.registerAdapter(BodyTemperatureSettingAdapter());
    Hive.registerAdapter(DeviceProfileAdapter());
    Hive.registerAdapter(RemiderSettingAdapter());
    Hive.registerAdapter(AlertRecordAdapter());
    Hive.registerAdapter(AlertRecordListAdapter());
    Hive.registerAdapter(ListenSettingAdapter());
    Hive.registerAdapter(PressureSettingAdapter());
    Hive.registerAdapter(SportRecordAdapter());
    Hive.registerAdapter(SportRecordListAdapter());
    Hive.registerAdapter(FamilyMemberAdapter());
    Hive.registerAdapter(PPDeviceProfileAdapter());
    await Hive.openBox<UserProfile>('user_profile');
    await Hive.openBox<GoalProfile>('goal_profile');
    await Hive.openBox<HeartRateSetting>('heart_rate_setting');
    await Hive.openBox<BloodOxygenSetting>('blood_oxygen_setting');
    await Hive.openBox<BodyTemperatureSetting>('body_temperature_setting');
    await Hive.openBox<DeviceProfile>('device_profile');
    await Hive.openBox<RemiderSetting>('remider_setting');
    await Hive.openBox<AlertRecord>('alert_record');
    await Hive.openBox<AlertRecordList>('alert_records');
    await Hive.openBox<ListenSetting>('listen_setting');
    await Hive.openBox<PressureSetting>('pressure_setting');
    await Hive.openBox<SportRecord>('sport_record');
    await Hive.openBox<SportRecordList>('sport_record_list');
    await Hive.openBox<String>('notified_goals');
    await Hive.openBox<FamilyMember>('family_member');
    await Hive.openBox<PPDeviceProfile>('pp_device_profile');
  }

  /// 🎯 順序權限請求：先通知權限，再位置權限
  Future<void> initNotificationWithLocationPermission() async {
    // 1. 初始化通知服務
    final service = NotificationService();
    await service.initialize();

    // 2. 請求通知權限
    print('🔔 [GlobalController] 開始請求通知權限...');
    final notificationGranted =
        await PermissionHelper.checkNotificationPermission();
    print('🔔 [GlobalController] 通知權限結果: $notificationGranted');

    // 3. 通知權限完成後，請求位置權限
    if (notificationGranted) {
      print('✅ [GlobalController] 通知權限已授予，開始請求位置權限...');
      // 延遲一點時間，讓用戶看到通知權限結果
      await Future.delayed(const Duration(milliseconds: 500));

      // 初始化定位增強服務 (只請求權限，不啟動GPS)
      await initLocationEnhancementService(autoStart: false);
    } else {
      print('⚠️ [GlobalController] 通知權限被拒絕，仍會請求位置權限...');
      // 即使通知權限被拒絕，仍請求位置權限
      await Future.delayed(const Duration(milliseconds: 500));
      await initLocationEnhancementService(autoStart: false);
    }

    // 4. 初始化其他通知相關服務
    FlutterForegroundTask.initCommunicationPort();
    FlutterForegroundTask.addTaskDataCallback(_onReceiveTaskData);
    if (Platform.isAndroid) {
      await AndroidAlarmManager.initialize();
    }
  }

  /// 初始化通知（保留原方法，供其他地方使用）
  void initNotification() async {
    final service = NotificationService();
    await service.initialize();

    //  請求通知權限
    PermissionHelper.checkNotificationPermission();
    // Initialize port for communication between TaskHandler and UI.
    FlutterForegroundTask.initCommunicationPort();
    FlutterForegroundTask.addTaskDataCallback(_onReceiveTaskData);
    if (Platform.isAndroid) {
      await AndroidAlarmManager.initialize();
    }
  }

  /// 初始化定位增強服務
  Future<void> initLocationEnhancementService({bool autoStart = true}) async {
    try {
      locationEnhancementService = Get.put(LocationEnhancementService());

      if (autoStart) {
        // 傳統模式：立即啟動GPS增強
        await locationEnhancementService.requestPermissionAndInitialize();
        print('✅ [GlobalController] 定位增強服務初始化並啟動完成');
      } else {
        // 智能模式：只請求權限，不啟動GPS（省電）
        await locationEnhancementService.requestPermissionOnly();
        print('✅ [GlobalController] 定位增強服務初始化完成（待啟動狀態）');
      }
    } catch (e) {
      print('❌ [GlobalController] 定位增強服務初始化失敗: $e');
    }
  }

  // ======================================================
  // 🎯 新增：統一GPS策略控制接口
  // ======================================================

  /// 切換到統一GPS策略（不分前景背景都運行）
  Future<void> enableUnifiedGpsStrategy() async {
    try {
      // 🎯 啟用統一GPS前，主動請求Always權限
      final hasAlways = await hasAlwaysLocationPermission();
      if (!hasAlways) {
        print('💡 [GlobalController] 統一GPS需要最佳權限，主動請求Always...');
        await requestAlwaysPermissionForUnifiedGps();
      }

      await locationEnhancementService
          .switchStrategy(LocationStrategy.unifiedGps);
      print('✅ [GlobalController] 已切換到統一GPS策略');
    } catch (e) {
      print('❌ [GlobalController] 切換到統一GPS策略失敗: $e');
    }
  }

  /// 切換到智能切換策略（前景省電，背景增強）
  Future<void> enableSmartSwitchStrategy() async {
    try {
      await locationEnhancementService
          .switchStrategy(LocationStrategy.smartSwitch);
      print('✅ [GlobalController] 已切換到智能切換策略');
    } catch (e) {
      print('❌ [GlobalController] 切換到智能切換策略失敗: $e');
    }
  }

  /// 獲取當前定位策略
  LocationStrategy getCurrentLocationStrategy() {
    return locationEnhancementService.currentStrategy;
  }

  /// 獲取定位增強服務詳細狀態
  Map<String, dynamic> getLocationEnhancementStatus() {
    return locationEnhancementService.getDetailedServiceStatus();
  }

  // ======================================================
  // 🎯 新增：定位權限升級管理接口
  // ======================================================

  /// 檢查是否應該提示權限升級
  Future<bool> shouldPromptLocationPermissionUpgrade() async {
    try {
      return await locationEnhancementService.shouldPromptPermissionUpgrade();
    } catch (e) {
      print('❌ [GlobalController] 檢查權限升級提示失敗: $e');
      return false;
    }
  }

  /// 獲取當前定位權限狀態
  Future<LocationPermission> getCurrentLocationPermission() async {
    return await locationEnhancementService.currentPermission;
  }

  /// 檢查是否有Always權限
  Future<bool> hasAlwaysLocationPermission() async {
    return await locationEnhancementService.hasAlwaysPermission;
  }

  /// 檢查是否可以升級權限
  Future<bool> canUpgradeLocationPermission() async {
    return await locationEnhancementService.canUpgradeToAlways;
  }

  /// 獲取權限升級信息
  Map<String, dynamic> getLocationPermissionUpgradeInfo() {
    return locationEnhancementService.getPermissionUpgradeInfo();
  }

  /// 打開系統定位設置
  Future<void> openLocationSettings() async {
    try {
      await locationEnhancementService.openLocationSettings();
      print('✅ [GlobalController] 已引導用戶到定位設置');
    } catch (e) {
      print('❌ [GlobalController] 打開定位設置失敗: $e');
    }
  }

  /// 檢查權限是否已升級
  Future<bool> checkLocationPermissionUpgraded() async {
    return await locationEnhancementService.checkPermissionUpgraded();
  }

  /// 獲取詳細的權限狀態報告
  Future<Map<String, dynamic>> getLocationPermissionStatusReport() async {
    return await locationEnhancementService.getPermissionStatusReport();
  }

  /// 🎯 新增：通用防抖動檢查方法
  bool shouldExecute(String actionKey, {Duration? interval}) {
    final minInterval = interval ?? const Duration(seconds: 15);
    final now = DateTime.now();

    if (_debounceTimers.containsKey(actionKey)) {
      final lastTime = _debounceTimers[actionKey]!;
      final timeDiff = now.difference(lastTime);
      if (timeDiff < minInterval) {
        print("🚫 防抖動：$actionKey 距離上次執行僅 ${timeDiff.inSeconds}秒，跳過");
        return false;
      }
    }

    _debounceTimers[actionKey] = now;
    print("✅ 防抖動：$actionKey 執行通過，記錄時間");
    return true;
  }

  /// 🎯 新增：清除特定動作的防抖動記錄
  void clearDebounce(String actionKey) {
    _debounceTimers.remove(actionKey);
    print("🧹 防抖動：已清除 $actionKey 的記錄");
  }

  /// 🎯 新增：檢查App是否在前景
  bool isAppInForeground() {
    return WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed;
  }

  /// 🎯 新增：公開的事件分發方法
  void distributeEvent(Map event) {
    _distributeEvent(event);
  }

  /// 智能權限升級檢查（在app啟動和重要時機調用）
  Future<void> smartLocationPermissionCheck() async {
    try {
      print('🔍 [GlobalController] 執行智能權限檢查...');

      final permission = await getCurrentLocationPermission();
      print('📱 [GlobalController] 當前權限狀態: $permission');

      if (permission == LocationPermission.whileInUse) {
        final shouldPrompt = await shouldPromptLocationPermissionUpgrade();

        if (shouldPrompt) {
          print('💡 [GlobalController] 建議提示用戶升級權限');
          // 這裡可以觸發UI顯示權限升級建議
          // 實際實現時可以通過事件或回調通知UI層
        } else {
          print('⏳ [GlobalController] 暫時不需要提示權限升級');
        }
      } else if (permission == LocationPermission.always) {
        print('🎉 [GlobalController] 已有Always權限，背景同步效果最佳');
      } else {
        print('⚠️ [GlobalController] 權限狀態需要關注: $permission');
      }

      // 記錄權限狀態到日誌
      final report = await getLocationPermissionStatusReport();
      print('📊 [GlobalController] 權限狀態報告: $report');
    } catch (e) {
      print('❌ [GlobalController] 智能權限檢查失敗: $e');
    }
  }

  /// 主動觸發權限升級（在特定場景下調用）
  Future<bool> triggerLocationPermissionUpgrade({String? context}) async {
    try {
      return await locationEnhancementService.triggerPermissionUpgradeRequest(
          context: context);
    } catch (e) {
      print('❌ [GlobalController] 觸發權限升級失敗: $e');
      return false;
    }
  }

  /// 健康監測場景權限升級（當開始健康監測時調用）
  Future<bool> requestAlwaysPermissionForHealthMonitoring() async {
    try {
      print('🏥 [GlobalController] 為健康監測功能請求Always權限...');

      final success =
          await triggerLocationPermissionUpgrade(context: '健康監測背景同步');

      if (success) {
        print('🎉 [GlobalController] 健康監測權限升級成功，將大幅提升數據穩定性！');
      } else {
        print('⏳ [GlobalController] 權限暫未升級，將在後續適當時機再次嘗試');
      }

      return success;
    } catch (e) {
      print('❌ [GlobalController] 健康監測權限升級失敗: $e');
      return false;
    }
  }

  /// 統一GPS模式權限升級（當啟用統一GPS時調用）
  Future<bool> requestAlwaysPermissionForUnifiedGps() async {
    try {
      print('🌍 [GlobalController] 為統一GPS模式請求Always權限...');

      final success =
          await triggerLocationPermissionUpgrade(context: '統一GPS背景保活');

      if (success) {
        print('🎉 [GlobalController] 統一GPS權限升級成功，背景保活效果最佳！');
      }

      return success;
    } catch (e) {
      print('❌ [GlobalController] 統一GPS權限升級失敗: $e');
      return false;
    }
  }

  initFunc() async {
    if (_isInitFuncRunning) return;

    /// 只初始化一次
    startForegroundTask();
    // ✅ 藍牙連上後立即同步一次
    await safeRunSync();
    // initGoal();
    Future.delayed(const Duration(milliseconds: 500), () {
      // getGoalTargetData(goalNotificationService);
      _isInitFuncRunning = true;
      NotificationService().showDeviceConnectedNotification();
    });

    // 🎯 藍牙連接後執行權限升級策略
    Future.delayed(const Duration(seconds: 5), () {
      smartLocationPermissionCheck();
    });

    // 🎯 藍牙連接是關鍵時機，主動嘗試權限升級
    Future.delayed(const Duration(seconds: 10), () async {
      final canUpgrade = await canUpgradeLocationPermission();
      if (canUpgrade) {
        print('💡 [GlobalController] 藍牙連接後，為健康監測請求Always權限...');
        await requestAlwaysPermissionForHealthMonitoring();
      }
    });
  }

  void _onReceiveTaskData(Object data) async {
    final map = data as Map<String, dynamic>;
    if (map['trigger'] == true) {
      // 由 Task 驅動的同步邏輯
      await safeRunSync();
    }
  }

  Future<void> startForegroundTask() async {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'sync_task',
        channelName: 'Background Sync',
        channelDescription: 'Background sync every 5 minutes',
        onlyAlertOnce: true,
      ),
      iosNotificationOptions: IOSNotificationOptions(showNotification: false),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(300000), // 5 分鐘
        autoRunOnBoot: true,
        autoRunOnMyPackageReplaced: true,
      ),
    );

    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.restartService();
    } else {
      await FlutterForegroundTask.startService(
        serviceId: 1,
        notificationTitle: '同步服務正在運行',
        notificationText: '每 5 分鐘同步資料',
        callback: startCallback,
      );
    }
  }

  Future<void> stopForegroundTask() async {
    FlutterForegroundTask.removeTaskDataCallback(_onReceiveTaskData);
    await FlutterForegroundTask.stopService();
  }

  Future<void> pauseBackgroundSync() async {
    FlutterForegroundTask.removeTaskDataCallback(_onReceiveTaskData);
    await FlutterForegroundTask.stopService();
  }

  Future<void> resumeBackgroundSync() async {
    await startForegroundTask(); // 你原本的邏輯
  }

  Future<bool> getBlueToothDeviceInfo() async {
    var res = false;
    PluginResponse<DeviceBasicInfo>? deviceBasicInfo =
        await YcProductPlugin().queryDeviceBasicInfo();
    if (deviceBasicInfo != null && deviceBasicInfo.statusCode == 0) {
      if (deviceBasicInfo.data.batteryPower < 20) {
        NotificationService().showDeviceLowPowerNotification();
      }
      res = true;
    }
    return res;
  }

  /// 背景同步，anroid沒問題，但ios有限制
  void initBackgroundFetch() {
    BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 5,
        stopOnTerminate: false,
        enableHeadless: true,
        startOnBoot: true,
        requiredNetworkType: NetworkType.ANY,
      ),
      (String taskId) async {
        try {
          final log = "[BackgroundFetch] Event received: $taskId";
          print(log);
          await logToDisk(log);
          await apiService.sendLog(json: log, logType: "DEBUG");
          await safeRunSync(); // 你自己的任務邏輯
        } catch (e, st) {
          final errLog = "❌ Error: $e\n$st";
          print(errLog);
          await logToDisk(errLog);
        } finally {
          BackgroundFetch.finish(taskId);
        }
      },
      (String taskId) async {
        final timeoutLog = "⚠️ BackgroundFetch TIMEOUT: $taskId";
        print(timeoutLog);
        await logToDisk(timeoutLog);
        BackgroundFetch.finish(taskId);
      },
    );
  }

  Future<void> safeRunSync() async {
    final now = DateTime.now();
    final time = now.toIso8601String();
    final content = "✅ safeRunSync executed at $time";
    print(content);
    await logToDisk(content);
    if (_lastSyncTime != null &&
        now.difference(_lastSyncTime!).inSeconds < 15) {
      return;
    }
    _lastSyncTime = now;
    await syncDataService.runBackgroundSync();
    await getBlueToothDeviceInfo();
    isBleDataReady.value = true;
  }

  void _handleBluetoothStateChange(int newStatus) async {
    print("_handleBluetoothStateChange : $newStatus");
    // if (newStatus == _previousBluetoothStatus) return;
    // _previousBluetoothStatus = newStatus;

    blueToolStatus.value = newStatus;
    print('🔄 藍牙狀態改變：$newStatus');

    switch (newStatus) {
      case 2:
        if (userId.value.isNotEmpty) {
          isBleConnect.value = true;

          initFunc();
          await apiService.sendLog(json: "藍牙連線成功", logType: "DEBUG");
        }
        break;
      case 0:
      case 3:
      case 4:
        isBleConnect.value = false;

        if (_isInitFuncRunning) {
          // NotificationService().showDeviceDisconnectedNotification();
          stopForegroundTask();
        }
        await apiService.sendLog(json: "藍牙連線中斷", logType: "WARN");
        break;
    }
  }

  Future<void> postApi(String main) async {
    try {
      final payload = {
        "userId": main,
        "familyId": apiId.value,
        "notify": true //緊報通知
      };
      var res = await apiService.postJson(
        Api.familyBiding,
        payload,
      );

      if (res.isNotEmpty) {}
    } catch (e) {
      print("Notify API Error: $e");
    }
  }

  Future<void> logToDisk(String content) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/bg_log.txt");
      await file.writeAsString("${DateTime.now()}: $content\n",
          mode: FileMode.append);
    } catch (e) {
      print("❌ Failed to write log: $e");
    }
  }

  /// for ios channel
  void setupIosMessageChannel() {
    platform.setMethodCallHandler((call) async {
      if (call.method == 'alertDialog') {
        final raw = call.arguments as String;
        print("📨 iOS 收到資料: $raw");

        // 解析自訂格式的資料
        if (raw.contains(';')) {
          final split = raw.split(';');
          final main = split[0];
          final nickName = split[1];
          final relation = split[2];
          final notifyToken = split[3];

          final payload = {
            "alertDialog": "$main;$nickName;$relation;$notifyToken"
          };

          final fakeMessage = RemoteMessage(data: payload);
          await FirebaseHelper.handleMessage(fakeMessage);
        } else if (raw.contains('true')) {
          /// confirm 的dialog
          Future.delayed(Duration(seconds: 1), () async {
            final comfirm = await DialogHelper.showFamilyConfirmDialog();
            if (comfirm!) {
              Get.back(result: true);
            }
          });
        }
      }
    });
  }

  /// 強制停止所有排程任務
  Future<void> forceStopAllTasks() async {
    try {
      // 停止 FlutterForegroundTask
      if (await FlutterForegroundTask.isRunningService) {
        await FlutterForegroundTask.stopService();
        print("🛑 強制停止 FlutterForegroundTask");
      }

      // 停止 BackgroundFetch
      await BackgroundFetch.stop();
      print("🛑 強制停止 BackgroundFetch");
    } catch (e) {
      print("❌ 停止排程任務時發生錯誤: $e");
    }
  }

  /// 取得 PPScaleService 實例
  PPScaleService get ppScaleService => Get.find<PPScaleService>();

  /// 檢查磅秤是否已連線（委託給 Service）
  bool get hasPPDeviceConnected => ppScaleService.hasConnectedDevice;

  /// 取得當前連線的磅秤設備（委託給 Service）
  PPDeviceModel? get connectedPPDevice => ppScaleService.connectedDevice;

  /// 更新磅秤連線狀態（委託給 Service）
  void updatePPDeviceConnectionStatus(bool isConnected) {
    // 這個方法現在由 PPScaleService 內部管理
    print('📊 GlobalController: 磅秤連線狀態更新請求: $isConnected');
  }
}
