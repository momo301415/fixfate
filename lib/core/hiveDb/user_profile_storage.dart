import 'package:hive/hive.dart';
import 'package:pulsedevice/core/hiveDb/device_profile.dart';
import 'package:pulsedevice/core/hiveDb/user_profile.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:yc_product_plugin/yc_product_plugin_data_type.dart';

class UserProfileStorage {
  static final _box = Hive.box<UserProfile>('user_profile');

  static Future<void> saveUserProfile(
      String userId, UserProfile profile) async {
    await _box.put(userId, profile);
  }

  static UserProfile? getUserProfile(String userId) {
    return _box.get(userId);
  }

  static Future<void> deleteUserProfile(String userId) async {
    await _box.delete(userId);
  }

  static List<UserProfile> getAllProfiles() {
    return _box.values.toList();
  }

  static bool exists(String userId) {
    return _box.containsKey(userId);
  }

  static Future<void> saveDeviceForCurrentUser(
      String userId, BluetoothDevice device) async {
    UserProfile? user = _box.get(userId);

    final newDevice = DeviceProfile(
      macAddress: device.macAddress,
      deviceIdentifier: device.deviceIdentifier,
      name: device.name,
      rssiValue: device.rssiValue,
      firmwareVersion: device.firmwareVersion,
      deviceSize: device.deviceSize,
      deviceColor: device.deviceColor,
      imageIndex: device.imageIndex,
      deviceModel: device.deviceModel ?? "",
      createdAt: DateTime.now().format(pattern: 'yyyy/MM/dd HH:mm'),
      ownerUserId: userId,
    );

    if (user == null) {
      // 使用者不存在，建立新帳號並儲存裝置
      user = UserProfile(devices: [newDevice]);
    } else {
      // 檢查是否已存在相同裝置（用 macAddress）
      final index =
          user.devices?.indexWhere((d) => d.macAddress == device.macAddress);
      if (index != -1) {
        user.devices?[index!] = newDevice;
      } else {
        user.devices?.add(newDevice);
      }
    }

    /// 更新使用者資料
    await _box.put(userId, user);
  }

  /// 取得某位使用者所有儲存的設備清單
  static Future<List<DeviceProfile>> getDevicesForUser(String userId) async {
    final user = _box.get(userId);
    return (user?.devices ?? []).cast<DeviceProfile>();
  }

  static Future<void> removeDevice({
    required String userId,
    required String macAddress,
  }) async {
    final user = _box.get(userId);
    if (user == null) return;

    user.devices?.removeWhere((d) => d.macAddress == macAddress);
    await _box.put(userId, user); // 更新 user 的設備清單
  }
}
