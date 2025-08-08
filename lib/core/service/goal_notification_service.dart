import 'package:get/get.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/goal_profile_storage.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';

import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/presentation/k73_screen/controller/k73_controller.dart';
import 'package:pulsedevice/presentation/k73_screen/models/k73_model.dart';

class GoalNotificationService {
  final String userId;

  ApiService apiService = ApiService();
  final gc = Get.find<GlobalController>();
  final k73 = Get.find<K73Controller>();

  // 🔥 新增：API 請求緩存機制
  Map<String, dynamic>? _cachedHealthData;
  DateTime? _lastApiRequestTime;
  static const Duration _cacheValidDuration = Duration(minutes: 3); // 3分鐘內緩存有效

  GoalNotificationService({
    required this.userId,
  });

  // 🔥 優化：從 API 獲取今日健康數據（增加緩存機制）
  Future<Map<String, dynamic>?> getTodayHealthDataFromApi() async {
    try {
      // 檢查緩存是否有效
      if (_cachedHealthData != null && _lastApiRequestTime != null) {
        final timeDiff = DateTime.now().difference(_lastApiRequestTime!);
        if (timeDiff < _cacheValidDuration) {
          print("📦 使用緩存的健康數據");
          return _cachedHealthData;
        }
      }

      final nowStr = DateTime.now().format(pattern: 'yyyy-MM-dd');
      final payload = {
        "startTime": nowStr,
        "endTime": nowStr,
        "userID":
            gc.familyId.value.isEmpty ? gc.apiId.value : gc.familyId.value,
        "type": "ALL"
      };

      final res = await apiService.postJson(Api.healthRecordList, payload);

      if (res.isNotEmpty && res["message"] == "SUCCESS") {
        final data = res["data"];
        if (data == null) return null;

        final healthData = HealthDataSet.fromJson(data);
        final processedData =
            await k73.getAnalysisHealthDataFromApi(healthData);

        // 更新緩存
        _cachedHealthData = processedData;
        _lastApiRequestTime = DateTime.now();

        print("✅ 成功獲取並緩存健康數據");
        return processedData;
      }
    } catch (e) {
      print("❌ getTodayHealthDataFromApi Error: $e");
      // 如果 API 失敗但有緩存數據，返回緩存數據
      if (_cachedHealthData != null) {
        print("🔄 使用緩存數據作為備用");
        return _cachedHealthData;
      }
    }
    return null;
  }

  // 🔥 優化：主要檢查方法（增加時間窗口和錯誤處理）
  Future<void> checkTodayGoalsAndNotify() async {
    try {
      final profile = GoalProfileStorage.getUserProfile(userId);
      if (profile == null) {
        print("⚠️ 未找到用戶目標設定，跳過檢查");
        return;
      }

      // 🔥 從 API 獲取今日數據（最多重試2次）
      Map<String, dynamic>? healthMap;
      for (int retry = 0; retry < 3; retry++) {
        healthMap = await getTodayHealthDataFromApi();
        if (healthMap != null) break;

        if (retry < 2) {
          print("🔄 重試獲取健康數據 (${retry + 1}/3)");
          await Future.delayed(Duration(seconds: 2 * (retry + 1))); // 遞增延遲
        }
      }

      if (healthMap == null) {
        print("❌ 無法獲取健康數據，跳過目標檢查");
        return;
      }

      final now = DateTime.now();
      final hour = now.hour;

      // 🔥 優化：使用並行處理提升效能
      final futures = <Future<void>>[];

      // -------- 步數達成通知 --------
      if (profile.isEnableSteps == true) {
        final todayStep = healthMap["stepCount"] as int? ?? 0;
        futures
            .add(_checkStepsGoal(todayStep, profile.steps ?? 10000, now, hour));
      }

      // -------- 睡眠目標通知（延後到下午檢查） --------
      if (profile.isEnablesleepHours == true && _isSleepCheckTime(hour)) {
        final sleepTime = healthMap["sleepTime"] as String?;
        if (sleepTime != null) {
          final sleepHours = double.tryParse(sleepTime) ?? 0.0;
          futures
              .add(_checkSleepGoal(sleepHours, profile.sleepHours ?? 8.0, now));
        }
      }

      // -------- 距離達成通知 --------
      if (profile.isEnabledistance == true) {
        final todayDistance = healthMap["stepDistance"] as int? ?? 0;
        futures.add(_checkDistanceGoal(
            todayDistance, profile.distance ?? 6000, now, hour));
      }

      // -------- 熱量達成通知 --------
      if (profile.isEnablecalories == true) {
        final todayCalories = healthMap["calories"] as int? ?? 0;
        futures.add(_checkCaloriesGoal(
            todayCalories, profile.calories ?? 2500, now, hour));
      }

      // 並行執行所有檢查
      await Future.wait(futures);
    } catch (e) {
      print("❌ checkTodayGoalsAndNotify Error: $e");
    }
  }

