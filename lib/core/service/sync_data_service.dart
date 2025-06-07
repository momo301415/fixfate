import 'dart:convert';

import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/core/utils/pref_utils.dart';

class SyncDataService {
  final AppDatabase db;
  final GlobalController gc;
  ApiService service = ApiService();
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
    await gc.healthDataSyncService.syncHealthData();
    await Future.delayed(Duration.zero);
    await syncToApi();
  }

  Future<void> syncToApi() async {
    if (gc.userId.value.isEmpty) return;
    var isSyncValue = "N";
    final isSyncApi = await PrefUtils().getIsSyncApi();
    if (isSyncApi.isEmpty) {
      await PrefUtils().setIsSyncApi("Y");
      isSyncValue = "Y";
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
      final success = await uploadHeartRate(unsyncedHeartRate, isSyncValue);
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
      final success =
          await uploadSleep(unsyncedSleep, unsyncedSleepDetails, isSyncValue);
      if (success) {
        await gc.sleepDataService.markAsSynced(unsyncedSleep);
        await gc.sleepDataService.markDetailsAsSynced(unsyncedSleepDetails);
      }
    }

    /// 血氧資料
    final unsyncedBloodOxygen =
        await gc.combinedDataService.getUnsyncedData(gc.userId.value);
    if (unsyncedBloodOxygen.isNotEmpty) {
      final success = await uploadOxygen(unsyncedBloodOxygen, isSyncValue);
      final success2 =
          await uploadTemperature(unsyncedBloodOxygen, isSyncValue);
      if (success && success2) {
        await gc.combinedDataService.markAsSynced(unsyncedBloodOxygen);
      }
    }

    // 同理為其他資料類型加上處理邏輯
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

  Future<bool> uploadHeartRate(
      List<HeartRateDataData> datas, String isSyncApi) async {
    final data = convertToPayload<HeartRateDataData>(
      datas,
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

  Future<bool> uploadOxygen(
      List<CombinedDataData> datas, String isSyncApi) async {
    final data = convertToPayload<CombinedDataData>(
      datas,
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

  Future<bool> uploadTemperature(
      List<CombinedDataData> datas, String isSyncApi) async {
    final data = convertToPayload<CombinedDataData>(
      datas,
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
    int Function(T) timestampExtractor,
  ) {
    return dataList.map((data) {
      return {
        "userID": userIdExtractor(data),
        "recordType": recordType,
        "value": valueExtractor(data),
        "dataAt":
            DateTime.fromMillisecondsSinceEpoch(timestampExtractor(data) * 1000)
                    .format(pattern: "yyyy-MM-dd HH:mm") +
                ":00"
      };
    }).toList();
  }
}
