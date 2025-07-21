import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/remider_setting.dart';
import 'package:pulsedevice/core/hiveDb/remider_setting_storage.dart';
import 'package:pulsedevice/core/service/notification_service.dart';
import 'package:pulsedevice/core/utils/snackbar_helper.dart';
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
  final gc = Get.find<GlobalController>();

  Rx<bool> isSelectedSwitch = false.obs;
  RxString alertTime = ''.obs;
  RxString eatTime = ''.obs;

  Timer? _autoSaveTimer;
  late RemiderSetting profile;
  final notificationService = NotificationService();

  @override
  void onInit() async {
    super.onInit();
    await notificationService.initialize();
    await checkPermission();

    // 延遲初始化，確保 UI 完整建立後再執行
    Future.delayed(Duration.zero, () async {
      await loadReminderSettings();
      _startAutoSaveTimer();

      // 🔄 新增：監聽 Switch 狀態變化
      _listenToSwitchChanges();
    });
  }

  @override
  void onClose() {
    _autoSaveTimer?.cancel();
    saveReminderSettings();
    super.onClose();
  }

  /// 🔄 新增：監聽 Switch 狀態變化
  void _listenToSwitchChanges() {
    ever(isSelectedSwitch, (bool isEnabled) async {
      if (isEnabled) {
        // Switch 開啟：如果有設定頻率，則啟動通知
        if (alertTime.value.isNotEmpty) {
          await _enableMedicationReminder();
        }
      } else {
        // Switch 關閉：停用所有通知
        await _disableMedicationReminder();
      }

      // 自動儲存設定
      await saveReminderSettings();
    });
  }

  Future<void> selectAlertTime() async {
    final result = await DialogHelper.showCustomBottomSheet(
      Get.context!,
      K50Bottomsheet(Get.put(K50Controller())),
    );
    if (result != null && result.isNotEmpty) {
      alertTime.value = result;

      // 🔄 修改：只有在 Switch 開啟時才設定通知
      if (isSelectedSwitch.value) {
        await _enableMedicationReminder();
      }
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

  /// 🔄 新增：啟用用藥提醒
  Future<void> _enableMedicationReminder() async {
    try {
      if (alertTime.value.isNotEmpty) {
        print('🔔 啟用用藥提醒: ${alertTime.value}');
        await notificationService.scheduleReminder(alertTime.value);
        SnackbarHelper.showBlueSnackbar(
          message: '已成功設定 ${alertTime.value} 的用藥提醒',
        );
      }
    } catch (e) {
      print('❌ 啟用用藥提醒失敗: $e');
      Get.snackbar(
        '錯誤',
        '設定用藥提醒失敗，請重試',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  /// 🔄 新增：停用用藥提醒
  Future<void> _disableMedicationReminder() async {
    try {
      print('🔕 停用用藥提醒');
      await notificationService.stopAllMedicationReminders();

      // 顯示停用訊息
      Get.snackbar(
        '用藥提醒',
        '已停用所有用藥提醒',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('❌ 停用用藥提醒失敗: $e');
    }
  }

  /// 30秒自動儲存
  void _startAutoSaveTimer() {
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      saveReminderSettings();
    });
  }

  /// 🔄 修改：儲存提醒設定
  Future<void> saveReminderSettings() async {
    try {
      profile = RemiderSetting(
        frequency: alertTime.value,
        timing: eatTime.value,
        alertEnabled: isSelectedSwitch.value,
        lastUpdated: DateTime.now(), // 🔄 新增：記錄更新時間
      );
      await RemiderSettingStorage.saveUserProfile(gc.userId.value, profile);
      print('✅ 用藥設定已儲存');
    } catch (e) {
      print('❌ 儲存用藥設定失敗: $e');
    }
  }

  /// 🔄 修改：載入提醒設定
  Future<void> loadReminderSettings() async {
    try {
      var savedProfile =
          await RemiderSettingStorage.getUserProfile(gc.userId.value);
      if (savedProfile != null) {
        isSelectedSwitch.value = savedProfile.alertEnabled;
        alertTime.value = savedProfile.frequency;
        eatTime.value = savedProfile.timing;

        print(
            '✅ 已載入用藥設定: 開關=${savedProfile.alertEnabled}, 頻率=${savedProfile.frequency}');

        // 🔄 新增：如果開關是開啟且有設定頻率，自動啟用提醒
        if (savedProfile.alertEnabled && savedProfile.frequency.isNotEmpty) {
          // 延遲一點時間，確保 UI 已經更新
          Future.delayed(const Duration(milliseconds: 500), () async {
            await _enableMedicationReminder();
          });
        }
      }
    } catch (e) {
      print('❌ 載入用藥設定失敗: $e');
    }
  }

  /// 🔄 新增：手動同步通知狀態（如果需要的話）
  Future<void> syncNotificationState() async {
    if (isSelectedSwitch.value && alertTime.value.isNotEmpty) {
      await _enableMedicationReminder();
    } else {
      await _disableMedicationReminder();
    }
  }

  /// 🔄 保留原有方法（向後相容）
  Future<void> scheduleReminderFromUserChoice(String frequency) async {
    if (isSelectedSwitch.value) {
      await notificationService.scheduleReminder(frequency);
    }
  }

  Future<void> checkPermission() async {
    if (Platform.isAndroid) {
      await notificationService.requestExactAlarmPermission();
    }
  }

  /// 🔄 新增：獲取當前用藥提醒狀態
  bool get isMedicationReminderEnabled => isSelectedSwitch.value;

  /// 🔄 新增：獲取當前用藥頻率
  String get currentMedicationFrequency => alertTime.value;

  /// 🔄 新增：檢查是否有完整設定
  bool get hasCompleteSettings =>
      alertTime.value.isNotEmpty && eatTime.value.isNotEmpty;
}
