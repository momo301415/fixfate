import 'dart:convert';
import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart' as mobile_scanner;
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/service/firebase_analytics_service.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/config.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
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
  final mobile_scanner.MobileScannerController scannerController =
      mobile_scanner.MobileScannerController();
  ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();

    // 📊 記錄家人綁定頁面瀏覽事件
    FirebaseAnalyticsService.instance.logViewFamilyBindingPage();
  }

  void onDetect(mobile_scanner.BarcodeCapture capture) async {
    final barcode = capture.barcodes.first.rawValue;
    if (barcode != null && barcode.isNotEmpty) {
      // 📊 記錄掃描QR Code按鈕點擊事件
      FirebaseAnalyticsService.instance.logClickScanQrcode(
        qrType: 'family_binding',
      );

      final json = jsonDecode(barcode);
      scanResult.value = json["NotityToken"];
      scannerController.stop(); // 停止掃描
      final dialog = await DialogHelper.showFamilyNickNameDialog();
      if (dialog != null && dialog["confirm"] == true) {
        // 📊 記錄綁定家人按鈕點擊事件
        FirebaseAnalyticsService.instance.logClickBindFamily();
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
    print("sendFirebase gc.userId.value: ${gc.userId.value}");
    print("sendFirebase Config.userName: ${Config.userName}");
    var userName = "";
    if (Config.userName == "" ||
        Config.userName.isEmpty ||
        Config.userName == "null") {
      userName = gc.userId.value;
    } else {
      userName = Config.userName;
    }
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

    try {
      // 首先嘗試使用 Google ML Kit
      final inputImage = InputImage.fromFilePath(picked.path);
      final barcodeScanner = BarcodeScanner();

      final List<Barcode> barcodes =
          await barcodeScanner.processImage(inputImage);

      if (barcodes.isNotEmpty) {
        final barcode = barcodes.first;
        print("找到條碼，類型: ${barcode.type}, 原始值: ${barcode.rawValue}");

        if (barcode.rawValue != null && barcode.rawValue!.isNotEmpty) {
          try {
            print("嘗試解析JSON: ${barcode.rawValue}");
            final json = jsonDecode(barcode.rawValue!);
            print("JSON解析成功: $json");

            if (json.containsKey("NotityToken")) {
              scanResult.value = json["NotityToken"];
              print("設置scanResult: ${scanResult.value}");

              final dialog = await DialogHelper.showFamilyNickNameDialog();
              print("對話框結果: $dialog");

              if (dialog != null && dialog["confirm"] == true) {
                print("用戶確認，發送Firebase通知");
                sendFirebase(scanResult.value, dialog["nickname"] ?? "");
              }

              Get.snackbar('掃描成功 (ML Kit)', barcode.rawValue!);
              print("Google ML Kit 掃描成功: ${barcode.rawValue}");
              barcodeScanner.close();
              return;
            } else {
              print("JSON中沒有找到NotityToken字段");
              throw Exception("JSON格式不正確，缺少NotityToken字段");
            }
          } catch (jsonError) {
            print("JSON解析或處理錯誤: $jsonError");
            throw jsonError;
          }
        } else {
          print("條碼原始值為空");
        }
      }

      // 釋放 ML Kit 資源
      barcodeScanner.close();

      // 如果 Google ML Kit 失敗，顯示錯誤信息
      print("Google ML Kit 掃描失敗，沒有找到QR Code");
      Get.snackbar(
        '掃描失敗',
        'Google ML Kit 無法識別QR Code。\n請確保圖片清晰且包含有效的QR Code。',
        duration: Duration(seconds: 5),
      );

      // 暫時註解掉 zxing2 備用方案
      // print("Google ML Kit 掃描失敗，嘗試 zxing2...");
      // await _tryZxing2Scan(picked.path);
    } catch (e) {
      print("Google ML Kit 掃描錯誤: $e");
      print("錯誤堆疊: ${StackTrace.current}");

      // 暫時註解掉 zxing2 備用方案
      // await _tryZxing2Scan(picked.path);

      String errorMessage = 'Google ML Kit 處理圖片時發生錯誤';
      if (e.toString().contains('JSON')) {
        errorMessage = 'QR Code 內容格式不正確，請檢查是否為有效的JSON格式';
      } else if (e.toString().contains('NotityToken')) {
        errorMessage = 'QR Code 缺少必要的 NotityToken 字段';
      }

      Get.snackbar(
        '掃描錯誤',
        errorMessage,
        duration: Duration(seconds: 5),
      );
    }
  }
}