  // 🔥 新增：睡眠檢查時間判斷
  bool _isSleepCheckTime(int hour) {
    return hour >= 12 && hour < 13; // 12:00-13:00 檢查睡眠
  }

  // 🔥 新增：進度提醒時間判斷（一小時時間窗口）
  bool _isProgressReminderTime(int hour) {
    return (hour >= 12 && hour < 13) || (hour >= 00 && hour < 01);
  }

  // 🔥 優化：步數目標檢查邏輯
  Future<void> _checkStepsGoal(
      int todayStep, int targetSteps, DateTime now, int hour) async {
    try {
      if (todayStep >= targetSteps) {
        // 達標通知：隨時檢查
        if (!NotificationRecordStorage.hasNotified(
            now, GoalType.stepsAchieved)) {
          await sendFirebaseNotify(
            title: '步數目標 達成！',
            body: '太棒了 🎉 今天已完成 $todayStep 步！為健康乾杯！',
          );
          await NotificationRecordStorage.markNotified(
              now, GoalType.stepsAchieved);
          print("✅ 發送步數達標通知");
        }
      } else if (_isProgressReminderTime(hour)) {
        // 進度提醒：一小時時間窗口
        if (!NotificationRecordStorage.hasNotified(
            now, GoalType.stepsPending)) {
          await sendFirebaseNotify(
            title: '步數目標 努力中',
            body: '步數累積到 $todayStep 步，還差目標一點點，繼續努力😊',
          );
          await NotificationRecordStorage.markNotified(
              now, GoalType.stepsPending);
          print("📊 發送步數進度提醒");
        }
      }
    } catch (e) {
      print("❌ _checkStepsGoal Error: $e");
    }
  }

  // 🔥 優化：睡眠目標檢查邏輯
  Future<void> _checkSleepGoal(
      double sleepHours, double targetHours, DateTime now) async {
    try {
      if (sleepHours >= targetHours) {
        if (!NotificationRecordStorage.hasNotified(
            now, GoalType.sleepAchieved)) {
          await sendFirebaseNotify(
            title: '睡眠目標 達成！',
            body: '睡飽飽！恭喜你昨晚睡滿 ${sleepHours.toStringAsFixed(1)} 小時，達成睡眠目標了！',
          );
          await NotificationRecordStorage.markNotified(
              now, GoalType.sleepAchieved);
          print("✅ 發送睡眠達標通知");
        }
      } else {
        if (!NotificationRecordStorage.hasNotified(
            now, GoalType.sleepUnachieved)) {
          await sendFirebaseNotify(
            title: '睡眠目標 未達成',
            body:
                '昨晚睡眠時長是 ${sleepHours.toStringAsFixed(1)} 小時，離目標差一些。沒關係！有休息就是好事 😊',
          );
          await NotificationRecordStorage.markNotified(
              now, GoalType.sleepUnachieved);
          print("📊 發送睡眠未達成通知");
        }
      }
    } catch (e) {
      print("❌ _checkSleepGoal Error: $e");
    }
  }

