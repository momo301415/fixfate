import 'dart:convert';

import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/alert_record.dart';
import 'package:pulsedevice/core/hiveDb/alert_record_list_storage.dart';
import 'package:pulsedevice/core/hiveDb/blood_oxygen_setting.dart';
import 'package:pulsedevice/core/hiveDb/blood_oxygen_setting_storage.dart';
import 'package:pulsedevice/core/hiveDb/body_temperature_setting.dart';
import 'package:pulsedevice/core/hiveDb/body_temperature_setting_storage.dart';
import 'package:pulsedevice/core/hiveDb/goal_profile.dart';
import 'package:pulsedevice/core/hiveDb/goal_profile_storage.dart';
import 'package:pulsedevice/core/hiveDb/heart_rate_setting.dart';
import 'package:pulsedevice/core/hiveDb/heart_rate_setting_storage.dart';
import 'package:pulsedevice/core/hiveDb/pressure_setting.dart';
import 'package:pulsedevice/core/hiveDb/pressure_setting_storage.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/service/notification_service.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';

import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/core/utils/pref_utils.dart';

class SyncDataService {
  final AppDatabase db;
  final GlobalController gc;
  ApiService service = ApiService();
  ApiAwsService2 awsService = ApiAwsService2();
  SyncDataService({required this.db, required this.gc});

  final Map<int, String> sleepTypeToRecordType = {
    241: 'sleep-deep',
    242: 'sleep-light',
    243: 'sleep-rem',
    244: 'sleep-awake',
  };

  Future<void> runBackgroundSync() async {
    await gc.healthDataSyncService.fetchAndStoreData();
    await Future.delayed(Duration.zero);

    // ✅ 新增：計算壓力數據
    await gc.pressureCalculationService.calculatePressureData();
    await Future.delayed(Duration.zero);
    final pRes = await PrefUtils().getIsSyncAlertApi();
    if (pRes.isEmpty) {
      await syncAlertToApi();
      await PrefUtils().setIsSyncAlertApi("true");
    }

    await Future.delayed(Duration.zero);
    await gc.healthDataSyncService.syncHealthData();
    await Future.delayed(Duration.zero);
    await syncToApi();
  }

