import 'package:flutter/material.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/presentation/k27_screen/dialog_utils.dart';
import '../../../core/app_export.dart';
import '../models/k27_model.dart';

/// A controller class for the K27Screen.
///
/// This class manages the state of the K27Screen, including the
/// current k27ModelObj
class K27Controller extends GetxController {
  TextEditingController genderController = TextEditingController();

  TextEditingController inputlighttwoController = TextEditingController();


  Rx<K27Model> k27ModelObj = K27Model().obs;
  RxString heightValueObx = ''.obs;

  var weightValueObx = ''.obs;

  // RxString selectedGender = '男'.obs; // Default to '男'

  @override
  void onClose() {
    super.onClose();
    inputlighttwoController.dispose();
    genderController.dispose();
  }

  void selectGenderDialog() {
    DialogUtils.showGenderSelectionDialog(
      onSelected: (index, value) {
        genderController.text = value;
      },
    );
  }

  void showTimeDialog() {
    DialogUtils.showDatePickerDialog(
      initialDate: DateTime.now(),
      onDateSelected: (date) {
        // 处理选择的日期
        k27ModelObj.value.selectedInputlightTwo!.value = date;
        inputlighttwoController.text = date.format(pattern: Y_M_D);
      },
    );
  }

  void showHeightInputDialog() {
    DialogUtils.showHeightInputDialog(
      onConfirmed: (p0) {
        heightValueObx.value = p0;
      },
    );
  }

  void showWeightInputDialog() {
    DialogUtils.showWeightInputDialog(
      onConfirmed: (p0) => weightValueObx.value = p0,
    );
  }
}
