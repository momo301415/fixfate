import 'package:flutter/material.dart';
import 'package:pulsedevice/core/service/firebase_analytics_service.dart';
import '../../../core/app_export.dart';
import '../models/k0_model.dart';

/// A controller class for the K0Screen.
///
/// This class manages the state of the K0Screen, including the
/// current k0ModelObj
class K0Controller extends GetxController {
  Rx<K0Model> k0ModelObj = K0Model().obs;

  final scrollController = ScrollController();
  var isBottomReached = false.obs;
  @override
  void onInit() {
    super.onInit();

    // 📊 記錄使用者條款頁面瀏覽事件
    FirebaseAnalyticsService.instance.logViewAcceptTermsPage();

    scrollController.addListener(() {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        isBottomReached.value = true;
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
