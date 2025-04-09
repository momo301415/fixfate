import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../../../core/app_export.dart';
import '../models/k88_model.dart';

/// A controller class for the K88Bottomsheet.
///
/// This class manages the state of the K88Bottomsheet, including the
/// current k88ModelObj
class K88Controller extends GetxController {
  Rx<K88Model> k88ModelObj = K88Model().obs;

  Rx<List<DateTime?>> selectedDatesFromCalendar = Rx([]);
}
