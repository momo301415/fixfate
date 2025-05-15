import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/alert_record.dart';
import 'package:pulsedevice/core/hiveDb/alert_record_list_storage.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/presentation/one7_bottomsheet/controller/one7_controller.dart';
import 'package:pulsedevice/presentation/one7_bottomsheet/one7_bottomsheet.dart';
import '../models/k53_model.dart';

class K53Controller extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<K53Model> k53ModelObj = K53Model().obs;
  final gc = Get.find<GlobalController>();

  late TabController tabviewController;
  Rx<int> tabIndex = 0.obs;
  final selectedIndex = 0.obs;

  final alertRecords = <AlertRecord>[].obs;
  final filteredRecords = <AlertRecord>[].obs;
  final hasLoaded = false.obs;
  final selectedYear = DateTime.now().year.obs;
  final selectedMonth = DateTime.now().month.obs;
  final pickDate = ''.obs;

  @override
  void onInit() {
    super.onInit();

    tabviewController = TabController(length: 2, vsync: this, initialIndex: 0);
    tabviewController.addListener(() {
      if (!tabviewController.indexIsChanging) {
        selectedIndex.value = tabviewController.index;
      }
    });

    Future.delayed(Duration.zero, () => getRecords());
  }

  @override
  void onClose() {
    tabviewController.dispose();
    super.onClose();
  }

  void animateTo(int index) {
    tabviewController.animateTo(index);
  }

  Future<void> getRecords() async {
    try {
      LoadingHelper.show();
      final records = await AlertRecordListStorage.getRecords(gc.userId.value);
      alertRecords.assignAll(records);
      _filterRecords();
      _updatePickDate();
      hasLoaded.value = true;
    } catch (e) {
      print("❌ 讀取警報紀錄失敗：$e");
    } finally {
      LoadingHelper.hide();
    }
  }

  void setSelectedDate(int year, int month) {
    selectedYear.value = year;
    selectedMonth.value = month;
    _filterRecords();
    _updatePickDate();
  }

  void _updatePickDate() {
    pickDate.value = '${selectedYear.value} 年 ${selectedMonth.value} 月';
  }

  void _filterRecords() {
    final filtered = alertRecords.where((record) {
      return record.time.year == selectedYear.value &&
          record.time.month == selectedMonth.value;
    }).toList();

    filteredRecords.assignAll(filtered);
  }

  Future<void> selectHistoryDate() async {
    final controller = Get.put(One7Controller());
    controller.resetToToday();
    await showModalBottomSheet(
      context: Get.context!,
      builder: (_) => One7Bottomsheet(
        onConfirm: (int year, int month) {
          setSelectedDate(year, month);
        },
      ),
    );
  }
}
