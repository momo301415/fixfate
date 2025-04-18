import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  /// ✅ 檢查相簿權限（Android = photos / storage, iOS = photos）
  static Future<bool> checkGalleryPermission() async {
    final status = await Permission.photos.request();
    return status.isGranted;
  }

  /// ✅ 檢查相機權限
  static Future<bool> checkCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  /// ✅ 同時檢查相機 & 相簿
  static Future<bool> checkAllImagePermissions() async {
    final results = await [
      Permission.camera,
      Permission.photos, // iOS 會自動轉為 photoLibrary
    ].request();

    return results.values.every((status) => status.isGranted);
  }

  /// ✅ 如果拒絕，跳設定頁面
  static Future<void> openSettingsIfDenied() async {
    final denied = await Permission.photos.status;
    if (denied.isPermanentlyDenied) {
      await openAppSettings();
    }
  }
}
