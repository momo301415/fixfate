import 'package:flutter/material.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/service/firebase_analytics_service.dart';
import 'package:pulsedevice/core/hiveDb/sport_record.dart';
import 'package:pulsedevice/core/hiveDb/sport_record_list_storage.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/presentation/one7_bottomsheet/controller/one7_controller.dart';
import 'package:pulsedevice/presentation/one7_bottomsheet/one7_bottomsheet.dart';
import '../../../core/app_export.dart';
import '../models/k6_model.dart';

/// A controller class for the K6Page.
///
/// This class manages the state of the K6Page, including the
/// current k6ModelObj
class K6Controller extends GetxController
    with GetSingleTickerProviderStateMixin {
  final gc = Get.find<GlobalController>();

  late TabController tabviewController;
  late int argIndex;

  /// 0 = 有氧, 1 = 重訓
  RxInt tabIndex = 0.obs;

  Rx<K6Model> k6ModelObj = K6Model().obs;

  ///data base

  final aerobicRecords = <SportRecord>[].obs;
  final weightTrainingRecords = <SportRecord>[].obs;

  final groupedAerobic = <SportRecordGroup>[].obs;
  final groupedWeightTraining = <SportRecordGroup>[].obs;

  final hasLoaded = false.obs;
  final selectedYear = DateTime.now().year.obs;
  final selectedMonth = DateTime.now().month.obs;
  final pickDate = ''.obs;

  String get formattedPickDate =>
      '${selectedYear.value} 年 ${selectedMonth.value} 月';

  RxList<SportRecordGroup> groupedRecords = <SportRecordGroup>[].obs;

  @override
  void onInit() {
    super.onInit();
    argIndex = Get.arguments as int;
    tabIndex.value = argIndex;
    tabviewController =
        TabController(length: 2, vsync: this, initialIndex: argIndex);
    tabviewController.addListener(() {
      if (!tabviewController.indexIsChanging) {
        tabIndex.value = tabviewController.index;
      }
    });

    // 📊 記錄運動數據頁面瀏覽事件
    FirebaseAnalyticsService.instance.logViewWorkoutDataPage(
      workoutType: argIndex == 0 ? 'aerobic' : 'weight_training',
    );

    Future.delayed(Duration.zero, () => getRecords());
  }

  @override
  void onClose() {
    tabviewController.dispose();
    super.onClose();
  }

  /// UI 依據 tabIndex 取得對應的圖示
  String get sportIcon => tabIndex.value == 0
      ? ImageConstant.imgFrame86912
      : ImageConstant.imgFrame86911;

  /// 共用的 Group 資料 getter
  List<SportRecordGroup> get currentGroupedRecords =>
      tabIndex.value == 0 ? groupedAerobic : groupedWeightTraining;

  String getSportLabel(String type) {
    switch (type) {
      case 'aerobic':
        return 'lbl253'.tr;
      case 'weightTraining':
        return 'lbl255'.tr;
      default:
        return '';
    }
  }

  // void switchMode(int idx) {
  //   tabIndex.value = idx;
  //   _filterRecords();
  //   _updatePickDate();
  // }

  /// 讀取資料
  Future<void> getRecords() async {
    try {
      final records = await SportRecordListStorage.getRecords(gc.userId.value);

      final arecords = records.where((r) => r.sportType == "aerobic").toList();
      final wrecords =
          records.where((r) => r.sportType == "weightTraining").toList();

      aerobicRecords.assignAll(arecords);
      weightTrainingRecords.assignAll(wrecords);

      groupedAerobic.assignAll(_groupByDate(arecords));
      groupedWeightTraining.assignAll(_groupByDate(wrecords));

      hasLoaded.value = true;
    } catch (e) {
      print("❌ 讀取錯誤: $e");
    } finally {}
  }

  List<SportRecordGroup> _groupByDate(List<SportRecord> records) {
    final Map<String, List<SportRecord>> groupedMap = {};

    for (final record in records) {
      final key = record.time.format(pattern: 'M月d日');
      groupedMap.putIfAbsent(key, () => []);
      groupedMap[key]!.add(record);
    }

    return groupedMap.entries
        .map((entry) => SportRecordGroup(date: entry.key, records: entry.value))
        .toList();
  }

  /// ✅ 篩選月份
  void filterByDate(int year, int month) {
    selectedYear.value = year;
    selectedMonth.value = month;

    final isMatch = (DateTime t) => t.year == year && t.month == month;

    if (tabIndex.value == 0) {
      final filtered = aerobicRecords.where((r) => isMatch(r.time)).toList();
      groupedAerobic.assignAll(_groupByDate(filtered));
    } else {
      final filtered =
          weightTrainingRecords.where((r) => isMatch(r.time)).toList();
      groupedWeightTraining.assignAll(_groupByDate(filtered));
    }
  }

  /// ✅ 清除篩選
  void clearFilter() {
    selectedYear.value = DateTime.now().year;
    selectedMonth.value = DateTime.now().month;
    groupedAerobic.assignAll(_groupByDate(aerobicRecords));
    groupedWeightTraining.assignAll(_groupByDate(weightTrainingRecords));
  }

  void setSelectedDate(int year, int month) {
    selectedYear.value = year;
    selectedMonth.value = month;
    filterByDate(year, month);
    _updatePickDate();
  }

  void _updatePickDate() {
    pickDate.value = '${selectedYear.value} 年 ${selectedMonth.value} 月';
  }

  int convertToTotalSeconds({
    required int hours,
    required int minutes,
    required int seconds,
  }) {
    return hours * 3600 + minutes * 60 + seconds;
  }

  String getTimeUnitLabel(int totalSeconds) {
    return DateTimeUtils.formatDurationCN(totalSeconds);
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

  void go7Screen(SportRecord redord) {
    Get.toNamed(AppRoutes.k7Screen, arguments: redord);
  }
}

class SportRecordGroup {
  final String date;
  final List<SportRecord> records;

  SportRecordGroup({required this.date, required this.records});
}
