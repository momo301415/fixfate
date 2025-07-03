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
  // 🔥 移除 SQLite 服務依賴
  GoalNotificationService({
    required this.userId,
  });

  // 🔥 新增：從 API 獲取今日健康數據
  Future<Map<String, dynamic>?> getTodayHealthDataFromApi() async {
    try {
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
        return await k73.getAnalysisHealthDataFromApi(healthData);
      }
    } catch (e) {
      print("getTodayHealthDataFromApi Error: $e");
    }
    return null;
  }

  // 🔥 重寫主要檢查方法
  Future<void> checkTodayGoalsAndNotify() async {
    final profile = GoalProfileStorage.getUserProfile(userId);
    if (profile == null) return;

    // 🔥 從 API 獲取今日數據
    final healthMap = await getTodayHealthDataFromApi();
    if (healthMap == null) {
      print("❌ 無法獲取健康數據，跳過目標檢查");
      return;
    }

    final now = DateTime.now();
    final hour = now.hour;

    // -------- 步數達成通知 --------
    if (profile.isEnableSteps == true) {
      final todayStep = healthMap["stepCount"] as int? ?? 0;
      await _checkStepsGoal(todayStep, profile.steps ?? 10000, now, hour);
    }

    // -------- 睡眠目標通知 --------
    if (profile.isEnablesleepHours == true && hour == 12) {
      final sleepTime = healthMap["sleepTime"] as String?;
      if (sleepTime != null) {
        final sleepHours = double.tryParse(sleepTime) ?? 0.0;
        await _checkSleepGoal(sleepHours, profile.sleepHours ?? 8.0, now);
      }
    }

    // -------- 距離達成通知 --------
    if (profile.isEnabledistance == true) {
      final todayDistance = healthMap["stepDistance"] as int? ?? 0;
      await _checkDistanceGoal(
          todayDistance, profile.distance ?? 6000, now, hour);
    }

    // -------- 熱量達成通知 --------
    if (profile.isEnablecalories == true) {
      final todayCalories = healthMap["calories"] as int? ?? 0;
      await _checkCaloriesGoal(
          todayCalories, profile.calories ?? 2500, now, hour);
    }
  }

  // 🔥 拆分各個目標檢查邏輯
  Future<void> _checkStepsGoal(
      int todayStep, int targetSteps, DateTime now, int hour) async {
    if (todayStep >= targetSteps) {
      if (!NotificationRecordStorage.hasNotified(now, GoalType.stepsAchieved)) {
        await sendFirebaseNotify(
          title: '步數目標 達成！',
          body: '太棒了 🎉 今天已完成 $todayStep 步！為健康乾杯！',
        );
        await NotificationRecordStorage.markNotified(
            now, GoalType.stepsAchieved);
      }
    } else if (hour == 12 || hour == 20) {
      if (!NotificationRecordStorage.hasNotified(now, GoalType.stepsPending)) {
        await sendFirebaseNotify(
          title: '步數目標 努力中',
          body: '步數累積到 $todayStep 步，還差目標一點點，繼續努力😊',
        );
        await NotificationRecordStorage.markNotified(
            now, GoalType.stepsPending);
      }
    }
  }

  Future<void> _checkSleepGoal(
      double sleepHours, double targetHours, DateTime now) async {
    if (sleepHours >= targetHours) {
      if (!NotificationRecordStorage.hasNotified(now, GoalType.sleepAchieved)) {
        await sendFirebaseNotify(
          title: '睡眠目標 達成！',
          body: '睡飽飽！恭喜你昨晚睡滿 ${sleepHours.toStringAsFixed(1)} 小時，達成睡眠目標了！',
        );
        await NotificationRecordStorage.markNotified(
            now, GoalType.sleepAchieved);
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
      }
    }
  }

  Future<void> _checkDistanceGoal(
      int todayDistance, int targetDistance, DateTime now, int hour) async {
    if (todayDistance >= targetDistance) {
      if (!NotificationRecordStorage.hasNotified(
          now, GoalType.distanceAchieved)) {
        await sendFirebaseNotify(
          title: '運動距離目標 達成！',
          body: '太棒了🎉 今天運動距離已達 $todayDistance 公尺，為健康多走了一段！',
        );
        await NotificationRecordStorage.markNotified(
            now, GoalType.distanceAchieved);
      }
    } else if (hour == 12 || hour == 20) {
      if (!NotificationRecordStorage.hasNotified(
          now, GoalType.distancePending)) {
        await sendFirebaseNotify(
          title: '運動距離目標 努力中',
          body: '運動距離累積到 $todayDistance 公尺，繼續向目標前進！😊',
        );
        await NotificationRecordStorage.markNotified(
            now, GoalType.distancePending);
      }
    }
  }

  Future<void> _checkCaloriesGoal(
      int todayCalories, int targetCalories, DateTime now, int hour) async {
    if (todayCalories >= targetCalories) {
      if (!NotificationRecordStorage.hasNotified(
          now, GoalType.caloriesAchieved)) {
        await sendFirebaseNotify(
          title: '熱量目標 達成！',
          body: '恭喜 🎉 今天已消耗 $todayCalories 大卡了，你的努力身體都知道！',
        );
        await NotificationRecordStorage.markNotified(
            now, GoalType.caloriesAchieved);
      }
    } else if (hour == 12 || hour == 20) {
      if (!NotificationRecordStorage.hasNotified(
          now, GoalType.caloriesPending)) {
        await sendFirebaseNotify(
          title: '熱量目標 努力中',
          body: '目前消耗了 $todayCalories 大卡，離目標差一點！每次累積都是為健康加分 💪',
        );
        await NotificationRecordStorage.markNotified(
            now, GoalType.caloriesPending);
      }
    }
  }

  Future<void> sendFirebaseNotify(
      {required String title, required String body}) async {
    try {
      final payload = {
        "token": gc.firebaseToken.value,
        "title": title,
        "content": body,
        "dataKey": "",
        "dataVal": "",
      };
      var res = await apiService.postJson(
        Api.sendFirebase,
        payload,
      );

      if (res.isNotEmpty) {}
    } catch (e) {
      print("Notify API Error: $e");
    }
  }

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
      // LoadingHelper.hide();
      if (res.isNotEmpty && res["message"] == "SUCCESS") {
        final data = res["data"];
        if (data == null) return;
        final healthData = HealthDataSet.fromJson(data);
        final healthMap = await k73.getAnalysisHealthDataFromApi(healthData);
        print(healthMap);
      }
    } catch (e) {
      print("getFamilyData Error: $e");
    }
  }
}