  // 🔥 優化：距離目標檢查邏輯
  Future<void> _checkDistanceGoal(
      int todayDistance, int targetDistance, DateTime now, int hour) async {
    try {
      if (todayDistance >= targetDistance) {
        if (!NotificationRecordStorage.hasNotified(
            now, GoalType.distanceAchieved)) {
          await sendFirebaseNotify(
            title: '運動距離目標 達成！',
            body: '太棒了🎉 今天運動距離已達 $todayDistance 公尺，為健康多走了一段！',
          );
          await NotificationRecordStorage.markNotified(
              now, GoalType.distanceAchieved);
          print("✅ 發送距離達標通知");
        }
      } else if (_isProgressReminderTime(hour)) {
        if (!NotificationRecordStorage.hasNotified(
            now, GoalType.distancePending)) {
          await sendFirebaseNotify(
            title: '運動距離目標 努力中',
            body: '運動距離累積到 $todayDistance 公尺，繼續向目標前進！😊',
          );
          await NotificationRecordStorage.markNotified(
              now, GoalType.distancePending);
          print("📊 發送距離進度提醒");
        }
      }
    } catch (e) {
      print("❌ _checkDistanceGoal Error: $e");
    }
  }

  // 🔥 優化：熱量目標檢查邏輯
  Future<void> _checkCaloriesGoal(
      int todayCalories, int targetCalories, DateTime now, int hour) async {
    try {
      if (todayCalories >= targetCalories) {
        if (!NotificationRecordStorage.hasNotified(
            now, GoalType.caloriesAchieved)) {
          await sendFirebaseNotify(
            title: '熱量目標 達成！',
            body: '恭喜 🎉 今天已消耗 $todayCalories 大卡了，你的努力身體都知道！',
          );
          await NotificationRecordStorage.markNotified(
              now, GoalType.caloriesAchieved);
          print("✅ 發送熱量達標通知");
        }
      } else if (_isProgressReminderTime(hour)) {
        if (!NotificationRecordStorage.hasNotified(
            now, GoalType.caloriesPending)) {
          await sendFirebaseNotify(
            title: '熱量目標 努力中',
            body: '目前消耗了 $todayCalories 大卡，離目標差一點！每次累積都是為健康加分 💪',
          );
          await NotificationRecordStorage.markNotified(
              now, GoalType.caloriesPending);
          print("📊 發送熱量進度提醒");
        }
      }
    } catch (e) {
      print("❌ _checkCaloriesGoal Error: $e");
    }
  }

  // 🔥 優化：Firebase 推播（增加重試機制）
  Future<void> sendFirebaseNotify(
      {required String title, required String body}) async {
    for (int retry = 0; retry < 3; retry++) {
      try {
        final payload = {
          "token": gc.firebaseToken.value,
          "title": title,
          "content": body,
          "dataKey": "",
          "dataVal": "",
        };

        final res = await apiService.postJson(
          Api.sendFirebase,
          payload,
        );

        if (res.isNotEmpty) {
          print("✅ Firebase 推播發送成功");
          return; // 成功後直接返回
        }
      } catch (e) {
        print("❌ Firebase 推播發送失敗 (${retry + 1}/3): $e");
        if (retry < 2) {
          await Future.delayed(Duration(seconds: 1 * (retry + 1))); // 遞增延遲
        }
      }
    }
    print("❌ Firebase 推播最終發送失敗");
  }

  // 🔥 新增：清除緩存方法（可選）
  void clearCache() {
    _cachedHealthData = null;
    _lastApiRequestTime = null;
    print("🧹 已清除健康數據緩存");
  }

  // 🔥 新增：獲取服務狀態（用於調試）
  Map<String, dynamic> getServiceStatus() {
    return {
      "hasCachedData": _cachedHealthData != null,
      "lastApiRequest": _lastApiRequestTime?.toIso8601String(),
      "cacheAge": _lastApiRequestTime != null
          ? DateTime.now().difference(_lastApiRequestTime!).inSeconds
          : null,
    };
  }

  // 保留原有方法（向後兼容）
  Future<void> getHealthData() async {
    try {
      final nowStr = DateTime.now().format(pattern: 'yyyy-MM-dd');
      final payload = {
        "startTime": nowStr,
        "endTime": nowStr,
        "userID": gc.apiId.value,
        "type": "ALL"
      };
      final res = await apiService.postJson(Api.healthRecordList, payload);

      if (res.isNotEmpty && res["message"] == "SUCCESS") {
        final data = res["data"];
        if (data == null) return;
        final healthData = HealthDataSet.fromJson(data);
        final healthMap = await k73.getAnalysisHealthDataFromApi(healthData);
        print(healthMap);
      }
    } catch (e) {
      print("❌ getHealthData Error: $e");
    }
  }
}
