import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../models/k71_model.dart';

/// A controller class for the K71Screen.
///
/// This class manages the state of the K71Screen, including the
/// current k71ModelObj
class K71Controller extends GetxController {
  Rx<K71Model> k71ModelObj = K71Model().obs;

  /// 路由到掃描qr code
  void go72Screen() {
    Get.offNamedUntil(
        AppRoutes.k72Screen, ModalRoute.withName(AppRoutes.k67Screen));
  }
}
