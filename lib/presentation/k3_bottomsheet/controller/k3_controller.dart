import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k3_model.dart';

/// A controller class for the K3Bottomsheet.
///
/// This class manages the state of the K3Bottomsheet, including the
/// current k3ModelObj
class K3Controller extends GetxController {
  Rx<K3Model> k3ModelObj = K3Model().obs;
  RxInt selectedItemId = RxInt(-1);

  void selectItem(int id) {
    selectedItemId.value = id;
  }
}
