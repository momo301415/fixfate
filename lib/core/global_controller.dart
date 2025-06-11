import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pulsedevice/core/app_export.dart';
import 'package:pulsedevice/core/hiveDb/alert_record.dart';
import 'package:pulsedevice/core/hiveDb/alert_record_list.dart';
import 'package:pulsedevice/core/hiveDb/blood_oxygen_setting.dart';
import 'package:pulsedevice/core/hiveDb/body_temperature_setting.dart';
import 'package:pulsedevice/core/hiveDb/device_profile.dart';
import 'package:pulsedevice/core/hiveDb/goal_profile.dart';
import 'package:pulsedevice/core/hiveDb/heart_rate_setting.dart';
import 'package:pulsedevice/core/hiveDb/listen_setting.dart';
import 'package:pulsedevice/core/hiveDb/pressure_setting.dart';
import 'package:pulsedevice/core/hiveDb/remider_setting.dart';
import 'package:pulsedevice/core/hiveDb/sport_record.dart';
import 'package:pulsedevice/core/hiveDb/sport_record_list.dart';
import 'package:pulsedevice/core/hiveDb/user_profile.dart';
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
import 'package:yc_product_plugin/yc_product_plugin.dart';

class GlobalController extends GetxController {
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

  Timer? _syncTimer;

  ///--- 記錄bottombar index
  var bottomBarIndex = 2.obs;

  ///--- 紀錄是否已經
  var isSendSyncApi = "Y".obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  void onClose() {
    super.onClose();
    stopSyncTimer();
    db.close();
  }

  void init() async {
    /// 初始化firebase
    hiveInit();
    sqfliteInit();
    YcProductPluginInit();
    initNotification();
  }

  /// 初始化穿戴式sdk
  void YcProductPluginInit() async {
    // 初始化穿戴式sdk
    YcProductPlugin().initPlugin(isReconnectEnable: true, isLogEnable: true);
    // 啟動監聽
    YcProductPlugin().onListening((event) {
      if (event.keys.contains(NativeEventType.bluetoothStateChange)) {
        final int st = event[NativeEventType.bluetoothStateChange];
        debugPrint('藍牙狀態變更：$st');
        blueToolStatus.value = st;
        if (st == 2) {
          print(" ====== 初始化sqlite ====== ");
          if (userId.value.isNotEmpty) {
            /// 只初始化一次
            startSyncTimer();
            isSqfliteInit.value = true;
          }
        } else if (isSqfliteInit.value && st != 2 && st != 1) {
          NotificationService().showDeviceDisconnectedNotification();
        }
      }
    });
  }

  /// 初始化sqlite
  void sqfliteInit() async {
    db = AppDatabase();
    stepDataService = StepDataService(db);
    sleepDataService = SleepDataService(db);
    heartRateDataService = HeartRateDataService(db);
    bloodPressureDataService = BloodPressureDataService(db);
    combinedDataService = CombinedDataService(db);
    invasiveComprehensiveDataService = InvasiveComprehensiveDataService(db);
    healthDataSyncService = HealthDataSyncService(db);
    syncDataService = SyncDataService(db: db, gc: this);
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
  }

  void initNotification() async {
    final service = NotificationService();
    await service.initialize();

    //  請求通知權限
    PermissionHelper.checkNotificationPermission();
  }

  void startSyncTimer() {
    stopSyncTimer();
    _syncTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      syncDataService.runBackgroundSync();

      ///電量偵測推播
      getBlueToothDeviceInfo();
    });
    syncDataService.runBackgroundSync(); // ✅ 初始執行一次
  }

  void stopSyncTimer() {
    _syncTimer?.cancel();
  }

  Future<void> getBlueToothDeviceInfo() async {
    PluginResponse<DeviceBasicInfo>? deviceBasicInfo =
        await YcProductPlugin().queryDeviceBasicInfo();
    if (deviceBasicInfo != null && deviceBasicInfo.statusCode == 0) {
      if (deviceBasicInfo.data.batteryPower < 20) {
        NotificationService().showDeviceDisconnectedNotification();
      }
    }
  }
}
