import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../../../core/app_export.dart';
import '../models/initial_tab_model.dart';
import '../models/k77_model.dart';

/// A controller class for the K77Screen.
///
/// This class manages the state of the K77Screen, including the
/// current k77ModelObj
class K77Controller extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<K77Model> k77ModelObj = K77Model().obs;

  late TabController tabviewController =
      Get.put(TabController(vsync: this, length: 3));

  Rx<List<DateTime?>> selectedDatesFromCalendar = Rx([]);

  Rx<InitialTabModel> initialTabModelObj = InitialTabModel().obs;
}
