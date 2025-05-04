import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

class PermissionHelper {
  ///  相簿權限（iOS photos / Android photos or storage）
  static Future<bool> checkGalleryPermission() async {
    final status = await Permission.photos.request();
    return status.isGranted;
  }

  ///  相機權限
  static Future<bool> checkCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  ///  通知權限（Android 13+ / iOS）
  static Future<bool> checkNotificationPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  ///  聯絡人權限
  static Future<bool> checkContactsPermission() async {
    final status = await Permission.contacts.request();
    return status.isGranted;
  }

  ///  藍牙權限（Android 12+）
  static Future<bool> checkBluetoothPermission() async {
    final results = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse, // 某些藍牙功能仍需位置
    ].request();

    return results.values.every((status) => status.isGranted);
  }

  ///  檔案讀寫權限（Android 13 以下）
  static Future<bool> checkStoragePermission() async {
    final results = await [
      Permission.storage,
    ].request();
    return results.values.every((status) => status.isGranted);
  }

  ///  Android 13+ 媒體圖片權限
  static Future<bool> checkReadMediaImagesPermission() async {
    final status = await Permission.photos.request();
    return status.isGranted;
  }

  ///  一次請求所有相關權限（常用）
  static Future<bool> requestAllPermissions() async {
    final results = await [
      Permission.camera,
      Permission.photos,
      Permission.storage,
      Permission.notification,
      Permission.contacts,
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();

    return results.values.every((status) => status.isGranted);
  }

  ///  如果拒絕權限，跳轉至設定頁面
  static Future<void> openSettingsIfPermanentlyDenied(
      Permission permission) async {
    final status = await permission.status;
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  static void _showPermissionDialog(String type) {
    Get.defaultDialog(
      title: "$type權限已關閉",
      middleText: "請前往系統設定開啟 $type 權限，以使用此功能。",
      textConfirm: "前往設定",
      textCancel: "取消",
      onConfirm: () {
        openAppSettings();
        Get.back();
      },
    );
  }

  static Future<void> requestExactAlarmPermission() async {
    if (Platform.isAndroid) {
      final intent = AndroidIntent(
        action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
      );
      try {
        await intent.launch();
      } catch (e) {
        print("Failed to launch settings for exact alarm: $e");
      }
    }
  }
}
