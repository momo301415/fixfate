import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/service/sync_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';
import 'package:pulsedevice/core/sqliteDb/combined_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/heart_rate_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/pressure_data_service.dart';
import 'package:drift/drift.dart';

class PressureCalculationService {
  final AppDatabase _db;
  final GlobalController _gc;
  final CombinedDataService _combinedDataService;
  final HeartRateDataService _heartRateDataService;
  final PressureDataService _pressureDataService;
  final SyncDataService _syncDataService;

  PressureCalculationService({
    required AppDatabase db,
    required GlobalController gc,
  })  : _db = db,
        _gc = gc,
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

      if (unsyncedHeartRate.length != unsyncedCombined.length) {
        print(
            '⚠️ 心率和血氧數據筆數不一致 (心率: ${unsyncedHeartRate.length}, 血氧: ${unsyncedCombined.length})');
        print('⚠️ 將處理較少的數據筆數');
      }

      // 3. 使用索引配對處理數據
      final minLength = unsyncedHeartRate.length < unsyncedCombined.length
          ? unsyncedHeartRate.length
          : unsyncedCombined.length;

      int successCount = 0;
      int failureCount = 0;

      for (int i = 0; i < minLength; i++) {
        final heartData = unsyncedHeartRate[i];
        final oxygenData = unsyncedCombined[i];

        if (_isValidForPressureCalculation(
            heartData.heartRate, oxygenData.bloodOxygen)) {
          final success = await _calculateSinglePressure(heartData, oxygenData);
          if (success) {
            successCount++;
          } else {
            failureCount++;
          }
        } else {
          print(
              '⚠️ 數據無效，跳過: 心率=${heartData.heartRate}, 血氧=${oxygenData.bloodOxygen}');
        }
      }

      print('✅ 壓力計算完成: 成功 $successCount 筆, 失敗 $failureCount 筆');
    } catch (e, stackTrace) {
      print('❌ 壓力計算過程中發生錯誤: $e');
      print('Stack trace: $stackTrace');
    }
  }

  /// 計算單筆壓力數據
  Future<bool> _calculateSinglePressure(
      HeartRateDataData heartData, CombinedDataData oxygenData) async {
    try {
      print(
          '🔄 計算壓力: 心率=${heartData.heartRate}, 血氧=${oxygenData.bloodOxygen}, 心率時間=${heartData.startTimeStamp}, 血氧時間=${oxygenData.startTimeStamp}');

      // 調用壓力計算 API，傳遞心率和血氧參數
      final apiResult = await _syncDataService.getPressureAnalys(
        rateVal: heartData.heartRate,
        oxyVal: oxygenData.bloodOxygen,
      );

      if (apiResult.isEmpty) {
        print('❌ API 返回空結果');
        return false;
      }

      print('📄 API 回傳結果: $apiResult');

      // 檢查 API 回傳的必要欄位
      if (!apiResult.containsKey('total_stress_score') &&
          !apiResult.containsKey('maxVal')) {
        print('❌ API 回傳數據格式不正確: $apiResult');
        return false;
      }

      // 用當前時間存儲壓力數據
      await _pressureDataService.insert(PressureDataCompanion(
        userId: Value(heartData.userId),
        startTimeStamp: Value(heartData.startTimeStamp),
        totalStressScore: Value((apiResult['total_stress_score'] ??
                apiResult['total_stress_score'] ??
                0)
            .toDouble()),
        stressLevel: Value(
            (apiResult['stress_level'] ?? apiResult['stress_level'])
                    ?.toString() ??
                'unknown'),
        isSynced: Value(false), // 預設未同步
      ));

      print('✅ 壓力數據存儲成功');
      return true;
    } catch (e, stackTrace) {
      print('❌ 計算單筆壓力失敗: $e');
      print('Stack trace: $stackTrace');
      return false;
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