  ///------ 同步資料到API -----
  Future<void> syncToApi() async {
    if (gc.userId.value.isEmpty) return;
    var isSyncValue = "N";
    final isSyncApi = await PrefUtils().getIsSyncApi();
    if (isSyncApi.isEmpty) {
      await PrefUtils().setIsSyncApi("Y");
      isSyncValue = "Y";
    }
    final records = await AlertRecordListStorage.getRecords(gc.userId.value);
    List<AlertRecord> rateRecords = [];
    List<AlertRecord> bloodRecords = [];
    List<AlertRecord> tempRecords = [];
    List<AlertRecord> pressureRecords = [];
    for (var record in records) {
      if (record.type.contains("heart_rate") && record.synced == false) {
        rateRecords.add(record);
      } else if (record.type.contains("blood_oxygen") &&
          record.synced == false) {
        bloodRecords.add(record);
      } else if (record.type.contains("temperature") &&
          record.synced == false) {
        tempRecords.add(record);
      } else if (record.type.contains("pressure") && record.synced == false) {
        pressureRecords.add(record);
      }
    }

    // 步數資料
    final unsyncedSteps =
        await gc.stepDataService.getUnsyncedData(gc.userId.value);
    if (unsyncedSteps.isNotEmpty) {
      final success = await uploadSteps(unsyncedSteps, isSyncValue);
      final success2 = await uploadCalories(unsyncedSteps, isSyncValue);
      final success3 = await uploadDistance(unsyncedSteps, isSyncValue);
      if (success && success2 && success3) {
        await gc.stepDataService.markAsSynced(unsyncedSteps);
      }
    }

    /// 心跳資料
    final unsyncedHeartRate =
        await gc.heartRateDataService.getUnsyncedData(gc.userId.value);
    if (unsyncedHeartRate.isNotEmpty) {
      final success =
          await uploadHeartRate(unsyncedHeartRate, isSyncValue, a: rateRecords);
      if (success) {
        await gc.heartRateDataService.markAsSynced(unsyncedHeartRate);
      }
    }

    // 睡眠資料
    final unsyncedSleep =
        await gc.sleepDataService.getUnsyncedData(gc.userId.value);
    final unsyncedSleepDetails =
        await gc.sleepDataService.getUnsyncedDetailsData(gc.userId.value);
    if (unsyncedSleep.isNotEmpty) {
      final success = await uploadSleep(
        unsyncedSleep,
        unsyncedSleepDetails,
        isSyncValue,
      );
      if (success) {
        await gc.sleepDataService.markAsSynced(unsyncedSleep);
        await gc.sleepDataService.markDetailsAsSynced(unsyncedSleepDetails);
      }
    }

    /// 血氧資料
    final unsyncedBloodOxygen =
        await gc.combinedDataService.getUnsyncedData(gc.userId.value);
    if (unsyncedBloodOxygen.isNotEmpty) {
      final success =
          await uploadOxygen(unsyncedBloodOxygen, isSyncValue, a: bloodRecords);
      final success2 = await uploadTemperature(unsyncedBloodOxygen, isSyncValue,
          a: tempRecords);
      if (success && success2) {
        await gc.combinedDataService.markAsSynced(unsyncedBloodOxygen);
        Future.delayed(const Duration(milliseconds: 500), () {
          NotificationService().showDeviceSyncDataNotification();
        });
      }
    }
    // ✅ 新增：壓力數據上傳
    final unsyncedPressure =
        await gc.pressureDataService.getUnsyncedData(gc.userId.value);
    if (unsyncedPressure.isNotEmpty) {
      final success = await uploadPressure(unsyncedPressure, isSyncValue);
      if (success) {
        await gc.pressureDataService.markAsSynced(unsyncedPressure);
      }
    }

    // 最後把recodes的isSync設為true
    await AlertRecordListStorage.markAllRecordsAsSynced(gc.userId.value);
  }

