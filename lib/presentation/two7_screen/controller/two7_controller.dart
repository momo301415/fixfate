import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/two7_model.dart';

/// A controller class for the Two7Screen.
///
/// This class manages the state of the Two7Screen, including the
/// current two7ModelObj
class Two7Controller extends GetxController {
  Rx<Two7Model> two7ModelObj = Two7Model().obs;

  Rx<bool> isSelectedSwitch = false.obs;
}
