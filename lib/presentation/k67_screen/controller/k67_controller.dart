import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k67_model.dart';

/// A controller class for the K67Screen.
///
/// This class manages the state of the K67Screen, including the
/// current k67ModelObj
class K67Controller extends GetxController {
  Rx<K67Model> k67ModelObj = K67Model().obs;

  /// 路由到分享健康數據頁面
  void gok71Screen() {
    Get.toNamed(AppRoutes.k71Screen);
  }

  /// 路由到掃描qr code
  void go72Screen() {
    Get.toNamed(AppRoutes.k72Screen);
  }
}
