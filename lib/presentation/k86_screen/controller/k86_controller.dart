import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../../../core/app_export.dart';
import '../models/initia_tab_model.dart';
import '../models/k86_model.dart';

/// A controller class for the K86Screen.
///
/// This class manages the state of the K86Screen, including the
/// current k86ModelObj
class K86Controller extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController oneController = TextEditingController();

  Rx<K86Model> k86ModelObj = K86Model().obs;

  late TabController tabviewController =
      Get.put(TabController(vsync: this, length: 3));

  Rx<List<DateTime?>> selectedDatesFromCalendar = Rx([]);

  Rx<InitiaTabModel> initiaTabModelObj = InitiaTabModel().obs;

  @override
  void onClose() {
    super.onClose();
    oneController.dispose();
  }
}
