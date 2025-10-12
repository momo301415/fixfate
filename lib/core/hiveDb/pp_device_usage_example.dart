import 'package:pp_bluetooth_kit_flutter/model/pp_device_model.dart';
import 'package:pulsedevice/core/hiveDb/pp_device_storage.dart';

/// 磅秤設備 Hive 儲存使用範例
class PPDeviceUsageExample {
  /// 範例：儲存掃描到的磅秤設備
  static Future<void> saveScannedDevice(
      String userId, PPDeviceModel device) async {
    try {
      await PPDeviceStorage.savePPDevice(userId, device);
      print('✅ 磅秤設備已儲存: ${device.deviceName} (${device.deviceMac})');
    } catch (e) {
      print('❌ 儲存磅秤設備失敗: $e');
    }
  }

  /// 範例：取得用戶所有磅秤設備
  static List<PPDeviceModel> getUserDevices(String userId) {
    try {
      final devices = PPDeviceStorage.getUserPPDeviceModels(userId);
      print('📱 用戶 $userId 共有 ${devices.length} 個磅秤設備');
      return devices;
    } catch (e) {
      print('❌ 取得用戶設備失敗: $e');
      return [];
    }
  }

  /// 範例：連線磅秤設備
  static Future<void> connectToDevice(String macAddress) async {
    try {
      // 從 Hive 讀取設備資料並轉換為 PPDeviceModel
      final device = PPDeviceStorage.convertToPPDeviceModel(macAddress);

      if (device != null) {
        print('🔗 開始連線設備: ${device.deviceName}');

        // 更新連線狀態
        await PPDeviceStorage.updateConnectionStatus(macAddress, true);

        // 這裡可以加入實際的藍牙連線邏輯
        // await PPBluetoothKitManager.connect(device);

        print('✅ 設備連線成功');
      } else {
        print('❌ 找不到設備: $macAddress');
      }
    } catch (e) {
      print('❌ 連線設備失敗: $e');
    }
  }

  /// 範例：更新設備狀態
  static Future<void> updateDeviceStatus(
      String macAddress, int power, int rssi) async {
    try {
      await PPDeviceStorage.updateDevicePower(macAddress, power);
      await PPDeviceStorage.updateRSSI(macAddress, rssi);
      print('📊 設備狀態已更新: 電量=$power%, 信號=$rssi dBm');
    } catch (e) {
      print('❌ 更新設備狀態失敗: $e');
    }
  }

  /// 範例：檢查設備是否存在
  static bool checkDeviceExists(String macAddress) {
    final exists = PPDeviceStorage.exists(macAddress);
    print('🔍 設備 $macAddress 存在: $exists');
    return exists;
  }

  /// 範例：刪除設備
  static Future<void> removeDevice(String macAddress) async {
    try {
      await PPDeviceStorage.deletePPDevice(macAddress);
      print('🗑️ 設備已刪除: $macAddress');
    } catch (e) {
      print('❌ 刪除設備失敗: $e');
    }
  }

  /// 範例：斷線設備
  static Future<void> disconnectDevice(String macAddress) async {
    try {
      await PPDeviceStorage.updateConnectionStatus(macAddress, false);
      print('🔌 設備已斷線: $macAddress');
    } catch (e) {
      print('❌ 斷線設備失敗: $e');
    }
  }
}

