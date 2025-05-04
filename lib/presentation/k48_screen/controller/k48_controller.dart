import 'dart:async';
import 'package:get/get.dart';
import 'package:pulsedevice/core/service/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/app_export.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../core/utils/loading_helper.dart';
import '../../k50_bottomsheet/controller/k50_controller.dart';
import '../../k50_bottomsheet/k50_bottomsheet.dart';
import '../../k51_bottomsheet/controller/k51_controller.dart';
import '../../k51_bottomsheet/k51_bottomsheet.dart';
import '../models/k48_model.dart';

class K48Controller extends GetxController {
  Rx<K48Model> k48ModelObj = K48Model().obs;

  Rx<bool> isSelectedSwitch = false.obs;
  RxString alertTime = ''.obs;
  RxString eatTime = ''.obs;

  Timer? _autoSaveTimer;

  final _keySwitch = 'k48_switch';
  final _keyAlertTime = 'k48_alert_time';
  final _keyEatTime = 'k48_eat_time';
  final notificationService = NotificationService();

  @override
  void onInit() {
    super.onInit();
    notificationService.initialize(); // 初始化通知服務
    // 延遲初始化，確保 UI 完整建立後再執行
    Future.delayed(Duration.zero, () async {
      await loadReminderSettings();
      _startAutoSaveTimer();
    });
  }

  @override
  void onClose() {
    _autoSaveTimer?.cancel();
    saveReminderSettings();
    super.onClose();
  }

  Future<void> selectAlertTime() async {
    final result = await DialogHelper.showCustomBottomSheet(
      Get.context!,
      K50Bottomsheet(Get.put(K50Controller())),
    );
    if (result != null && result.isNotEmpty) {
      alertTime.value = result;
      scheduleReminderFromUserChoice(alertTime.value);
    }
  }

  Future<void> selectEatTime() async {
    final result = await DialogHelper.showCustomBottomSheet(
      Get.context!,
      K51Bottomsheet(Get.put(K51Controller())),
    );
    if (result != null && result.isNotEmpty) {
      eatTime.value = result;
    }
  }

  /// 30  ,
  void _startAutoSaveTimer() {
    _autoSaveTimer = Timer.periodic(Duration(seconds: 30), (_) {
      saveReminderSettings();
    });
  }

  Future<void> saveReminderSettings() async {
    try {
      LoadingHelper.show(message: '儲存中...');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keySwitch, isSelectedSwitch.value);
      await prefs.setString(_keyAlertTime, alertTime.value);
      await prefs.setString(_keyEatTime, eatTime.value);
    } finally {
      LoadingHelper.hide();
    }
  }

  Future<void> loadReminderSettings() async {
    try {
      LoadingHelper.show(message: '載入中...');
      final prefs = await SharedPreferences.getInstance();
      isSelectedSwitch.value = prefs.getBool(_keySwitch) ?? false;
      alertTime.value = prefs.getString(_keyAlertTime) ?? '';
      eatTime.value = prefs.getString(_keyEatTime) ?? '';
    } finally {
      LoadingHelper.hide();
    }
  }

  Future<void> scheduleReminderFromUserChoice(String frequency) async {
    await notificationService.scheduleReminder(frequency); // 根據使用者選擇的頻率設定提醒
  }
}
