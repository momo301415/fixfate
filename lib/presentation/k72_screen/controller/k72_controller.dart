import 'dart:convert';
import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/config.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:zxing2/qrcode.dart';
import '../../../core/app_export.dart';
import '../models/k72_model.dart';
import 'package:image/image.dart' as img;

/// A controller class for the K72Screen.
///
/// This class manages the state of the K72Screen, including the
/// current k72ModelObj
class K72Controller extends GetxController {
  Rx<K72Model> k72ModelObj = K72Model().obs;
  final gc = Get.find<GlobalController>();
  final RxString scanResult = ''.obs;
  final MobileScannerController scannerController = MobileScannerController();
  ApiService apiService = ApiService();

  void onDetect(BarcodeCapture capture) async {
    final barcode = capture.barcodes.first.rawValue;
    if (barcode != null && barcode.isNotEmpty) {
      final json = jsonDecode(barcode);
      scanResult.value = json["NotityToken"];
      scannerController.stop(); // 停止掃描
      final dialog = await DialogHelper.showFamilyNickNameDialog();
      if (dialog!["confirm"] == true) {
        sendFirebase(scanResult.value, dialog["nickname"] ?? "");
      }
      // 延遲顯示 snackbar，等 Dialog 關閉完整
      Future.delayed(const Duration(milliseconds: 200), () {
        Get.snackbar('成功', '掃描內容：$barcode');
      });
    }
  }

  /// 路由到分享健康數據頁面
  void gok71Screen() {
    Get.offNamedUntil(
        AppRoutes.k71Screen, ModalRoute.withName(AppRoutes.k67Screen));
  }

  Future<void> sendFirebase(token, String nickName) async {
    var userName = Config.userName.isEmpty ? gc.userId.value : Config.userName;
    try {
      final payload = {
        "token": token,
        "title": '分享數據',
        "content": '分享數據內容',
        "dataKey": "alertDialog",
        "dataVal":
            "${gc.apiId.value};${userName};${nickName};${gc.firebaseToken.value}",
      };
      var res = await apiService.postJson(
        Api.sendFirebase,
        payload,
      );

      if (res.isNotEmpty) {}
    } catch (e) {
      print("Notify API Error: $e");
    }
  }

  Future<void> pickImageAndScan() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final bmp = img.decodeImage(await File(picked.path).readAsBytes());
    if (bmp == null) {
      Get.snackbar('錯誤', '無法解讀圖片');
      return;
    }

    // 將圖片轉成 RGBA 的 Int32List
    final rgbaBytes =
        bmp.convert(numChannels: 4).getBytes(order: img.ChannelOrder.rgba);
    final pixels = rgbaBytes.buffer.asInt32List();

    // 建立 LuminanceSource
    final source = RGBLuminanceSource(bmp.width, bmp.height, pixels);
    final bitmap = BinaryBitmap(HybridBinarizer(source));

    try {
      final reader = QRCodeReader();
      final result = reader.decode(bitmap);
      final json = jsonDecode(result.text);
      scanResult.value = json["NotityToken"];
      final dialog = await DialogHelper.showFamilyNickNameDialog();
      if (dialog!["confirm"] == true) {
        sendFirebase(scanResult.value, dialog["nickname"] ?? "");
      }

      Get.snackbar('掃描成功', result.text);
    } catch (e) {
      print(e);
      Get.snackbar('錯誤', 'QR Code 未辨識成功');
    }
  }
}
