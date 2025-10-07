import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/service/firebase_analytics_service.dart';
import 'package:pulsedevice/core/hiveDb/alert_record.dart';
import 'package:pulsedevice/core/hiveDb/alert_record_list_storage.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/presentation/one7_bottomsheet/controller/one7_controller.dart';
import 'package:pulsedevice/presentation/one7_bottomsheet/one7_bottomsheet.dart';
import '../models/k53_model.dart';

class K53Controller extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<K53Model> k53ModelObj = K53Model().obs;
  final gc = Get.find<GlobalController>();
  ApiService apiService = ApiService();

  late TabController tabviewController;
  Rx<int> tabIndex = 0.obs;
  final selectedIndex = 0.obs;

  final alertRecords = <AlertRecord>[].obs;
  final filteredRecords = <AlertRecord>[].obs;
  final hasLoaded = false.obs;
  final selectedYear = DateTime.now().year.obs;
  final selectedMonth = DateTime.now().month.obs;
  final pickDate = ''.obs;
  final List<Map<String, dynamic>> notifyDataList =
      <Map<String, dynamic>>[].obs;
  final Map<String, num> nofiyDataSum = <String, num>{}.obs;

  @override
  void onInit() {
    super.onInit();

    tabviewController = TabController(length: 2, vsync: this, initialIndex: 0);
    tabviewController.addListener(() {
      if (!tabviewController.indexIsChanging) {
        selectedIndex.value = tabviewController.index;
      }
    });

    // 📊 記錄警報紀錄頁面瀏覽事件
    FirebaseAnalyticsService.instance.logViewAlertHistory();

    Future.delayed(Duration.zero, () async {
      final nList = await getNotifyList();
      notifyDataList.assignAll(nList);
      final nSum = await getNotifyListSum();
      nofiyDataSum.assignAll(nSum);
      await getRecords();
    });
  }

  @override
  void onClose() {
    tabviewController.dispose();
    super.onClose();
  }

  Future<void> getRecords() async {
    try {
      final records = await AlertRecordListStorage.getRecords(gc.userId.value);
      alertRecords.assignAll(records);
      _filterRecords();
      _updatePickDate();
      hasLoaded.value = true;
    } catch (e) {
      print("❌ 讀取警報紀錄失敗：$e");
    } finally {}
  }

  void setSelectedDate(int year, int month) async {
    selectedYear.value = year;
    selectedMonth.value = month;
    final list = await getNotifyList();
    final sum = await getNotifyListSum();
    notifyDataList.assignAll(list);
    nofiyDataSum.assignAll(sum);
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

  //INFO:通知消息, WARN 警報紀錄
  Future<List<Map<String, dynamic>>> getNotifyList() async {
    // LoadingHelper.show();
    var month = selectedMonth.value.toString().padLeft(2, '0');

    try {
      final payload = {
        "type": "WARN", //INFO:通知消息, WARN 警報紀錄
        "date": "${selectedYear.value}-${month}",
        "userID": gc.apiId.value
      };
      var res = await apiService.postJson(
        Api.notifyList,
        payload,
      );
      // LoadingHelper.hide();
      if (res.isNotEmpty) {
        if (res["message"] == "SUCCESS") {
          final data = res["data"];
          if (data != null) {
            return List<Map<String, dynamic>>.from(data);
          }
        }
      }
      return [];
    } catch (e) {
      print("Notify API Error: $e");
      return [];
    }
  }

  Future<Map<String, num>> getNotifyListSum() async {
    try {
      var month = selectedMonth.value.toString().padLeft(2, '0');
      final payload = {
        "date": "$selectedYear-$month",
        "userID": gc.apiId.value
      };

      var res = await apiService.postJson(Api.notifyListSum, payload);

      if (res.isNotEmpty && res["message"] == "SUCCESS") {
        final data = res["data"];
        if (data != null && data is Map) {
          return Map<String, num>.from(data);
        }
      }
    } catch (e) {
      print("Notify API Error: $e");
    }

    // 保底 return（一定要有）
    return {};
  }
}
