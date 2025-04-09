import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../../../core/app_export.dart';
import '../models/initial_tab2_model.dart';
import '../models/k81_model.dart';

/// A controller class for the K81Screen.
///
/// This class manages the state of the K81Screen, including the
/// current k81ModelObj
class K81Controller extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<K81Model> k81ModelObj = K81Model().obs;

  late TabController tabviewController =
      Get.put(TabController(vsync: this, length: 3));

  Rx<List<DateTime?>> selectedDatesFromCalendar = Rx([]);

  Rx<InitialTab2Model> initialTab2ModelObj = InitialTab2Model().obs;
}
