import 'package:hive/hive.dart';
import 'package:pp_bluetooth_kit_flutter/enums/pp_scale_enums.dart';
import 'package:pp_bluetooth_kit_flutter/model/pp_device_model.dart';
import 'package:pulsedevice/core/hiveDb/pp_device_profile.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';

class PPDeviceStorage {
  static final _box = Hive.box<PPDeviceProfile>('pp_device_profile');

  /// 儲存磅秤設備到 Hive
  static Future<void> savePPDevice(String userId, PPDeviceModel device) async {
    final profile = _convertToProfile(userId, device);
    await _box.put(device.deviceMac, profile);
  }

  /// 讀取磅秤設備資料
  static PPDeviceProfile? getPPDevice(String macAddress) {
    return _box.get(macAddress);
  }

  /// 轉換為 PPDeviceModel（用於藍牙連線）
  static PPDeviceModel? convertToPPDeviceModel(String macAddress) {
    final profile = getPPDevice(macAddress);
    return profile != null ? _convertToModel(profile) : null;
  }

  /// 取得用戶所有磅秤設備
  static List<PPDeviceProfile> getUserPPDevices(String userId) {
    return _box.values.where((device) => device.ownerUserId == userId).toList();
  }

  /// 取得用戶所有磅秤設備並轉換為 PPDeviceModel
  static List<PPDeviceModel> getUserPPDeviceModels(String userId) {
    return getUserPPDevices(userId)
        .map((profile) => _convertToModel(profile))
        .toList();
  }

  /// 刪除磅秤設備
  static Future<void> deletePPDevice(String macAddress) async {
    await _box.delete(macAddress);
  }

  /// 清除所有磅秤設備資料
  static Future<void> clearAllPPDevices() async {
    await _box.clear();
  }

  /// 檢查設備是否存在
  static bool exists(String macAddress) {
    return _box.containsKey(macAddress);
  }

  /// 更新設備連線狀態
  static Future<void> updateConnectionStatus(
      String macAddress, bool isConnected) async {
    final profile = _box.get(macAddress);
    if (profile != null) {
      profile.isConnected = isConnected;
      profile.lastConnectedAt =
          DateTime.now().format(pattern: 'yyyy/MM/dd HH:mm');
      await profile.save();
    }
  }

  /// 更新設備電量
  static Future<void> updateDevicePower(String macAddress, int power) async {
    final profile = _box.get(macAddress);
    if (profile != null) {
      profile.devicePower = power;
      await profile.save();
    }
  }

  /// 更新設備信號強度
  static Future<void> updateRSSI(String macAddress, int rssi) async {
    final profile = _box.get(macAddress);
    if (profile != null) {
      profile.rssi = rssi;
      await profile.save();
    }
  }

  /// 轉換 PPDeviceModel -> PPDeviceProfile
  static PPDeviceProfile _convertToProfile(
      String userId, PPDeviceModel device) {
    return PPDeviceProfile(
      deviceMac: device.deviceMac,
      deviceName: device.deviceName,
      customDeviceName: device.customDeviceName,
      devicePower: device.devicePower,
      rssi: device.rssi,
      sign: device.sign,
      firmwareVersion: device.firmwareVersion,
      hardwareVersion: device.hardwareVersion,
      softwareVersion: device.softwareVersion,
      calculateVersion: device.calculateVersion,
      manufacturerName: device.manufacturerName,
      serialNumber: device.serialNumber,
      modelNumber: device.modelNumber,
      deviceType: device.deviceType?.value,
      deviceProtocolType: device.deviceProtocolType?.value,
      deviceCalculateType: device.deviceCalculateType?.value,
      deviceAccuracyType: device.deviceAccuracyType?.value,
      devicePowerType: device.devicePowerType?.value,
      deviceConnectType: device.deviceConnectType?.value,
      deviceFuncType: device.deviceFuncType,
      deviceUnitType: device.deviceUnitType,
      mtu: device.mtu,
      illumination: device.illumination,
      advLength: device.advLength,
      macAddressStart: device.macAddressStart,
      deviceSettingId: device.deviceSettingId,
      imgUrl: device.imgUrl,
      productModel: device.productModel,
      standardType: device.standardType,
      brandId: device.brandId,
      avatarType: device.avatarType,
      peripheralType: device.peripheralType,
      ownerUserId: userId,
      createdAt: DateTime.now().format(pattern: 'yyyy/MM/dd HH:mm'),
      isConnected: false,
    );
  }

  /// 轉換 PPDeviceProfile -> PPDeviceModel（用於藍牙連線）
  static PPDeviceModel _convertToModel(PPDeviceProfile profile) {
    final model =
        PPDeviceModel(profile.deviceName ?? "", profile.deviceMac ?? "");

    // 設定所有屬性，保持與原始 PPDeviceModel 完全一致
    model.customDeviceName = profile.customDeviceName;
    model.devicePower = profile.devicePower;
    model.rssi = profile.rssi;
    model.firmwareVersion = profile.firmwareVersion;
    model.hardwareVersion = profile.hardwareVersion;
    model.manufacturerName = profile.manufacturerName;
    model.softwareVersion = profile.softwareVersion;
    model.serialNumber = profile.serialNumber;
    model.modelNumber = profile.modelNumber;
    model.calculateVersion = profile.calculateVersion;

    // 關鍵：枚舉類型轉換（使用 fromValue 方法）
    model.deviceType = profile.deviceType != null
        ? PPDeviceType.fromValue(profile.deviceType!)
        : PPDeviceType.unknown;
    model.deviceProtocolType = profile.deviceProtocolType != null
        ? PPDeviceProtocolType.fromValue(profile.deviceProtocolType!)
        : PPDeviceProtocolType.unknown;
    model.deviceCalculateType = profile.deviceCalculateType != null
        ? PPDeviceCalculateType.fromValue(profile.deviceCalculateType!)
        : PPDeviceCalculateType.alternate;
    model.deviceAccuracyType = profile.deviceAccuracyType != null
        ? PPDeviceAccuracyType.fromValue(profile.deviceAccuracyType!)
        : PPDeviceAccuracyType.point01;
    model.devicePowerType = profile.devicePowerType != null
        ? PPDevicePowerType.fromValue(profile.devicePowerType!)
        : PPDevicePowerType.battery;
    model.deviceConnectType = profile.deviceConnectType != null
        ? PPDeviceConnectType.fromValue(profile.deviceConnectType!)
        : PPDeviceConnectType.direct;

    // 其他屬性
    model.deviceFuncType = profile.deviceFuncType ?? 0;
    model.deviceUnitType = profile.deviceUnitType;
    model.mtu = profile.mtu ?? 20;
    model.illumination = profile.illumination ?? -1;
    model.advLength = profile.advLength ?? 0;
    model.macAddressStart = profile.macAddressStart ?? 0;
    model.sign = profile.sign;
    model.deviceSettingId = profile.deviceSettingId ?? 0;
    model.imgUrl = profile.imgUrl;
    model.productModel = profile.productModel;
    model.standardType = profile.standardType ?? 0;
    model.brandId = profile.brandId ?? 0;
    model.avatarType = profile.avatarType ?? 0;
    model.peripheralType = profile.peripheralType ?? 0;

    return model;
  }
}

