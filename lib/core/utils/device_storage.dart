import 'dart:convert';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yc_product_plugin/yc_product_plugin_data_type.dart';

class DeviceStorage {
  static const _deviceKey = 'saved_bluetooth_device';

  /// 儲存設備到 SharedPreferences
  static Future<void> saveDevice(BluetoothDevice device) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> deviceMap = {
      "macAddress": device.macAddress,
      "deviceIdentifier": device.deviceIdentifier,
      "name": device.name,
      "rssiValue": device.rssiValue,
      "firmwareVersion": device.firmwareVersion,
      "deviceSize": device.deviceSize,
      "deviceColor": device.deviceColor,
      "imageIndex": device.imageIndex,
      "deviceModel": device.deviceModel ?? "",
      "createdAt": DateTime.now().format(pattern: 'yyyy/mm/dd HH:mm')
      // 注意：deviceFeature 和 mcuPlatform 如果有需要可以額外補充
    };
    String jsonString = jsonEncode(deviceMap);
    await prefs.setString(_deviceKey, jsonString);
  }

  /// 讀取設備資料
  static Future<BluetoothDevice?> loadDevice() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_deviceKey);
    if (jsonString == null) {
      return null;
    }
    final Map<String, dynamic> deviceMap = jsonDecode(jsonString);
    return BluetoothDevice.formJson(deviceMap);
  }

  /// 讀取設備資料
  static Future<Map<String, dynamic>> loadDeviceData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_deviceKey);
    if (jsonString == null) {
      return {};
    }
    final Map<String, dynamic> deviceMap = jsonDecode(jsonString);
    return deviceMap;
  }

  /// 清除儲存的設備
  static Future<void> clearDevice() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_deviceKey);
  }
}
