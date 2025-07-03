import 'package:get/get.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/alert_record.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/presentation/k52_page/models/list_item_model.dart';
import 'package:pulsedevice/presentation/k53_screen/controller/k53_controller.dart';
import '../models/k52_model.dart';

class K52Controller extends GetxController {
  Rx<K52Model> k52ModelObj = K52Model().obs;
  final k53c = Get.find<K53Controller>();
  final gc = Get.find<GlobalController>();
  ApiService apiService = ApiService();
  String get formattedPickDate =>
      '${k53c.selectedYear.value} 年 ${k53c.selectedMonth.value} 月';
  @override
  void onInit() {
    super.onInit();

    // 初始化時載入目前年月
    ever(k53c.hasLoaded, (loaded) {
      if (loaded == true) {
        updateListFromRecords(k53c.filteredRecords);
        getNotifyList(k53c.notifyDataList);
      }
    });

    ever(k53c.filteredRecords, (_) {
      updateListFromRecords(k53c.filteredRecords);
      getNotifyList(k53c.notifyDataList);
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

    // k52ModelObj.value.listItemList.value = list;
  }

  Future<void> getNotifyList(List<Map<String, dynamic>> datas) async {
    if (datas.length > 0) {
      final list = datas.map((record) {
        DateTime date = DateTime.parse(record["createdAt"]);
        return ListItemModel(
          tf: Rx(record["title"]),
          tf1: Rx(date.format(pattern: 'yyyy/MM/dd\nHH:mm')),
          id: Rx(''),
        );
      }).toList();

      k52ModelObj.value.listItemList.value = list;
    } else {
      k52ModelObj.value.listItemList.value = [];
    }
  }
}
