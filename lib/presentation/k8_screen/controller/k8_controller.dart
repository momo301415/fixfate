import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import '../models/k8_model.dart';

/// A controller class for the K8Screen.
///
/// This class manages the state of the K8Screen, including the
/// current k8ModelObj
class K8Controller extends GetxController {
  Rx<K8Model> k8ModelObj = K8Model().obs;
  
  // 日期切换相关属性
  RxInt currentIndex = 0.obs; // 预设日
  RxString formattedRange = ''.obs;
  List<String> timeTabs = ['lbl229'.tr, 'lbl230'.tr, 'lbl231'.tr]; // 日、周、月
  Rx<DateTime> currentDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    updateDateRange(currentIndex.value);
  }

  /// 更新日期范围显示
  void updateDateRange(int index) {
    if (index == 0) {
      // 日
      formattedRange.value =
          "${currentDate.value.format(pattern: 'M月d日, EEEE', locale: 'zh_CN')}";
    } else if (index == 1) {
      // 周
      final startOfWeek = currentDate.value
          .subtract(Duration(days: currentDate.value.weekday - 1));
      final endOfWeek = startOfWeek.add(Duration(days: 6));
      formattedRange.value =
          '${startOfWeek.format(pattern: 'M月d日')} ～ ${endOfWeek.format(pattern: 'M月d日')}';
    } else {
      // 月
      formattedRange.value =
          "${currentDate.value.year}年 ${currentDate.value.month}月";
    }
  }

  /// 上一个日期范围
  void prevDateRange() {
    final index = currentIndex.value;
    if (index == 0) {
      currentDate.value = currentDate.value.subtract(const Duration(days: 1));
    } else if (index == 1) {
      final currentWeekStart = currentDate.value
          .subtract(Duration(days: currentDate.value.weekday - 1));
      final prevWeekStart = currentWeekStart.subtract(Duration(days: 7));
      currentDate.value = prevWeekStart;
    } else {
      currentDate.value = DateTime(
        currentDate.value.year,
        currentDate.value.month - 1,
        currentDate.value.day,
      );
    }
    updateDateRange(index);
  }

  /// 下一个日期范围
  void nextDateRange() {
    final index = currentIndex.value;
    if (index == 0) {
      currentDate.value = currentDate.value.add(const Duration(days: 1));
    } else if (index == 1) {
      final currentWeekStart = currentDate.value
          .subtract(Duration(days: currentDate.value.weekday - 1));
      final nextWeekStart = currentWeekStart.add(Duration(days: 7));
      currentDate.value = nextWeekStart;
    } else {
      currentDate.value = DateTime(
        currentDate.value.year,
        currentDate.value.month + 1,
        currentDate.value.day,
      );
    }
    updateDateRange(index);
  }

  /// 日期选择器（简化版本，可以根据需要扩展）
  void datePicker() {
    // 这里可以添加日期选择器的逻辑
    // 暂时保持空实现，可以根据需要添加具体的日期选择功能
  }
}
