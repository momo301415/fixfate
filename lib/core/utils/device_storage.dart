import 'package:hive/hive.dart';
import 'package:pulsedevice/core/hiveDb/device_profile.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:yc_product_plugin/yc_product_plugin_data_type.dart';

class DeviceStorage {
  static const _deviceBoxName = 'device_box';
  static final _box = Hive.box<DeviceProfile>(_deviceBoxName);

  /// 儲存設備到 Hive
  static Future<void> saveDevice(String userId, BluetoothDevice device) async {
    final profile = DeviceProfile(
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

    await _box.put(device.macAddress, profile);
  }

  /// 讀取設備資料
  static Future<DeviceProfile?> loadDevice(String macAddress) async {
    return _box.get(macAddress);
  }

  /// 取得所有已儲存的設備
  static Future<List<DeviceProfile>> loadAllDevices() async {
    return _box.values.toList();
  }

  /// 刪除單一設備
  static Future<void> deleteDevice(String macAddress) async {
    await _box.delete(macAddress);
  }

  /// 清除所有設備資料
  static Future<void> clearAllDevices() async {
    await _box.clear();
  }
}
