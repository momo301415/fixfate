import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../../../core/app_export.dart';
import '../models/initial_tab4_model.dart';
import '../models/k83_model.dart';

/// A controller class for the K83Screen.
///
/// This class manages the state of the K83Screen, including the
/// current k83ModelObj
class K83Controller extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<K83Model> k83ModelObj = K83Model().obs;

  late TabController tabviewController =
      Get.put(TabController(vsync: this, length: 3));

  Rx<List<DateTime?>> selectedDatesFromCalendar = Rx([]);

  Rx<InitialTab4Model> initialTab4ModelObj = InitialTab4Model().obs;
}
