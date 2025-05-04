import 'dart:io';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pulsedevice/core/hiveDb/user_profile.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  /// ✅ 開啟相機（自動檢查權限）
  static Future<File?> pickFromCamera() async {
    final granted = await _checkCameraPermission();
    if (!granted) return null;

    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    return photo != null ? File(photo.path) : null;
  }

  /// ✅ 開啟相簿（自動檢查權限）
  static Future<File?> pickFromGallery() async {
    final granted = await _checkGalleryPermission();
    if (!granted) return null;

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image != null ? File(image.path) : null;
  }

  /// ✅ 開啟多張相簿圖片
  static Future<List<File>> pickMultipleFromGallery() async {
    final granted = await _checkGalleryPermission();
    if (!granted) return [];

    final List<XFile>? images = await _picker.pickMultiImage();
    return images?.map((xfile) => File(xfile.path)).toList() ?? [];
  }

  // ──────── 權限檢查區 ───────── //

  static Future<bool> _checkCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) return true;

    if (status.isPermanentlyDenied) _showPermissionDialog("相機");
    return false;
  }

  static Future<bool> _checkGalleryPermission() async {
    final status = await Permission.photos.request();
    if (status.isGranted) return true;

    if (status.isPermanentlyDenied) _showPermissionDialog("相簿");
    return false;
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

  /// 儲存圖片-以檔案
  Future<void> saveProfileImageFile(File imageFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final profileImagePath = '${appDir.path}/profile_avatar.jpg';

    final savedImage = await imageFile.copy(profileImagePath);

    final box = await Hive.openBox<UserProfile>('user_profile');
    final user = box.get('me') ?? UserProfile();
    user.avatar = savedImage.path;

    await box.put('me', user);
  }

  /// 儲存圖片-以路徑
  Future<void> saveProfileImagePath(String imagePath) async {
    final box = await Hive.openBox<UserProfile>('user_profile');
    final user = box.get('me') ?? UserProfile();
    user.avatar = imagePath;

    await box.put('me', user);
  }
}
