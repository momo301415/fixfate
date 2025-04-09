import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k73_model.dart';

/// A controller class for the K73Screen.
///
/// This class manages the state of the K73Screen, including the
/// current k73ModelObj
class K73Controller extends GetxController {
  TextEditingController searchController = TextEditingController();

  Rx<K73Model> k73ModelObj = K73Model().obs;

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }
}
