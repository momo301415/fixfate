import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/app_export.dart';
import '../models/k72_model.dart';

/// A controller class for the K72Screen.
///
/// This class manages the state of the K72Screen, including the
/// current k72ModelObj
class K72Controller extends GetxController {
  Rx<K72Model> k72ModelObj = K72Model().obs;

  final RxString scanResult = ''.obs;
  final MobileScannerController scannerController = MobileScannerController();

  void onDetect(BarcodeCapture capture) {
    final barcode = capture.barcodes.first.rawValue;
    if (barcode != null && barcode.isNotEmpty) {
      scanResult.value = barcode;
      scannerController.stop(); // 停止掃描
      Get.snackbar('成功', '掃描內容：$barcode');
    }
  }

  /// 路由到分享健康數據頁面
  void gok71Screen() {
    Get.offNamedUntil(
        AppRoutes.k71Screen, ModalRoute.withName(AppRoutes.k67Screen));
  }

  // Future<void> pickImageAndScan() async {
  //   final picker = ImagePicker();
  //   final picked = await picker.pickImage(source: ImageSource.gallery);
  //   if (picked != null && picked.path.isNotEmpty) {
  //     final result = await scannerController.analyzeImage(File(picked.path));
  //     if (result.rawValue != null) {
  //       scanResult.value = result.rawValue!;
  //       Get.snackbar('圖片掃描成功', result.rawValue!);
  //     } else {
  //       Get.snackbar('失敗', '未偵測到 QR Code');
  //     }
  //   }
  // }
}
