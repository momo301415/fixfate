import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../../../core/app_export.dart';
import '../models/initial_tab3_model.dart';
import '../models/k82_model.dart';

/// A controller class for the K82Screen.
///
/// This class manages the state of the K82Screen, including the
/// current k82ModelObj
class K82Controller extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController oneController = TextEditingController();

  Rx<K82Model> k82ModelObj = K82Model().obs;

  late TabController tabviewController =
      Get.put(TabController(vsync: this, length: 3));

  Rx<List<DateTime?>> selectedDatesFromCalendar = Rx([]);

  Rx<InitialTab3Model> initialTab3ModelObj = InitialTab3Model().obs;

  @override
  void onClose() {
    super.onClose();
    oneController.dispose();
  }
}
