import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_selection_dialog.dart';
import 'custom_date_picker_dialog.dart';
import 'custom_input_dialog.dart';

class DialogUtils {
  /// 显示选择对话框（如性别选择）
  static void showSelectionDialog({
    required List<String> options,
    String? title,
    Function(int, String)? onSelected,
  }) {
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) => CustomSelectionDialog(
        options: options,
        title: title,
        onSelected: onSelected,
      ),
    );
  }

  /// 显示日期选择对话框
  static void showDatePickerDialog({
    String? title,
    DateTime? initialDate,
    Function(DateTime)? onDateSelected,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) => CustomDatePickerDialog(
        title: title,
        initialDate: initialDate,
        onDateSelected: onDateSelected,
        startDate: startDate??DateTime(1950),
        endDate: endDate??DateTime.now(),
      ),
    );
  }

  /// 显示输入对话框（如身高、体重输入）
  static void showInputDialog({
    required String title,
    required String subtitle,
    required String unit,
    String? initialValue,
    Function(String)? onConfirmed,
    TextInputType? keyboardType,
    String? hintText,
  }) {
    Get.dialog(
      CustomInputDialog(
        title: title,
        subtitle: subtitle,
        unit: unit,
        initialValue: initialValue,
        onConfirmed: onConfirmed,
        keyboardType: keyboardType,
        hintText: hintText,
      ),
      barrierDismissible: true,
    );
  }

  /// 显示性别选择对话框
  static void showGenderSelectionDialog({
    Function(int, String)? onSelected,
  }) {
    showSelectionDialog(
      options: ['男', '女'],
      onSelected: onSelected,
    );
  }

  /// 显示身高输入对话框
  static void showHeightInputDialog({
    String? initialValue,
    Function(String)? onConfirmed,
  }) {
    showInputDialog(
      title: '請輸入目前身高',
      subtitle: '輸入精準數字，有助於健康分析',
      unit: 'cm',
      initialValue: initialValue,
      onConfirmed: onConfirmed,
      hintText: '請輸入',
    );
  }

  /// 显示体重输入对话框
  static void showWeightInputDialog({
    String? initialValue,
    Function(String)? onConfirmed,
  }) {
    showInputDialog(
      title: '請輸入目前體重',
      subtitle: '輸入精準數字，有助於健康分析',
      unit: 'kg',
      initialValue: initialValue,
      onConfirmed: onConfirmed,
      hintText: '請輸入',
    );
  }

  /// 显示出生日期选择对话框
  static void showBirthDatePickerDialog({
    DateTime? initialDate,
    Function(DateTime)? onDateSelected,
  }) {
    showDatePickerDialog(
      title: '選擇出生日期',
      initialDate: initialDate ?? DateTime(1994, 5, 1),
      onDateSelected: onDateSelected,
      startDate: DateTime(1950),
      endDate: DateTime.now(),
    );
  }
}
