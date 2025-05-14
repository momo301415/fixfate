import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pulsedevice/core/app_export.dart';
import 'package:pulsedevice/core/hiveDb/blood_oxygen_setting.dart';
import 'package:pulsedevice/core/hiveDb/body_temperature_setting.dart';
import 'package:pulsedevice/core/hiveDb/device_profile.dart';
import 'package:pulsedevice/core/hiveDb/goal_profile.dart';
import 'package:pulsedevice/core/hiveDb/heart_rate_setting.dart';
import 'package:pulsedevice/core/hiveDb/remider_setting.dart';
import 'package:pulsedevice/core/hiveDb/user_profile.dart';
import 'package:pulsedevice/core/service/notification_service.dart';
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

  ///--- 藍牙狀態
  RxInt blueToolStatus = 0.obs;

  ///--- 用戶資料
  RxString userEmail = ''.obs;

  ///--- 是否初始化sqlite
  var isSqfliteInit = false.obs;

  ///--- 用戶ID
  var userId = 'temp_user'.obs;

  var apiToken = ''.obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  void onClose() {
    super.onClose();
    healthDataSyncService.stop();
    db.close();
  }

  void init() async {
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
          if (!isSqfliteInit.value && userId.value.isNotEmpty) {
            /// 只初始化一次
            healthDataSyncService.start();
            isSqfliteInit.value = true;
          }
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
    initHealthServiceDB();
  }

  void initHealthServiceDB() {
    healthDataSyncService = HealthDataSyncService(db);
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
    await Hive.openBox<UserProfile>('user_profile');
    await Hive.openBox<GoalProfile>('goal_profile');
    await Hive.openBox<HeartRateSetting>('heart_rate_setting');
    await Hive.openBox<BloodOxygenSetting>('blood_oxygen_setting');
    await Hive.openBox<BodyTemperatureSetting>('body_temperature_setting');
    await Hive.openBox<DeviceProfile>('device_profile');
    await Hive.openBox<RemiderSetting>('remider_setting');
  }

  void initNotification() async {
    final service = NotificationService();
    await service.initialize();

    // Android 13+ 請求通知權限
    if (Platform.isAndroid) {
      PermissionHelper.checkNotificationPermission();
    }
  }
}
