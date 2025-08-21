import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/remider_setting.dart';
import 'package:pulsedevice/core/hiveDb/remider_setting_storage.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
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
  ApiService service = ApiService();

  @override
  void onInit() async {
    super.onInit();
    await notificationService.initialize();
    await checkPermission();

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

  /// 🔄 新增：監聽 Switch 狀態變化
  // void _listenToSwitchChanges() {
  //   ever(isSelectedSwitch, (bool isEnabled) async {
  //     // 自動儲存設定
  //     await saveReminderSettings();
  //   });
  // }

  Future<void> selectAlertTime() async {
    final result = await DialogHelper.showCustomBottomSheet(
      Get.context!,
      K50Bottomsheet(Get.put(K50Controller())),
    );
    if (result != null && result.isNotEmpty) {
      alertTime.value = result;
    }
  }

  Future<void> selectEatTime() async {
    final result = await DialogHelper.showCustomBottomSheet(
      Get.context!,
      K51Bottomsheet(Get.put(K51Controller())),
    );
    if (result != null && result.isNotEmpty) {
      eatTime.value = result;
      await saveReminderSettings();
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
      await scheduleReminder(alertTime.value, eatTime.value,
          isAlert: isSelectedSwitch.value);
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
      } else {
        await getReminderInfo();
      }
    } catch (e) {
      print('❌ 載入用藥設定失敗: $e');
    }
  }

  Future<void> checkPermission() async {
    if (Platform.isAndroid) {
      await notificationService.requestExactAlarmPermission();
    }
  }

  Future<void> scheduleReminder(String frequency, String eatTime,
      {bool? isAlert}) async {
    try {
      var eatT = "";
      var freqT = "";
      print('🔔 開始設定用藥提醒frequency: $frequency');
      print('🔔 開始設定用藥提醒eatTime: $eatTime');
      switch (eatTime) {
        case '飯前':
          eatT = "MF";
          break;
        case '飯中':
          eatT = "MM";
          break;
        case '飯後':
          eatT = "MB";
          break;
        default:
          eatT = "MB";
          break;
      }

      switch (frequency) {
        case '每天一次':
          freqT = "D1";
          break;
        case '一天兩次':
          freqT = "D2";
          break;
        case '一天三次':
          freqT = "D3";
          break;
        case '一天四次':
          freqT = "D4";
          break;
        case '每晚一次':
          freqT = "S1";
          break;
        case '兩天一次':
          freqT = "2D1";
          break;
        case '三天一次':
          freqT = "3D1";
          break;
        default:
          freqT = "D1";
          eatT = "MB";
          return;
      }
      await setReminderInfo(freqT, eatT, isAlert: isAlert);

      print('✅ 用藥提醒設定完成: $frequency');
    } catch (e) {
      print('❌ 設定用藥提醒失敗: $e');
      rethrow;
    }
  }

  Future<void> getReminderInfo() async {
    try {
      final payload = {
        "userID": gc.apiId.value,
      };
      var res = await service.postJson(
        Api.reminderInfoGet,
        payload,
      );

      if (res.isNotEmpty) {
        final resMsg = res["message"];
        if (resMsg == "SUCCESS") {
          final data = res["data"];
          if (data != null && data.length > 0) {
            isSelectedSwitch.value = data["alert"];
          }
        }
      }
    } catch (e) {}
  }

  /// 三天一次:3D1,兩天一次:2D1,每天一次:D1,一天兩次:D2,一天三次:D3,一天四次:D4,每晚一次:S1
  /// 飯前:MF,飯後:MB,飯中:MM
  Future<void> setReminderInfo(String type, String status,
      {bool? isAlert}) async {
    try {
      final payload = {
        "userID": gc.apiId.value,
        "type": type,
        "status": status,
        "alert": isAlert ?? false
      };
      var res = await service.postJson(
        Api.reminderInfoSet,
        payload,
      );

      if (res.isNotEmpty) {
        if (isSelectedSwitch.value) {
          SnackbarHelper.showBlueSnackbar(
            message: '已成功設定 ${alertTime.value} 的用藥提醒',
          );
        } else {
          SnackbarHelper.showBlueSnackbar(
            message: '已關閉用藥提醒',
          );
        }
      }
    } catch (e) {}
  }

  /// 🔄 新增：獲取當前用藥提醒狀態
  bool get isMedicationReminderEnabled => isSelectedSwitch.value;

  /// 🔄 新增：獲取當前用藥頻率
  String get currentMedicationFrequency => alertTime.value;

  /// 🔄 新增：檢查是否有完整設定
  bool get hasCompleteSettings =>
      alertTime.value.isNotEmpty && eatTime.value.isNotEmpty;
}
