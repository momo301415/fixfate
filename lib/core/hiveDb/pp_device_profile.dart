import 'package:hive/hive.dart';

part 'pp_device_profile.g.dart';

@HiveType(typeId: 14)
class PPDeviceProfile extends HiveObject {
  // === 基本識別資訊 ===
  @HiveField(0)
  String? deviceMac; // 設備MAC地址（藍牙連線關鍵）

  @HiveField(1)
  String? deviceName; // 設備藍牙名稱

  @HiveField(2)
  String? customDeviceName; // 自定義設備名稱

  // === 設備狀態資訊 ===
  @HiveField(3)
  int? devicePower; // 電量 (-1=不支持, >0=有效值)

  @HiveField(4)
  int? rssi; // 藍牙信號強度

  @HiveField(5)
  String? sign; // 簽名

  // === 版本資訊 ===
  @HiveField(6)
  String? firmwareVersion; // 固件版本號

  @HiveField(7)
  String? hardwareVersion; // 硬件版本號

  @HiveField(8)
  String? softwareVersion; // 軟件版本號

  @HiveField(9)
  String? calculateVersion; // 計算版本

  // === 製造商資訊 ===
  @HiveField(10)
  String? manufacturerName; // 製造商

  @HiveField(11)
  String? serialNumber; // 序列號

  @HiveField(12)
  String? modelNumber; // 型號編號

  // === 設備類型（儲存為 int，對應枚舉的 value）===
  @HiveField(13)
  int? deviceType; // PPDeviceType.value

  @HiveField(14)
  int? deviceProtocolType; // PPDeviceProtocolType.value

  @HiveField(15)
  int? deviceCalculateType; // PPDeviceCalculateType.value

  @HiveField(16)
  int? deviceAccuracyType; // PPDeviceAccuracyType.value

  @HiveField(17)
  int? devicePowerType; // PPDevicePowerType.value

  @HiveField(18)
  int? deviceConnectType; // PPDeviceConnectType.value

  // === 功能與技術參數 ===
  @HiveField(19)
  int? deviceFuncType; // 功能類型

  @HiveField(20)
  String? deviceUnitType; // 支持單位

  @HiveField(21)
  int? mtu; // 協議單包長度

  @HiveField(22)
  int? illumination; // 光照強度

  @HiveField(23)
  int? advLength; // 廣播數據長度

  @HiveField(24)
  int? macAddressStart; // MAC起始位置

  @HiveField(25)
  int? deviceSettingId; // 設備配置ID

  // === 產品資訊 ===
  @HiveField(26)
  String? imgUrl; // 產品圖地址

  @HiveField(27)
  String? productModel; // 產品型號

  @HiveField(28)
  int? standardType; // 標準類型 (0=亞洲標準, 1=WHO標準)

  @HiveField(29)
  int? brandId; // 品牌ID

  @HiveField(30)
  int? avatarType; // 頭像類型

  @HiveField(31)
  int? peripheralType; // 外設類型

  // === 管理資訊 ===
  @HiveField(32)
  String? ownerUserId; // 擁有者用戶ID

  @HiveField(33)
  String? createdAt; // 創建時間

  @HiveField(34)
  String? lastConnectedAt; // 最後連線時間

  @HiveField(35)
  bool? isConnected; // 連線狀態

  PPDeviceProfile({
    this.deviceMac,
    this.deviceName,
    this.customDeviceName,
    this.devicePower,
    this.rssi,
    this.sign,
    this.firmwareVersion,
    this.hardwareVersion,
    this.softwareVersion,
    this.calculateVersion,
    this.manufacturerName,
    this.serialNumber,
    this.modelNumber,
    this.deviceType,
    this.deviceProtocolType,
    this.deviceCalculateType,
    this.deviceAccuracyType,
    this.devicePowerType,
    this.deviceConnectType,
    this.deviceFuncType,
    this.deviceUnitType,
    this.mtu,
    this.illumination,
    this.advLength,
    this.macAddressStart,
    this.deviceSettingId,
    this.imgUrl,
    this.productModel,
    this.standardType,
    this.brandId,
    this.avatarType,
    this.peripheralType,
    this.ownerUserId,
    this.createdAt,
    this.lastConnectedAt,
    this.isConnected,
  });
}

