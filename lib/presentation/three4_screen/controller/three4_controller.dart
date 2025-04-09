import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/three4_model.dart';
import '../models/three_initial_model.dart';

/// A controller class for the Three4Screen.
///
/// This class manages the state of the Three4Screen, including the
/// current three4ModelObj
class Three4Controller extends GetxController {
  TextEditingController searchController = TextEditingController();

  Rx<Three4Model> three4ModelObj = Three4Model().obs;

  Rx<ThreeInitialModel> threeInitialModelObj = ThreeInitialModel().obs;

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }
}
