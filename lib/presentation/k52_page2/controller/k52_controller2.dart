import 'package:flutter/material.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/presentation/one7_bottomsheet/one7_bottomsheet.dart';
import '../../../core/app_export.dart';
import '../models/k52_model2.dart';

/// A controller class for the K52Page.
///
/// This class manages the state of the K52Page, including the
/// current k52ModelObj
class K52Controller2 extends GetxController {
  Rx<K52Model2> k52ModelObj = K52Model2().obs;
  var pickDate = ''.obs;
  @override
  void onInit() {
    super.onInit();
    getCurrentYearMonth();
  }

  Future<void> getCurrentYearMonth() async {
    final now = DateTime.now().format(pattern: 'yyyy 年 MM 月');
    pickDate.value = now;
  }

  Future<void> selectHistoryDate() async {
    await showModalBottomSheet(
        context: Get.context!,
        builder: (_) => One7Bottomsheet(
              onConfirm: (int year, int month) {
                final pick = '$year 年 $month 月';
                pickDate.value = pick;
                print(pick);
              },
            ));
  }
}