  Future<bool> uploadSteps(List<StepDataData> datas, String isSyncApi) async {
    final data = convertToPayload<StepDataData>(
      datas,
      "step",
      (data) => gc.apiId.value,
      (data) => data.step.toString(),
      (data) => data.startTimeStamp,
    );
    final payload = {"init": isSyncApi, "datas": data};
    try {
      await service.postJsonList(Api.sethealthRecord, jsonEncode(payload));
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> uploadCalories(
      List<StepDataData> datas, String isSyncApi) async {
    final data = convertToPayload<StepDataData>(
      datas,
      "calories",
      (data) => gc.apiId.value,
      (data) => data.calories.toString(),
      (data) => data.startTimeStamp,
    );
    final payload = {"init": isSyncApi, "datas": data};
    try {
      await service.postJsonList(Api.sethealthRecord, jsonEncode(payload));
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> uploadDistance(
      List<StepDataData> datas, String isSyncApi) async {
    final data = convertToPayload<StepDataData>(
      datas,
      "distance",
      (data) => gc.apiId.value,
      (data) => data.distance.toString(),
      (data) => data.startTimeStamp,
    );
    final payload = {"init": isSyncApi, "datas": data};
    try {
      await service.postJsonList(Api.sethealthRecord, jsonEncode(payload));
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> uploadHeartRate(List<HeartRateDataData> datas, String isSyncApi,
      {List<AlertRecord>? a}) async {
    final data = convertToPayload<HeartRateDataData>(
      datas,
      alertRecords: a,
      "rate",
      (data) => gc.apiId.value,
      (data) => data.heartRate.toString(),
      (data) => data.startTimeStamp,
    );
    final payload = {"init": isSyncApi, "datas": data};
    try {
      await service.postJsonList(Api.sethealthRecord, jsonEncode(payload));
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> uploadOxygen(List<CombinedDataData> datas, String isSyncApi,
      {List<AlertRecord>? a}) async {
    final data = convertToPayload<CombinedDataData>(
      datas,
      alertRecords: a,
      "oxygen",
      (data) => gc.apiId.value,
      (data) => data.bloodOxygen.toString(),
      (data) => data.startTimeStamp,
    );
    final payload = {"init": isSyncApi, "datas": data};
    try {
      await service.postJsonList(Api.sethealthRecord, jsonEncode(payload));
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> uploadTemperature(List<CombinedDataData> datas, String isSyncApi,
      {List<AlertRecord>? a}) async {
    final data = convertToPayload<CombinedDataData>(
      datas,
      alertRecords: a,
      "temperature",
      (data) => gc.apiId.value,
      (data) => data.temperature.toString(),
      (data) => data.startTimeStamp,
    );
    final payload = {"init": isSyncApi, "datas": data};
    try {
      await service.postJsonList(Api.sethealthRecord, jsonEncode(payload));
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> uploadPressure(List<PressureDataData> datas, String isSyncApi,
      {List<AlertRecord>? a}) async {
    final data = convertToPayload<PressureDataData>(
      datas,
      alertRecords: a,
      "pressure",
      (data) => gc.apiId.value,
      (data) => data.totalStressScore.toString(),
      (data) => data.startTimeStamp,
    );
    final payload = {"init": isSyncApi, "datas": data};
    try {
      await service.postJsonList(Api.sethealthRecord, jsonEncode(payload));
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> uploadSleep(List<SleepDataData> datas,
      List<SleepDetailDataData> detailsDatas, String isSyncApi) async {
    final dataList = buildSleepPayload(datas, detailsDatas, gc.apiId.value);

    final payload = {"init": isSyncApi, "datas": dataList};

    try {
      await service.postJsonList(Api.sethealthRecord, jsonEncode(payload));
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  List<Map<String, dynamic>> buildSleepPayload(
    List<SleepDataData> sleepList,
    List<SleepDetailDataData> detailList,
    String userId,
  ) {
    final List<Map<String, dynamic>> result = [];

    for (final sleep in sleepList) {
      final matchingDetails = detailList.where(
        (detail) => detail.sleepStartTimeStamp == sleep.startTimeStamp,
      );

      ///---- sleep data
      result.add({
        "userID": userId,
        "recordType": "sleep",
        "value": DateTimeUtils.getDurationInSeconds(
            sleep.startTimeStamp, sleep.endTimeStamp),
        "dataAt":
            DateTime.fromMillisecondsSinceEpoch(sleep.startTimeStamp * 1000)
                .format(pattern: "yyyy-MM-dd HH:mm:ss"),
      });

      /// ---- sleep details
      for (final entry in sleepTypeToRecordType.entries) {
        final type = entry.key;
        final recordType = entry.value;

        final totalDuration = matchingDetails
            .where((d) => d.sleepType == type)
            .fold<int>(0, (sum, d) => sum + d.duration);

        result.add({
          "userID": userId,
          "recordType": recordType,
          "value": totalDuration.toString(),
          "dataAt":
              DateTime.fromMillisecondsSinceEpoch(sleep.startTimeStamp * 1000)
                  .format(pattern: "yyyy-MM-dd HH:mm:ss"),
        });
      }
    }

    return result;
  }

  List<Map<String, dynamic>> convertToPayload<T>(
    List<T> dataList,
    String recordType,
    String Function(T) userIdExtractor,
    String Function(T) valueExtractor,
    int Function(T) timestampExtractor, {
    List<AlertRecord>? alertRecords,
  }) {
    // 用 Map<int, String> 儲存 timestamp 與對應的 type 字串
    final Map<int, String> alertTypeMap = {};
    if (alertRecords != null) {
      for (final alert in alertRecords) {
        final ts = alert.time.millisecondsSinceEpoch ~/ 1000;
        alertTypeMap[ts] = alert.type;
      }
    }

    return dataList.map((data) {
      final timestamp = timestampExtractor(data);
      final baseMap = {
        "userID": userIdExtractor(data),
        "recordType": recordType,
        "value": valueExtractor(data),
        "dataAt": DateTime.fromMillisecondsSinceEpoch(timestamp * 1000)
                .format(pattern: "yyyy-MM-dd HH:mm") +
            ":00"
      };

      // 若 alertRecord 有對應 timestamp，就進一步解析 type
      if (alertTypeMap.containsKey(timestamp)) {
        final typeString = alertTypeMap[timestamp]!.toLowerCase();

        if (typeString.contains("low")) {
          baseMap["type"] = "2";
        } else if (typeString.contains("high")) {
          baseMap["type"] = "1";
        } else {
          baseMap["type"] = "0";
        }
      } else {
        baseMap["type"] = "0";
      }

      return baseMap;
    }).toList();
  }

  ///----- 同步警報設定到db ------
  Future<void> syncAlertToApi() async {
    final rateAlert = await getRateAlert();
    final oxyAlert = await getOxyAlert();
    final tempAlert = await getTempAlert();
    final pressurAlert = await getPressureAlert();
    final stepAlert = await getStepAlert();
    final sleepAlert = await getSleepAlert();
    final caloriesAlert = await getCaloriesAlert();
    final distanceAlert = await getDistanceAlert();

    if (rateAlert.isNotEmpty) {
      await updateAlert(
          codeType: "rate",
          maxVal: rateAlert["maxVal"],
          miniVal: rateAlert["miniVal"],
          alert: rateAlert["alert"]);
    }
    if (oxyAlert.isNotEmpty) {
      await updateAlert(
          codeType: "oxygen",
          miniVal: oxyAlert["miniVal"],
          alert: oxyAlert["alert"]);
    }
    if (tempAlert.isNotEmpty) {
      await updateAlert(
          codeType: "temperature",
          maxVal: tempAlert["maxVal"],
          miniVal: tempAlert["miniVal"],
          alert: tempAlert["alert"]);
    }
    if (pressurAlert.isNotEmpty) {
      await updateAlert(
          codeType: "pressure",
          maxVal: pressurAlert["maxVal"],
          alert: pressurAlert["alert"]);
    }
    if (stepAlert.isNotEmpty) {
      await updateAlert(
          codeType: "step",
          maxVal: stepAlert["maxVal"],
          alert: stepAlert["alert"]);
    }
    if (sleepAlert.isNotEmpty) {
      await updateAlert(
          codeType: "sleep",
          maxVal: sleepAlert["maxVal"],
          alert: sleepAlert["alert"]);
    }
    if (caloriesAlert.isNotEmpty) {
      await updateAlert(
          codeType: "calories",
          maxVal: caloriesAlert["maxVal"],
          alert: caloriesAlert["alert"]);
    }
    if (distanceAlert.isNotEmpty) {
      await updateAlert(
          codeType: "distance",
          maxVal: distanceAlert["maxVal"],
          alert: distanceAlert["alert"]);
    }
  }

  Future<void> updateAlert(
      {String? codeType, double? maxVal, double? miniVal, bool? alert}) async {
    switch (codeType) {
      case "rate":
        HeartRateSetting profile = HeartRateSetting(
          highThreshold: maxVal!.toInt(),
          lowThreshold: miniVal!.toInt(),
          alertEnabled: alert!,
        );
        HeartRateSettingStorage.saveUserProfile(gc.userId.value, profile);
        break;
      case "oxygen":
        BloodOxygenSetting profile = BloodOxygenSetting(
          lowThreshold: miniVal!.toInt(),
          alertEnabled: alert!,
        );
        BloodOxygenSettingStorage.saveUserProfile(gc.userId.value, profile);
        break;
      case "temperature":
        BodyTemperatureSetting profile = BodyTemperatureSetting(
          highThreshold: "${maxVal!}",
          lowThreshold: "${miniVal!}",
          alertEnabled: alert!,
        );
        BodyTemperatureSettingStorage.saveUserProfile(gc.userId.value, profile);
        break;
      case "pressure":
        PressureSetting profile = PressureSetting(
          highThreshold: maxVal!.toInt(),
          alertEnabled: alert!,
        );
        PressureSettingStorage.saveUserProfile(gc.userId.value, profile);
        break;
      case "step":
        await updateGoalProfile("step", maxVal, alert);
        break;
      case "sleep":
        await updateGoalProfile("sleep", maxVal, alert);
        break;
      case "calories":
        await updateGoalProfile("calories", maxVal, alert);
        break;
      case "distance":
        await updateGoalProfile("distance", maxVal, alert);
        break;
      default:
        break;
    }
  }

  /// 更新目標設定到 GoalProfile
  Future<void> updateGoalProfile(
      String codeType, double? maxVal, bool? alert) async {
    // 先取得現有的 GoalProfile，如果沒有就建立新的
    var goalProfile = await GoalProfileStorage.getUserProfile(gc.userId.value);
    goalProfile ??= GoalProfile();

    // 根據 codeType 更新對應的目標值和推播開關
    switch (codeType) {
      case "step":
        if (maxVal != null) goalProfile.steps = maxVal.toInt();
        if (alert != null) goalProfile.isEnableSteps = alert;
        break;
      case "sleep":
        if (maxVal != null) goalProfile.sleepHours = maxVal;
        if (alert != null) goalProfile.isEnablesleepHours = alert;
        break;
      case "calories":
        if (maxVal != null) goalProfile.calories = maxVal.toInt();
        if (alert != null) goalProfile.isEnablecalories = alert;
        break;
      case "distance":
        if (maxVal != null) goalProfile.distance = maxVal.toInt();
        if (alert != null) goalProfile.isEnabledistance = alert;
        break;
    }

    // 保存更新後的 GoalProfile
    await GoalProfileStorage.saveUserProfile(gc.userId.value, goalProfile);
  }

  ///------ call api 取得心率警示
  Future<Map<String, dynamic>> getRateAlert() async {
    try {
      final payload = {
        "codeType": "rate",
        "userId": gc.apiId.value,
      };
      var res = await service.postJson(
        Api.measurementGet,
        payload,
      );

      if (res.isNotEmpty) {
        final resMsg = res["message"];
        if (resMsg == "SUCCESS") {
          final data = res["data"];
          if (data != null && data.length > 0) {
            Map<String, dynamic> result = {
              "maxVal": data["maxVal"],
              "miniVal": data["miniVal"],
              "alert": data["alert"],
            };
            return result;
          }
        }
      }
      return {};
    } catch (e) {
      print(e);
      return {};
    }
  }

  ///------ call api 取得血氧警示
  Future<Map<String, dynamic>> getOxyAlert() async {
    try {
      final payload = {
        "codeType": "oxygen",
        "userId": gc.apiId.value,
      };
      var res = await service.postJson(
        Api.measurementGet,
        payload,
      );

      if (res.isNotEmpty) {
        final resMsg = res["message"];
        if (resMsg == "SUCCESS") {
          final data = res["data"];
          if (data != null && data.length > 0) {
            Map<String, dynamic> result = {
              "maxVal": data["maxVal"],
              "miniVal": data["miniVal"],
              "alert": data["alert"],
            };
            return result;
          }
        }
      }
      return {};
    } catch (e) {
      print(e);
      return {};
    }
  }

  ///------ call api 取得体温警示
  Future<Map<String, dynamic>> getTempAlert() async {
    try {
      final payload = {
        "codeType": "temperature",
        "userId": gc.apiId.value,
      };
      var res = await service.postJson(
        Api.measurementGet,
        payload,
      );

      if (res.isNotEmpty) {
        final resMsg = res["message"];
        if (resMsg == "SUCCESS") {
          final data = res["data"];
          if (data != null && data.length > 0) {
            Map<String, dynamic> result = {
              "maxVal": data["maxVal"],
              "miniVal": data["miniVal"],
              "alert": data["alert"],
            };
            return result;
          }
        }
      }
      return {};
    } catch (e) {
      print(e);
      return {};
    }
  }

  ///------ call api 取得壓力警示
  Future<Map<String, dynamic>> getPressureAlert() async {
    try {
      final payload = {
        "codeType": "pressure",
        "userId": gc.apiId.value,
      };
      var res = await service.postJson(
        Api.measurementGet,
        payload,
      );

      if (res.isNotEmpty) {
        final resMsg = res["message"];
        if (resMsg == "SUCCESS") {
          final data = res["data"];
          if (data != null && data.length > 0) {
            Map<String, dynamic> result = {
              "maxVal": data["maxVal"],
              "miniVal": data["miniVal"],
              "alert": data["alert"],
            };
            return result;
          }
        }
      }
      return {};
    } catch (e) {
      print(e);
      return {};
    }
  }

  ///------ call api 取得壓力計算
  Future<Map<String, dynamic>> getPressureAnalys(
      {int? rateVal, int? oxyVal}) async {
    try {
      Map<String, dynamic> payload = {
        "heart_rate": rateVal,
        "blood_oxygen": oxyVal,
      };
      if (gc.userGender.value.length > 0) {
        payload["gender"] = gc.userGender.value == "男" ? "male" : "female";
      }
      var res = await awsService.postJson(
        Api.getPressure,
        payload,
      );

      if (res.isNotEmpty) {
        // 檢查新格式：直接包含 total_stress_score 和 stress_level
        if (res.containsKey("total_stress_score") &&
            res.containsKey("stress_level")) {
          return res; // 直接返回完整的回應數據
        }

        // 檢查舊格式：包含 message 和 data 包裝
      }
      return {};
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> getStepAlert() async {
    try {
      final payload = {
        "codeType": "step",
        "userId": gc.apiId.value,
      };
      var res = await service.postJson(
        Api.measurementGet,
        payload,
      );

      if (res.isNotEmpty) {
        final resMsg = res["message"];
        if (resMsg == "SUCCESS") {
          final data = res["data"];
          if (data != null && data.length > 0) {
            Map<String, dynamic> result = {
              "maxVal": data["maxVal"],
              "alert": data["alert"],
            };
            return result;
          }
        }
      }
      return {};
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> getSleepAlert() async {
    try {
      final payload = {
        "codeType": "sleep",
        "userId": gc.apiId.value,
      };
      var res = await service.postJson(
        Api.measurementGet,
        payload,
      );

      if (res.isNotEmpty) {
        final resMsg = res["message"];
        if (resMsg == "SUCCESS") {
          final data = res["data"];
          if (data != null && data.length > 0) {
            Map<String, dynamic> result = {
              "maxVal": data["maxVal"],
              "alert": data["alert"],
            };
            return result;
          }
        }
      }
      return {};
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> getCaloriesAlert() async {
    try {
      final payload = {
        "codeType": "calories",
        "userId": gc.apiId.value,
      };
      var res = await service.postJson(
        Api.measurementGet,
        payload,
      );

      if (res.isNotEmpty) {
        final resMsg = res["message"];
        if (resMsg == "SUCCESS") {
          final data = res["data"];
          if (data != null && data.length > 0) {
            Map<String, dynamic> result = {
              "maxVal": data["maxVal"],
              "alert": data["alert"],
            };
            return result;
          }
        }
      }
      return {};
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> getDistanceAlert() async {
    try {
      final payload = {
        "codeType": "distance",
        "userId": gc.apiId.value,
      };
      var res = await service.postJson(
        Api.measurementGet,
        payload,
      );

      if (res.isNotEmpty) {
        final resMsg = res["message"];
        if (resMsg == "SUCCESS") {
          final data = res["data"];
          if (data != null && data.length > 0) {
            Map<String, dynamic> result = {
              "maxVal": data["maxVal"],
              "alert": data["alert"],
            };
            return result;
          }
        }
      }
      return {};
    } catch (e) {
      print(e);
      return {};
    }
  }
}
