import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../../../core/app_export.dart';
import '../models/initial_tab1_model.dart';
import '../models/k80_model.dart';

/// A controller class for the K80Screen.
///
/// This class manages the state of the K80Screen, including the
/// current k80ModelObj
class K80Controller extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<K80Model> k80ModelObj = K80Model().obs;

  late TabController tabviewController =
      Get.put(TabController(vsync: this, length: 3));

  Rx<List<DateTime?>> selectedDatesFromCalendar = Rx([]);

  Rx<InitialTab1Model> initialTab1ModelObj = InitialTab1Model().obs;
}
