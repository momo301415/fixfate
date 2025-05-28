import 'dart:convert';

import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';

class SyncDataService {
  final AppDatabase db;
  final GlobalController gc;
  ApiService service = ApiService();
  SyncDataService({required this.db, required this.gc});

  Future<void> runBackgroundSync() async {
    await gc.healthDataSyncService.fetchAndStoreData();
    await gc.healthDataSyncService.syncHealthData();
    await syncToApi();
  }

  Future<void> syncToApi() async {
    if (gc.userId.value.isEmpty) return;

    // 步數資料
    final unsyncedSteps =
        await gc.stepDataService.getUnsyncedData(gc.userId.value);
    if (unsyncedSteps.isNotEmpty) {
      final success = await uploadSteps(unsyncedSteps);
      final success2 = await uploadCalories(unsyncedSteps);
      final success3 = await uploadDistance(unsyncedSteps);
      if (success && success2 && success3) {
        await gc.stepDataService.markAsSynced(unsyncedSteps);
      }
    }

    /// 心跳資料
    final unsyncedHeartRate =
        await gc.heartRateDataService.getUnsyncedData(gc.userId.value);
    if (unsyncedHeartRate.isNotEmpty) {
      final success = await uploadHeartRate(unsyncedHeartRate);
      if (success) {
        await gc.heartRateDataService.markAsSynced(unsyncedHeartRate);
      }
    }

    // 睡眠資料
    final unsyncedSleep =
        await gc.sleepDataService.getUnsyncedData(gc.userId.value);
    if (unsyncedSleep.isNotEmpty) {
      final success = await uploadSleep(unsyncedSleep);
      if (success) {
        await gc.sleepDataService.markAsSynced(unsyncedSleep);
      }
    }

    /// 血氧資料
    final unsyncedBloodOxygen =
        await gc.combinedDataService.getUnsyncedData(gc.userId.value);
    if (unsyncedBloodOxygen.isNotEmpty) {
      final success = await uploadOxygen(unsyncedBloodOxygen);
      final success2 = await uploadTemperature(unsyncedBloodOxygen);
      if (success && success2) {
        await gc.combinedDataService.markAsSynced(unsyncedBloodOxygen);
      }
    }

    // 同理為其他資料類型加上處理邏輯
  }

  Future<bool> uploadSteps(List<StepDataData> datas) async {
    final payload = convertToPayload<StepDataData>(
      datas,
      "step",
      (data) => gc.apiId.value,
      (data) => data.step.toString(),
      (data) => data.startTimeStamp,
    );
    try {
      await service.postJsonList(Api.sethealthRecord, jsonEncode(payload));
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> uploadCalories(List<StepDataData> datas) async {
    final payload = convertToPayload<StepDataData>(
      datas,
      "calories",
      (data) => gc.apiId.value,
      (data) => data.calories.toString(),
      (data) => data.startTimeStamp,
    );
    try {
      await service.postJsonList(Api.sethealthRecord, jsonEncode(payload));
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> uploadDistance(List<StepDataData> datas) async {
    final payload = convertToPayload<StepDataData>(
      datas,
      "distance",
      (data) => gc.apiId.value,
      (data) => data.distance.toString(),
      (data) => data.startTimeStamp,
    );
    try {
      await service.postJsonList(Api.sethealthRecord, jsonEncode(payload));
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> uploadHeartRate(List<HeartRateDataData> datas) async {
    final payload = convertToPayload<HeartRateDataData>(
      datas,
      "heartrate",
      (data) => gc.apiId.value,
      (data) => data.heartRate.toString(),
      (data) => data.startTimeStamp,
    );
    try {
      await service.postJsonList(Api.sethealthRecord, jsonEncode(payload));
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> uploadOxygen(List<CombinedDataData> datas) async {
    final payload = convertToPayload<CombinedDataData>(
      datas,
      "oxygen",
      (data) => gc.apiId.value,
      (data) => data.bloodOxygen.toString(),
      (data) => data.startTimeStamp,
    );
    try {
      await service.postJsonList(Api.sethealthRecord, jsonEncode(payload));
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> uploadTemperature(List<CombinedDataData> datas) async {
    final payload = convertToPayload<CombinedDataData>(
      datas,
      "temperature",
      (data) => gc.apiId.value,
      (data) => data.temperature.toString(),
      (data) => data.startTimeStamp,
    );
    try {
      await service.postJsonList(Api.sethealthRecord, jsonEncode(payload));
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> uploadSleep(List<SleepDataData> datas) async {
    final payload = convertToPayload<SleepDataData>(
      datas,
      "sleep",
      (data) => gc.apiId.value,
      (data) => DateTimeUtils.getDurationFormattedString(
          data.startTimeStamp, data.endTimeStamp),
      (data) => data.startTimeStamp,
    );
    try {
      await service.postJsonList(Api.sethealthRecord, jsonEncode(payload));
      return true;
    } catch (e) {
      print(e);
    }
    return false;
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
