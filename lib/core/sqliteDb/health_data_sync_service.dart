// services/health_data_sync_service.dart
import 'dart:async';
import 'package:pulsedevice/core/app_export.dart';
import 'package:pulsedevice/core/hiveDb/alert_record.dart';
import 'package:pulsedevice/core/hiveDb/alert_record_list_storage.dart';
import 'package:pulsedevice/core/hiveDb/blood_oxygen_setting_storage.dart';
import 'package:pulsedevice/core/hiveDb/body_temperature_setting_storage.dart';
import 'package:pulsedevice/core/hiveDb/heart_rate_setting_storage.dart';
import 'package:pulsedevice/core/sqliteDb/blood_pressure_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/combined_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/heart_rate_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/invasive_comprehensive_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/sleep_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/step_data_service.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';

class HealthDataSyncService {
  final AppDatabase _db;

  String? _userId;

  String? get userId => _userId;
  void setUserId(String id) => _userId = id;

  HealthDataSyncService(
    this._db,
  );
  AppDatabase getInstance() {
    return _db;
  }

  List<int> healthDataTypes = [
    HealthDataType.step,
    HealthDataType.sleep,
    HealthDataType.heartRate,
    HealthDataType.bloodPressure,
    HealthDataType.combinedData,
    HealthDataType.invasiveComprehensiveData
  ];

  Future<void> fetchAndStoreData() async {
    if (_userId == null) {
      print('❌ 無 userId，取消同步');
      return;
    }
    try {
      for (final dataType in healthDataTypes) {
        final result = await YcProductPlugin().queryDeviceHealthData(dataType);
        if (result?.statusCode == PluginState.succeed) {
          final list = result?.data ?? [];
          if (list.isNotEmpty) {
            switch (dataType) {
              case HealthDataType.step:
                final stepService = StepDataService(_db);
                if (list.last is StepDataInfo) {
                  final sdkList = list.cast<StepDataInfo>();
                  printLongText("步數數據：$sdkList");
                  await stepService.syncStepData(
                      userId: _userId!, sdkData: sdkList);
                  print("步數數據寫入成功");
                }
                break;
              case HealthDataType.sleep:
                final sleepService = SleepDataService(_db);
                if (list.last is SleepDataInfo) {
                  final sdkList = list.cast<SleepDataInfo>();
                  printLongText("睡眠數據：$sdkList");
                  await sleepService.syncSleepData(
                      userId: _userId!, sdkData: sdkList);

                  print("睡眠數據寫入成功");
                }

                break;
              case HealthDataType.heartRate:
                final heartRateService = HeartRateDataService(_db);
                if (list.last is HeartRateDataInfo) {
                  final sdkList = list.cast<HeartRateDataInfo>();
                  printLongText("心率數據：$sdkList");
                  await heartRateService.syncHeartRateData(
                      userId: _userId!,
                      sdkData:
                          sdkList); // await heartRateService.insertHeartRateDataIfNotExists(companion);
                  print("心率數據寫入成功");
                }

                break;
              case HealthDataType.bloodPressure:
                final bloodPressureService = BloodPressureDataService(_db);
                if (list.last is BloodPressureDataInfo) {
                  final sdkList = list.cast<BloodPressureDataInfo>();
                  printLongText("血壓數據：$sdkList");
                  await bloodPressureService.syncBloodPressureData(
                      userId: _userId!,
                      sdkData:
                          sdkList); // await bloodPressureService.insertBloodPressureDataIfNotExists(companion);
                  print("血壓數據寫入成功");
                }

                break;
              case HealthDataType.combinedData:
                final combinedDataService = CombinedDataService(_db);
                if (list.last is CombinedDataDataInfo) {
                  final sdkList = list.cast<CombinedDataDataInfo>();
                  printLongText("合併數據：$sdkList");
                  await combinedDataService.syncCombinedData(
                      userId: _userId!,
                      sdkData:
                          sdkList); // await combinedDataService.insertCombinedDataIfNotExists(companion);
                  print("合併數據寫入成功");
                }

                break;
              case HealthDataType.invasiveComprehensiveData:
                final invasiveComprehensiveDataService =
                    InvasiveComprehensiveDataService(_db);
                if (list.last is InvasiveComprehensiveDataInfo) {
                  final sdkList = list.cast<InvasiveComprehensiveDataInfo>();
                  print("入侵綜合數據：$sdkList");
                  await invasiveComprehensiveDataService
                      .syncInvasiveComprehensiveData(
                          userId: _userId!,
                          sdkData:
                              sdkList); // await invasiveComprehensiveDataService.insertInvasiveComprehensiveDataIfNotExists(companion);
                  print("入侵綜合數據寫入成功");
                }
                break;
            }
          }
        }
      }
    } catch (e) {
      // 錯誤處理，例如記錄日誌
      print('資料同步錯誤: $e');
    }
  }

