import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/app_export.dart';
import '../models/k10_model.dart';

class ScanFoodController extends GetxController {
  Rx<K10Model> k10ModelObj = K10Model().obs;
  MobileScannerController? controller;
  Rx<PermissionStatus> cameraStatus = PermissionStatus.denied.obs;
  Rx<String?> scannedValue = Rx<String?>(null);
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await requestCameraPermission();
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }

  Future<void> requestCameraPermission() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // 请求相机权限
      final status = await Permission.camera.request();
      update();
      cameraStatus.value = status;

      if (status.isGranted) {
        await _initializeScanner();
      } else if (status.isPermanentlyDenied) {
        errorMessage.value = 'Camera permission permanently denied. Please enable it in app settings.';
      } else {
        errorMessage.value = 'Camera permission denied.';
      }
    } catch (e) {
      errorMessage.value = 'Failed to request camera permission: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _initializeScanner() async {
    try {
      controller = MobileScannerController(
        detectionSpeed: DetectionSpeed.normal,
        facing: CameraFacing.back,
        torchEnabled: false,
      );

      // 等待扫描器初始化完成
      await Future.delayed(Duration(milliseconds: 300));
    } catch (e) {
      errorMessage.value = 'Failed to initialize scanner: $e';
      controller?.dispose();
      controller = null;
    }
  }

  void onCodeDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String? value = barcodes.first.rawValue;
      if (value != null) {
        scannedValue.value = value;
        _handleScannedValue(value);
      }
    }
  }

  void _handleScannedValue(String value) {
    // 处理扫描到的二维码值
    Get.snackbar(
      'Scanned',
      'Value: $value',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  Future<void> openAppSettings() async {
    await openAppSettings();
  }

  // 检查是否有相机权限
  bool get hasCameraPermission => cameraStatus.value.isGranted;

  // 检查扫描器是否就绪
  bool get isScannerReady => hasCameraPermission && controller != null;
}