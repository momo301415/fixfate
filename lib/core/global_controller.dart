import 'dart:async';
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pulsedevice/core/app_export.dart';
import 'package:pulsedevice/core/hiveDb/alert_record.dart';
import 'package:pulsedevice/core/hiveDb/alert_record_list.dart';
import 'package:pulsedevice/core/hiveDb/blood_oxygen_setting.dart';
import 'package:pulsedevice/core/hiveDb/body_temperature_setting.dart';
import 'package:pulsedevice/core/hiveDb/device_profile.dart';
import 'package:pulsedevice/core/hiveDb/family_member.dart';
import 'package:pulsedevice/core/hiveDb/goal_profile.dart';
import 'package:pulsedevice/core/hiveDb/heart_rate_setting.dart';
import 'package:pulsedevice/core/hiveDb/listen_setting.dart';
import 'package:pulsedevice/core/hiveDb/pressure_setting.dart';
import 'package:pulsedevice/core/hiveDb/remider_setting.dart';
import 'package:pulsedevice/core/hiveDb/sport_record.dart';
import 'package:pulsedevice/core/hiveDb/sport_record_list.dart';
import 'package:pulsedevice/core/hiveDb/user_profile.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/service/app_lifecycle_observer.dart';
import 'package:pulsedevice/core/service/goal_notification_service.dart';
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
import 'package:pulsedevice/core/utils/firebase_helper.dart';
import 'package:pulsedevice/core/utils/permission_helper.dart';
import 'package:pulsedevice/core/utils/snackbar_helper.dart';
import 'package:pulsedevice/core/utils/sync_background_taskhandler.dart';
import 'package:pulsedevice/presentation/k5_screen/controller/k5_controller.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';

class GlobalController extends GetxController {
  static const platform = MethodChannel('test_channel');

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
  var bottomBarIndex = 1.obs;

  ///--- 紀錄是否已經
  var isSendSyncApi = "Y".obs;

  bool _isInitFuncRunning = false;

  int _previousBluetoothStatus = -1;

  DateTime? _lastSyncTime;

  late GoalNotificationService goalNotificationService;

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

    WidgetsBinding.instance.removeObserver(lifecycleObserver);
    db.close();
  }

  void init() async {
    await forceStopAllTasks();

    /// 初始化firebase
    hiveInit();
    sqfliteInit();
    YcProductPluginInit();
    initNotification();
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
  }

  /// 初始化通知
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

  initGoal() async {
    goalNotificationService = await GoalNotificationService(
      userId: userId.value,
    );
  }

  initFunc() async {
    if (_isInitFuncRunning) return;

    /// 只初始化一次
    startForegroundTask();
    // ✅ 藍牙連上後立即同步一次
    await safeRunSync();
    initGoal();
    Future.delayed(const Duration(milliseconds: 500), () {
      getGoalTargetData(goalNotificationService);
      _isInitFuncRunning = true;
      NotificationService().showDeviceConnectedNotification();
    });
  }

  void _onReceiveTaskData(Object data) async {
    final map = data as Map<String, dynamic>;
    if (map['trigger'] == true) {
      // 由 Task 驅動的同步邏輯
      await safeRunSync();
      getGoalTargetData(goalNotificationService);
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

  Future<void> getGoalTargetData(GoalNotificationService service) async {
    service.checkTodayGoalsAndNotify();
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
    if (newStatus == _previousBluetoothStatus) return;
    _previousBluetoothStatus = newStatus;

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
          NotificationService().showDeviceDisconnectedNotification();
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

  /// channel
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
}
