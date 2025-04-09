import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../../../core/app_export.dart';
import '../models/k87_model.dart';

/// A controller class for the K87Bottomsheet.
///
/// This class manages the state of the K87Bottomsheet, including the
/// current k87ModelObj
class K87Controller extends GetxController {
  Rx<K87Model> k87ModelObj = K87Model().obs;

  Rx<List<DateTime?>> selectedDatesFromCalendar = Rx([]);
}
