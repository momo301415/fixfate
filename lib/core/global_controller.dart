import 'dart:async';
import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
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
import 'package:pulsedevice/core/service/sync_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';
import 'package:pulsedevice/core/sqliteDb/blood_pressure_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/combined_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/health_data_sync_service.dart';
import 'package:pulsedevice/core/sqliteDb/heart_rate_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/invasive_comprehensive_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/sleep_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/step_data_service.dart';
import 'package:pulsedevice/core/utils/permission_helper.dart';
import 'package:pulsedevice/core/utils/snackbar_helper.dart';
import 'package:pulsedevice/core/utils/sync_background_taskhandler.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';

class GlobalController extends GetxController {
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
  late final SyncDataService syncDataService;
  ApiService apiService = ApiService();

  ///--- 藍牙狀態
  RxInt blueToolStatus = 0.obs;

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
  var bottomBarIndex = 2.obs;

  ///--- 紀錄是否已經
  var isSendSyncApi = "Y".obs;

  bool _isInitFuncRunning = false;

  int _previousBluetoothStatus = -1;

  DateTime? _lastSyncTime;

  late GoalNotificationService goalNotificationService;

  ///--- 用戶名
  var userName = "".obs;

  ///--- 從firebase取得的主用戶名
  var mainAcc = "".obs;

  ///--- 從firebase取得的副用戶名
  var subAcc = "".obs;

  ///--- 頭像url
  var avatarUrl = "".obs;

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
    /// 初始化firebase
    hiveInit();
    sqfliteInit();
    YcProductPluginInit();
    initNotification();
    initBackgroundFetch();
  }

  /// 初始化穿戴式sdk
  void YcProductPluginInit() async {
    // 初始化穿戴式sdk
    YcProductPlugin().initPlugin(isReconnectEnable: true, isLogEnable: true);
    // 啟動監聽
    YcProductPlugin().onListening((event) {
      if (event.keys.contains(NativeEventType.bluetoothStateChange)) {
        _handleBluetoothStateChange(
            event[NativeEventType.bluetoothStateChange]);
      }
    });
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
  }

  initGoal() async {
    goalNotificationService = await GoalNotificationService(
      userId: userId.value,
      stepService: stepDataService,
      sleepService: sleepDataService,
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
      SnackbarHelper.showBlueSnackbar(message: "snackbar_bluetooth_connect".tr);
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
          debugPrint(log);
          await logToDisk(log);
          await apiService.sendLog(json: log, logType: "DEBUG");
          await safeRunSync(); // 你自己的任務邏輯
        } catch (e, st) {
          final errLog = "❌ Error: $e\n$st";
          debugPrint(errLog);
          await logToDisk(errLog);
        } finally {
          BackgroundFetch.finish(taskId);
        }
      },
      (String taskId) async {
        final timeoutLog = "⚠️ BackgroundFetch TIMEOUT: $taskId";
        debugPrint(timeoutLog);
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
    debugPrint(content);
    await logToDisk(content);
    if (_lastSyncTime != null &&
        now.difference(_lastSyncTime!).inSeconds < 15) {
      return;
    }
    _lastSyncTime = now;
    await syncDataService.runBackgroundSync();
    await getBlueToothDeviceInfo();
  }

  void _handleBluetoothStateChange(int newStatus) {
    if (newStatus == _previousBluetoothStatus) return;
    _previousBluetoothStatus = newStatus;

    blueToolStatus.value = newStatus;
    debugPrint('🔄 藍牙狀態改變：$newStatus');

    switch (newStatus) {
      case 2:
        if (userId.value.isNotEmpty) {
          initFunc();
        }
        break;
      case 0:
      case 3:
        if (_isInitFuncRunning) {
          NotificationService().showDeviceDisconnectedNotification();
          stopForegroundTask();
        }
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
      debugPrint("❌ Failed to write log: $e");
    }
  }
}
