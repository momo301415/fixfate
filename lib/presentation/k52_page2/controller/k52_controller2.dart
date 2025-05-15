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
      }
    });

    ever(k53c.filteredRecords, (_) {
      updateListFromRecords(k53c.filteredRecords);
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

    k52ModelObj.value.listItemList.value = list;
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
