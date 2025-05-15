import 'package:get/get.dart';
import 'package:pulsedevice/core/hiveDb/alert_record.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/presentation/k52_page/models/list_item_model.dart';
import 'package:pulsedevice/presentation/k53_screen/controller/k53_controller.dart';
import '../models/k52_model.dart';

class K52Controller extends GetxController {
  Rx<K52Model> k52ModelObj = K52Model().obs;
  final k53c = Get.find<K53Controller>();
  String get formattedPickDate =>
      '${k53c.selectedYear.value} 年 ${k53c.selectedMonth.value} 月';
  @override
  void onInit() {
    super.onInit();

    // 初始化時載入目前年月
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
    final list = records.map((record) {
      final formatted = record.time.format(pattern: 'yyyy/MM/dd HH:mm');
      return ListItemModel(
        tf: Rx(record.label),
        tf1: Rx(formatted),
        id: Rx(''),
      );
    }).toList();

    k52ModelObj.value.listItemList.value = list;
  }
}
