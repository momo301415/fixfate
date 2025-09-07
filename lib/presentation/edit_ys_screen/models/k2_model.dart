import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

/// This class defines the variables used in the [k2_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class K2Model {
  Rx<DateTime>? selectedMealDateInput = Rx(DateTime.now());

  Rx<TimeOfDay>? selectedTimeInput = Rx(TimeOfDay.now());
}
