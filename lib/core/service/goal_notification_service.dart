import 'package:get/get.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/goal_profile_storage.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/sqliteDb/sleep_data_service.dart';
import 'package:pulsedevice/core/sqliteDb/step_data_service.dart';

class GoalNotificationService {
  final String userId;
  final StepDataService stepService;
  final SleepDataService sleepService;
  ApiService apiService = ApiService();
  final gc = Get.find<GlobalController>();

  GoalNotificationService({
    required this.userId,
    required this.stepService,
    required this.sleepService,
  });

  Future<void> checkTodayGoalsAndNotify() async {
    final profile = await GoalProfileStorage.getUserProfile(userId);
    if (profile == null) return;

    final now = DateTime.now();
    final hour = now.hour;

    // -------- 步數達成通知 --------
    if (profile.isEnableSteps == true) {
      final todayStep = await stepService.getTodayStepTotal(userId);
      if (todayStep >= (profile.steps ?? 10000)) {
        if (!NotificationRecordStorage.hasNotified(
            now, GoalType.stepsAchieved)) {
          await sendFirebaseNotify(
            title: '步數目標 達成！',
            body: '太棒了 🎉 今天已完成 $todayStep 步！為健康乾杯！',
          );
          await NotificationRecordStorage.markNotified(
              now, GoalType.stepsAchieved);
        }
      } else if (hour == 12 || hour == 20) {
        if (!NotificationRecordStorage.hasNotified(
            now, GoalType.stepsPending)) {
          await sendFirebaseNotify(
            title: '步數目標 努力中',
            body: '步數累積到 $todayStep 步，還差目標一點點，繼續努力😊',
          );
          await NotificationRecordStorage.markNotified(
              now, GoalType.stepsPending);
        }
      }
    }

    // -------- 睡眠目標通知 --------
    if (profile.isEnablesleepHours == true && hour == 12) {
      final totalSeconds = await sleepService.getTodaySleepTotalSeconds(userId);
      final sleepHours = totalSeconds / 3600;

      if (sleepHours >= (profile.sleepHours ?? 8.0)) {
        if (!NotificationRecordStorage.hasNotified(
            now, GoalType.sleepAchieved)) {
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

    // -------- 距離達成通知 --------
    if (profile.isEnabledistance == true) {
      final todayDistance = await stepService.getTodayDistanceTotal(userId);
      if (todayDistance >= (profile.distance ?? 6000)) {
        if (!NotificationRecordStorage.hasNotified(
            now, GoalType.sleepAchieved)) {
          await sendFirebaseNotify(
            title: '運動距離目標 達成！',
            body: '太棒了🎉 今天運動距離已達 $todayDistance 公尺，為健康多走了一段！',
          );
          await NotificationRecordStorage.markNotified(
              now, GoalType.distanceAchieved);
        }
      } else if (hour == 12 || hour == 20) {
        if (!NotificationRecordStorage.hasNotified(
            now, GoalType.sleepAchieved)) {
          await sendFirebaseNotify(
            title: '運動距離目標 努力中',
            body: '運動距離累積到 $todayDistance 公尺，繼續向目標前進！😊',
          );
          await NotificationRecordStorage.markNotified(
              now, GoalType.distancePending);
        }
      }
    }

    // -------- 熱量達成通知 --------
    if (profile.isEnablecalories == true) {
      final todayCalories = await stepService.getTodayCaroliesTotal(userId);
      if (todayCalories >= (profile.calories ?? 2500)) {
        if (!NotificationRecordStorage.hasNotified(
            now, GoalType.sleepAchieved)) {
          await sendFirebaseNotify(
            title: '熱量目標 達成！',
            body: '恭喜 🎉 今天已消耗 $todayCalories 大卡了，你的努力身體都知道！',
          );
          await NotificationRecordStorage.markNotified(
              now, GoalType.caloriesAchieved);
        }
      } else if (hour == 12 || hour == 20) {
        if (!NotificationRecordStorage.hasNotified(
            now, GoalType.sleepAchieved)) {
          await sendFirebaseNotify(
            title: '熱量目標 努力中',
            body: '目前消耗了 $todayCalories 大卡，離目標差一點！每次累積都是為健康加分 💪',
          );
          await NotificationRecordStorage.markNotified(
              now, GoalType.caloriesPending);
        }
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
}
