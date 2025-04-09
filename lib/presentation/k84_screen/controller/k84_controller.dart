import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../../../core/app_export.dart';
import '../models/initial_tab5_model.dart';
import '../models/k84_model.dart';

/// A controller class for the K84Screen.
///
/// This class manages the state of the K84Screen, including the
/// current k84ModelObj
class K84Controller extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController oneController = TextEditingController();

  Rx<K84Model> k84ModelObj = K84Model().obs;

  late TabController tabviewController =
      Get.put(TabController(vsync: this, length: 3));

  Rx<List<DateTime?>> selectedDatesFromCalendar = Rx([]);

  Rx<InitialTab5Model> initialTab5ModelObj = InitialTab5Model().obs;

  @override
  void onClose() {
    super.onClose();
    oneController.dispose();
  }
}
