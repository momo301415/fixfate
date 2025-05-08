// services/health_data_sync_service.dart
import 'dart:async';
import 'package:pulsedevice/core/sqliteDb/blood_pressure_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/combined_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/heart_rate_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/invasive_comprehensive_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/sleep_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/step_data_service.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';

class HealthDataSyncService {
  final AppDatabase _db;

  Timer? _timer;
  String _userId = 'temp_user1';

  HealthDataSyncService(
    this._db,
  );

  List<int> healthDataTypes = [
    HealthDataType.step,
    HealthDataType.sleep,
    HealthDataType.heartRate,
    HealthDataType.bloodPressure,
    HealthDataType.combinedData,
    HealthDataType.invasiveComprehensiveData
  ]; //

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(minutes: 5), (_) => _fetchAndStoreData());
    _fetchAndStoreData(); // 初次啟動時立即執行一次
  }

  void stop() {
    _timer?.cancel();
  }

  Future<void> _fetchAndStoreData() async {
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
                  print("步數數據：$sdkList");
                  await stepService.syncStepData(
                      userId: _userId, sdkData: sdkList);
                  print("步數數據寫入成功");
                }
                break;
              case HealthDataType.sleep:
                final sleepService = SleepDataService(_db);
                if (list.last is SleepDataInfo) {
                  final sdkList = list.cast<SleepDataInfo>();
                  print("睡眠數據：$sdkList");
                  await sleepService.syncSleepData(
                      userId: _userId, sdkData: sdkList);

                  print("睡眠數據寫入成功");
                }

                break;
              case HealthDataType.heartRate:
                final heartRateService = HeartRateDataService(_db);
                if (list.last is HeartRateDataInfo) {
                  final sdkList = list.cast<HeartRateDataInfo>();
                  print("心率數據：$sdkList");
                  await heartRateService.syncHeartRateData(
                      userId: _userId,
                      sdkData:
                          sdkList); // await heartRateService.insertHeartRateDataIfNotExists(companion);
                  print("心率數據寫入成功");
                }

                break;
              case HealthDataType.bloodPressure:
                final bloodPressureService = BloodPressureDataService(_db);
                if (list.last is BloodPressureDataInfo) {
                  final sdkList = list.cast<BloodPressureDataInfo>();
                  print("血壓數據：$sdkList");
                  await bloodPressureService.syncBloodPressureData(
                      userId: _userId,
                      sdkData:
                          sdkList); // await bloodPressureService.insertBloodPressureDataIfNotExists(companion);
                  print("血壓數據寫入成功");
                }

                break;
              case HealthDataType.combinedData:
                final combinedDataService = CombinedDataService(_db);
                if (list.last is CombinedDataDataInfo) {
                  final sdkList = list.cast<CombinedDataDataInfo>();
                  print("合併數據：$sdkList");
                  await combinedDataService.syncCombinedData(
                      userId: _userId,
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
                          userId: _userId,
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
}
