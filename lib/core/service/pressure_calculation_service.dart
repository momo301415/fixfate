import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/service/sync_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';
import 'package:pulsedevice/core/sqliteDb/combined_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/heart_rate_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/pressure_data_service.dart';
import 'package:drift/drift.dart';

class PressureCalculationService {
  final GlobalController _gc;
  final CombinedDataService _combinedDataService;
  final HeartRateDataService _heartRateDataService;
  final PressureDataService _pressureDataService;
  final SyncDataService _syncDataService;

  PressureCalculationService({
    required AppDatabase db,
    required GlobalController gc,
  })  : _gc = gc,
        _combinedDataService = CombinedDataService(db),
        _heartRateDataService = HeartRateDataService(db),
        _pressureDataService = PressureDataService(db),
        _syncDataService = SyncDataService(db: db, gc: gc);

  /// 計算壓力數據的主要方法
  Future<void> calculatePressureData() async {
    if (_gc.userId.value.isEmpty) {
      print('❌ 無 userId，取消壓力計算');
      return;
    }

    try {
      print('🔄 開始計算壓力數據...');

      // 1. 取得未同步的心率數據和血氧數據
      final unsyncedHeartRate =
          await _heartRateDataService.getUnsyncedData(_gc.userId.value);
      final unsyncedCombined =
          await _combinedDataService.getUnsyncedData(_gc.userId.value);

      print('📊 找到 ${unsyncedHeartRate.length} 筆未同步心率數據');
      print('📊 找到 ${unsyncedCombined.length} 筆未同步血氧數據');

      // 2. 檢查數據筆數是否一致
      if (unsyncedHeartRate.isEmpty || unsyncedCombined.isEmpty) {
        print('✅ 沒有足夠的數據進行壓力計算');
        return;
      }

      // 3. 收集有效數據到陣列
      final batchData =
          _collectValidBatchData(unsyncedHeartRate, unsyncedCombined);

      if (batchData.isEmpty) {
        print('✅ 沒有有效的數據進行壓力計算');
        return;
      }

      print('📊 準備批量處理 ${batchData.length} 筆數據');

      // 4. 一次性批量調用 API
      final apiResponse =
          await _syncDataService.getPressureAnalysBatch(batchData);

      // 5. 批量處理結果並寫入 SQLite
      await _processBatchResults(apiResponse, batchData);

      print('✅ 壓力計算完成');
    } catch (e, stackTrace) {
      print('❌ 壓力計算過程中發生錯誤: $e');
      print('Stack trace: $stackTrace');
    }
  }

  /// 收集有效數據到陣列
  List<Map<String, dynamic>> _collectValidBatchData(
      List<HeartRateDataData> heartRateData,
      List<CombinedDataData> combinedData) {
    final batchData = <Map<String, dynamic>>[];
    final minLength = heartRateData.length < combinedData.length
        ? heartRateData.length
        : combinedData.length;

    for (int i = 0; i < minLength; i++) {
      final heartData = heartRateData[i];
      final oxygenData = combinedData[i];

      if (_isValidForPressureCalculation(
          heartData.heartRate, oxygenData.bloodOxygen)) {
        batchData.add({
          "heart_rate": heartData.heartRate,
          "blood_oxygen": oxygenData.bloodOxygen,
          "id": heartData.startTimeStamp,
        });
      } else {
        print(
            '⚠️ 數據無效，跳過: 心率=${heartData.heartRate}, 血氧=${oxygenData.bloodOxygen}');
      }
    }

    return batchData;
  }

  /// 批量處理結果並寫入 SQLite
  Future<void> _processBatchResults(Map<String, dynamic> apiResponse,
      List<Map<String, dynamic>> batchData) async {
    // 建立 ID 到原始數據的映射
    final idToOriginalData = <int, Map<String, dynamic>>{};
    for (final data in batchData) {
      idToOriginalData[data['id']] = data;
    }

    // 準備批量插入的數據
    final pressureDataList = <PressureDataCompanion>[];

    // 處理 API 結果
    final results = apiResponse['results'] as List? ?? [];
    for (final result in results) {
      if (result['success'] == true) {
        final id = result['id'];
        final data = result['data'];
        final originalData = idToOriginalData[id];

        if (originalData != null) {
          pressureDataList.add(PressureDataCompanion(
            userId: Value(_gc.userId.value),
            startTimeStamp: Value(id),
            totalStressScore:
                Value((data['total_stress_score'] ?? 0).toDouble()),
            stressLevel: Value((data['stress_level'] ?? 'unknown').toString()),
            isSynced: Value(false),
          ));
        }
      }
    }

    // 批量插入到 SQLite
    if (pressureDataList.isNotEmpty) {
      await _pressureDataService.insertBatch(pressureDataList);
      print('✅ 批量寫入 ${pressureDataList.length} 筆壓力數據到 SQLite');
    }
  }

  /// 檢查數據是否有效用於壓力計算
  bool _isValidForPressureCalculation(int heartRate, int bloodOxygen) {
    // 檢查心率範圍 (40-200 bpm)
    if (heartRate <= 0 || heartRate > 200 || heartRate < 40) {
      return false;
    }

    // 檢查血氧範圍 (70-100%)
    if (bloodOxygen <= 0 || bloodOxygen > 100 || bloodOxygen < 70) {
      return false;
    }

    return true;
  }

  /// 取得壓力計算統計
  Future<Map<String, dynamic>> getPressureCalculationStats() async {
    try {
      final allPressureData =
          await _pressureDataService.getByUser(_gc.userId.value);
      final unsyncedData =
          await _pressureDataService.getUnsyncedData(_gc.userId.value);

      return {
        'total_count': allPressureData.length,
        'unsynced_count': unsyncedData.length,
        'synced_count': allPressureData.length - unsyncedData.length,
      };
    } catch (e) {
      print('❌ 取得壓力計算統計失敗: $e');
      return {};
    }
  }
}
