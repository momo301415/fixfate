import 'package:flutter/material.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/presentation/k22_bottomsheet/controller/k22_controller.dart';
import 'package:pulsedevice/presentation/k22_bottomsheet/k22_bottomsheet.dart';
import 'package:pulsedevice/presentation/k23_dialog/controller/k23_controller.dart';
import 'package:pulsedevice/presentation/k23_dialog/k23_dialog.dart';
import 'package:pulsedevice/presentation/k25_dialog/controller/k25_controller.dart';
import 'package:pulsedevice/presentation/k25_dialog/k25_dialog.dart';
import 'package:pulsedevice/presentation/k28_dialog/controller/k28_controller.dart';
import 'package:pulsedevice/presentation/k28_dialog/k28_dialog.dart';
import 'package:pulsedevice/presentation/k31_bottomsheet/controller/k31_controller.dart';
import 'package:pulsedevice/presentation/k31_bottomsheet/k31_bottomsheet.dart';
import 'package:pulsedevice/presentation/k32_dialog/controller/k32_controller.dart';
import 'package:pulsedevice/presentation/k32_dialog/k32_dialog.dart';
import 'package:pulsedevice/presentation/k34_dialog/controller/k34_controller.dart';
import 'package:pulsedevice/presentation/k34_dialog/k34_dialog.dart';
import 'package:pulsedevice/presentation/k35_bottomsheet/controller/k35_controller.dart';
import 'package:pulsedevice/presentation/k35_bottomsheet/k35_bottomsheet.dart';
import 'package:pulsedevice/presentation/k36_dialog/controller/k36_controller.dart';
import 'package:pulsedevice/presentation/k36_dialog/k36_dialog.dart';

import '../../../core/app_export.dart';
import '../models/k30_model.dart';

/// A controller class for the K30Screen.
///
/// This class manages the state of the K30Screen, including the
/// current k30ModelObj
class K30Controller extends GetxController {
  Rx<K30Model> k30ModelObj = K30Model().obs;
  var avatarPath = "".obs;
  var nickName = "".obs;
  var email = "".obs;
  var gender = "".obs;
  var birth = "".obs;
  var height = "".obs;
  var weight = "".obs;
  var waistline = "".obs;
  var inputTexted = "".obs;

  Future<void> selectAvatar() async {
    final path = await DialogHelper.showCustomBottomSheet<String>(
      Get.context!,
      K31Bottomsheet(Get.put(K31Controller())),
    );

    if (path != null && path.isNotEmpty) {
      avatarPath.value = path;
    }
  }

  Future<void> showInputNickName() async {
    final result = await DialogHelper.showCustomDialog(
        Get.context!, K32Dialog(Get.put(K32Controller())));
    if (result != null && result.isNotEmpty) {
      nickName.value = result;
    }
  }

  Future<void> showInputEmail() async {
    final result = await DialogHelper.showCustomDialog<String>(
        Get.context!, K34Dialog(Get.put(K34Controller())));
    if (result != null && result.isNotEmpty) {
      email.value = result;
    }
  }

  Future<void> selectGender() async {
    final result = await DialogHelper.showCustomBottomSheet(
        Get.context!, K35Bottomsheet(Get.put(K35Controller())));
    if (result != null && result.isNotEmpty) {
      gender.value = result;
    }
  }

  Future<void> selectBirth() async {
    final result = await showModalBottomSheet(
        context: Get.context!,
        builder: (_) => K22Bottomsheet(Get.put(K22Controller())));
    if (result != null && result.isNotEmpty) {
      birth.value = result;
    }
  }

  Future<void> showInputHeight() async {
    final result = await DialogHelper.showCustomDialog(
        Get.context!, K23Dialog(Get.put(K23Controller())));
    if (result != null && result.isNotEmpty) {
      height.value = result;
    }
  }

  Future<void> showInputWeight() async {
    final result = await DialogHelper.showCustomDialog(
        Get.context!, K25Dialog(Get.put(K25Controller())));
    if (result != null && result.isNotEmpty) {
      weight.value = result;
    }
  }

  Future<void> showInputWaistline() async {
    final result = await DialogHelper.showCustomDialog(
        Get.context!, K28Dialog(Get.put(K28Controller())));
    if (result != null && result.isNotEmpty) {
      waistline.value = result;
    }
  }

  Future<void> showInputTexted() async {
    final result = await DialogHelper.showCustomDialog(
        Get.context!, K36Dialog(Get.put(K36Controller())));
    if (result != null && result.isNotEmpty) {
      inputTexted.value = result;
    }
  }

  void handleChipTap<T>({
    required int index,
    required T model,
    required BuildContext context,
    required String title,
    required String subTitle,
    required RxList<T> list,
    required T Function(String text) createModel,
    RxList<T>? Function()? onRefresh, // 若需特殊 refresh 可擴展
    void Function(T model)? onToggle,
  }) async {
    final lastIndex = list.length - 1;
    final isLastChip = index == lastIndex;

    if (isLastChip) {
      final result = await DialogHelper.showCustomDialog<String>(
        context,
        K36Dialog(
          Get.put(K36Controller()),
          title: title,
          subTitle: subTitle,
        ),
      );

      if (result != null && result.trim().isNotEmpty) {
        list.insert(lastIndex, createModel(result));
        onRefresh?.call()?.refresh();
        // 👉 清除 K36 的輸入框文字
        final dialogController = Get.find<K36Controller>();
        dialogController.inputlightoneController.clear();
        dialogController.inputedText.value = '';
      }
    } else {
      onToggle?.call(model);
    }
  }
}
