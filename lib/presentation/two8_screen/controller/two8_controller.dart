import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/two8_model.dart';

/// A controller class for the Two8Screen.
///
/// This class manages the state of the Two8Screen, including the
/// current two8ModelObj
class Two8Controller extends GetxController {
  TextEditingController searchController = TextEditingController();

  Rx<Two8Model> two8ModelObj = Two8Model().obs;

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }
}
