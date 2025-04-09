import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/one7_model.dart';

/// A controller class for the One7Bottomsheet.
///
/// This class manages the state of the One7Bottomsheet, including the
/// current one7ModelObj
class One7Controller extends GetxController {
  Rx<One7Model> one7ModelObj = One7Model().obs;
}