  /// 同步健康數據到告警
  Future<void> syncHealthData() async {
    final heartService = HeartRateDataService(_db);
    final combinedService = CombinedDataService(_db);

    final heartSettings =
        await HeartRateSettingStorage.getUserProfile(_userId!);
    final bloodSettings =
        await BloodOxygenSettingStorage.getUserProfile(_userId!);
    final tempSettings =
        await BodyTemperatureSettingStorage.getUserProfile(_userId!);
    final heartList = await heartService.getByUser(_userId!);
    final combinedList = await combinedService.getByUser(_userId!);
    List<AlertRecord> alertList = [];
    if (heartSettings?.alertEnabled == true) {
      // ✅ 心率資料
      for (var dic in heartList) {
        final dt =
            DateTime.fromMillisecondsSinceEpoch(dic.startTimeStamp * 1000);
        if (dic.heartRate > heartSettings!.highThreshold) {
          alertList.add(AlertRecord(
            label: 'lbl155'.tr,
            type: 'heart_rate_high',
            time: dt,
            value: heartSettings.highThreshold.toString(),
            unit: 'lbl161'.tr,
            synced: false,
          ));
        } else if (dic.heartRate < heartSettings.lowThreshold) {
          alertList.add(AlertRecord(
            label: 'lbl155_1'.tr,
            type: 'heart_rate_low',
            time: dt,
            value: heartSettings.lowThreshold.toString(),
            unit: 'lbl161'.tr,
            synced: false,
          ));
        }
      }
    }

    if (bloodSettings?.alertEnabled == true) {
      // ✅ 血氧資料
      for (var dic in combinedList) {
        if (dic.bloodOxygen < bloodSettings!.lowThreshold) {
          alertList.add(AlertRecord(
            label: 'lbl156'.tr,
            type: 'blood_oxygen_low',
            time:
                DateTime.fromMillisecondsSinceEpoch(dic.startTimeStamp * 1000),
            value: bloodSettings.lowThreshold.toString(),
            unit: '%',
            synced: false,
          ));
        }
      }
    }

    if (tempSettings?.alertEnabled == true) {
      // ✅ 體溫資料
      for (var dic in combinedList) {
        final dt =
            DateTime.fromMillisecondsSinceEpoch(dic.startTimeStamp * 1000);
        if (dic.temperature > double.parse(tempSettings!.highThreshold)) {
          alertList.add(AlertRecord(
            label: 'lbl1841_1'.tr,
            type: 'temperature_high',
            time: dt,
            value: double.parse(tempSettings.highThreshold).toString(),
            unit: 'lbl_c'.tr,
            synced: false,
          ));
        } else if (dic.temperature < double.parse(tempSettings.lowThreshold)) {
          alertList.add(AlertRecord(
            label: 'lbl185_1'.tr,
            type: 'temperature_low',
            time: dt,
            value: double.parse(tempSettings.lowThreshold).toString(),
            unit: 'lbl_c'.tr,
            synced: false,
          ));
        }
      }
    }
    if (alertList.isEmpty) return;

    await AlertRecordListStorage.addRecords(_userId!, alertList);
  }

  Future<Map<String, dynamic>> getAnalysisHealthData() async {
    final stepService = StepDataService(_db);
    final sleepService = SleepDataService(_db);
    final heartService = HeartRateDataService(_db);
    final combinedService = CombinedDataService(_db);
    if (_userId == null) {
      _userId = await PrefUtils().getUserId();
    }
    final stepList = await stepService.getStepDataByUser(_userId!);
    final sleepList = await sleepService.getSleepDataByUser(_userId!);
    final heartList = await heartService.getByUser(_userId!);
    final combinedList = await combinedService.getByUser(_userId!);

    final stepLast = stepList.last;
    final sleepLast = sleepList.last;
    final heartLast = heartList.last;
    final combinedLast = combinedList.last;
    int stepCount = stepList.fold(0, (sum, d) => sum + d.step);
    int stepDistance = stepList.fold(0, (sum, d) => sum + d.distance);
    final calories = stepList.fold(0, (sum, d) => sum + d.calories);
    String stepDuration =
        DateTimeUtils.getTimeDifferenceString(stepLast.endTimeStamp);
    final sleepTime =
        ((sleepLast.endTimeStamp - sleepLast.startTimeStamp) / 3600)
            .toStringAsFixed(2);
    String sleepDuration =
        DateTimeUtils.getTimeDifferenceString(sleepLast.endTimeStamp);
    final heartRate = heartLast.heartRate;
    String heartDuration =
        DateTimeUtils.getTimeDifferenceString(heartLast.startTimeStamp);
    String combinedDuration =
        DateTimeUtils.getTimeDifferenceString(combinedLast.startTimeStamp);
    final bloodOxygen = combinedLast.bloodOxygen;
    final t = combinedLast.temperature;
    var temperature = "";
    if (t > 0.0) {
      temperature = "+ ${t}";
    } else {
      temperature = "- ${t}";
    }
    final loadDataTime = DateTimeUtils.formatMaxTimestamp(
        stepLast.startTimeStamp,
        sleepLast.startTimeStamp,
        heartLast.startTimeStamp,
        combinedLast.startTimeStamp);

    final analysis = {
      "stepCount": stepCount,
      "stepDistance": stepDistance,
      "stepDuration": stepDuration,
      "calories": calories,
      "sleepTime": sleepTime,
      "sleepDuration": sleepDuration,
      "heartRate": heartRate,
      "heartDuration": heartDuration,
      "bloodOxygen": bloodOxygen,
      "combinedDuration": combinedDuration,
      "temperature": temperature,
      "loadDataTime": loadDataTime
    };
    return analysis;
  }

  void printLongText(String text) {
    const int chunkSize = 800;
    for (var i = 0; i < text.length; i += chunkSize) {
      final chunk = text.substring(
          i, i + chunkSize > text.length ? text.length : i + chunkSize);
      print(chunk);
    }
  }
}
