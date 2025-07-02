import 'package:get/get.dart';
import 'package:pulsedevice/core/hiveDb/alert_record.dart';
import 'package:pulsedevice/presentation/k52_page2/models/list_item_model2.dart';
import 'package:pulsedevice/presentation/k53_screen/controller/k53_controller.dart';
import 'package:collection/collection.dart';
import '../models/k52_model2.dart';

class K52Controller2 extends GetxController {
  final k53c = Get.find<K53Controller>();
  Rx<K52Model2> k52ModelObj = K52Model2().obs;
  String get formattedPickDate =>
      '${k53c.selectedYear.value} 年 ${k53c.selectedMonth.value} 月';
  @override
  void onInit() {
    super.onInit();

    ever(k53c.hasLoaded, (loaded) {
      if (loaded == true) {
        updateListFromRecords(k53c.filteredRecords);
        getNotifySum(k53c.nofiyDataSum);
      }
    });

    ever(k53c.filteredRecords, (_) {
      updateListFromRecords(k53c.filteredRecords);
      getNotifySum(k53c.nofiyDataSum);
    });
  }

  void updateListFromRecords(List<AlertRecord> records) {
    final statList = generateAlertStats(records);
    final list = statList.map((stat) {
      return ListItemModel2(
        tf: Rx(stat.label),
        tf1: Rx(stat.count),
        tf2: Rx(stat.percent),
      );
    }).toList();

    // k52ModelObj.value.listItemList.value = list;
  }

  List<AlertStat> generateAlertStats(List<AlertRecord> records) {
    final total = records.length;
    if (total == 0) return [];

    final grouped = groupBy(records, (r) => typeMapping[r.type] ?? '未知');

    return grouped.entries.map((entry) {
      final label = entry.key;
      final count = entry.value.length;
      final percent = count / total;
      return AlertStat(label: label, count: count, percent: percent);
    }).toList();
  }

  final Map<String, String> typeMapping = {
    "heart_rate_high": "lbl160".tr,
    "heart_rate_low": "lbl160".tr,
    "blood_oxygen_low": "lbl163".tr,
    "temperature_high": "lbl164".tr,
    "temperature_low": "lbl164".tr,
  };

  Future<void> getNotifySum(Map<String, num> datas) async {
    // 1. 若 Map 為空 → 清空列表
    if (datas.isEmpty) {
      k52ModelObj.value.listItemList.value = [];
      return;
    }

    // 2. 計算總和，用來算百分比
    final total = datas.values.fold<num>(0, (sum, v) => sum + v);

    // 3. 轉成 List<ListItemModel2>
    final list = datas.entries.map((e) {
      final label = e.key; // 例如 "體溫"
      final count = e.value; // 例如 36
      final percent = (count / total * 100); // 1 位小數
      var labelName = "";
      if (label.contains("體溫")) {
        labelName = "體表溫度警報";
      } else {
        labelName = label + "警報";
      }
      return ListItemModel2(
        tf: Rx("$labelName"), // 名稱
        tf1: Rx(count.toInt()), // 數值
        tf2: Rx(percent), // 百分比
      );
    }).toList();

    // 4. 指回到 GetX Observable 列表
    k52ModelObj.value.listItemList.value = list;
  }
}

class AlertStat {
  final String label;
  final int count;
  final double percent;

  AlertStat({
    required this.label,
    required this.count,
    required this.percent,
  });
}
