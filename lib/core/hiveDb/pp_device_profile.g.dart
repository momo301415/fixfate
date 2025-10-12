// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pp_device_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PPDeviceProfileAdapter extends TypeAdapter<PPDeviceProfile> {
  @override
  final int typeId = 14;

  @override
  PPDeviceProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PPDeviceProfile(
      deviceMac: fields[0] as String?,
      deviceName: fields[1] as String?,
      customDeviceName: fields[2] as String?,
      devicePower: fields[3] as int?,
      rssi: fields[4] as int?,
      sign: fields[5] as String?,
      firmwareVersion: fields[6] as String?,
      hardwareVersion: fields[7] as String?,
      softwareVersion: fields[8] as String?,
      calculateVersion: fields[9] as String?,
      manufacturerName: fields[10] as String?,
      serialNumber: fields[11] as String?,
      modelNumber: fields[12] as String?,
      deviceType: fields[13] as int?,
      deviceProtocolType: fields[14] as int?,
      deviceCalculateType: fields[15] as int?,
      deviceAccuracyType: fields[16] as int?,
      devicePowerType: fields[17] as int?,
      deviceConnectType: fields[18] as int?,
      deviceFuncType: fields[19] as int?,
      deviceUnitType: fields[20] as String?,
      mtu: fields[21] as int?,
      illumination: fields[22] as int?,
      advLength: fields[23] as int?,
      macAddressStart: fields[24] as int?,
      deviceSettingId: fields[25] as int?,
      imgUrl: fields[26] as String?,
      productModel: fields[27] as String?,
      standardType: fields[28] as int?,
      brandId: fields[29] as int?,
      avatarType: fields[30] as int?,
      peripheralType: fields[31] as int?,
      ownerUserId: fields[32] as String?,
      createdAt: fields[33] as String?,
      lastConnectedAt: fields[34] as String?,
      isConnected: fields[35] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, PPDeviceProfile obj) {
    writer
      ..writeByte(36)
      ..writeByte(0)
      ..write(obj.deviceMac)
      ..writeByte(1)
      ..write(obj.deviceName)
      ..writeByte(2)
      ..write(obj.customDeviceName)
      ..writeByte(3)
      ..write(obj.devicePower)
      ..writeByte(4)
      ..write(obj.rssi)
      ..writeByte(5)
      ..write(obj.sign)
      ..writeByte(6)
      ..write(obj.firmwareVersion)
      ..writeByte(7)
      ..write(obj.hardwareVersion)
      ..writeByte(8)
      ..write(obj.softwareVersion)
      ..writeByte(9)
      ..write(obj.calculateVersion)
      ..writeByte(10)
      ..write(obj.manufacturerName)
      ..writeByte(11)
      ..write(obj.serialNumber)
      ..writeByte(12)
      ..write(obj.modelNumber)
      ..writeByte(13)
      ..write(obj.deviceType)
      ..writeByte(14)
      ..write(obj.deviceProtocolType)
      ..writeByte(15)
      ..write(obj.deviceCalculateType)
      ..writeByte(16)
      ..write(obj.deviceAccuracyType)
      ..writeByte(17)
      ..write(obj.devicePowerType)
      ..writeByte(18)
      ..write(obj.deviceConnectType)
      ..writeByte(19)
      ..write(obj.deviceFuncType)
      ..writeByte(20)
      ..write(obj.deviceUnitType)
      ..writeByte(21)
      ..write(obj.mtu)
      ..writeByte(22)
      ..write(obj.illumination)
      ..writeByte(23)
      ..write(obj.advLength)
      ..writeByte(24)
      ..write(obj.macAddressStart)
      ..writeByte(25)
      ..write(obj.deviceSettingId)
      ..writeByte(26)
      ..write(obj.imgUrl)
      ..writeByte(27)
      ..write(obj.productModel)
      ..writeByte(28)
      ..write(obj.standardType)
      ..writeByte(29)
      ..write(obj.brandId)
      ..writeByte(30)
      ..write(obj.avatarType)
      ..writeByte(31)
      ..write(obj.peripheralType)
      ..writeByte(32)
      ..write(obj.ownerUserId)
      ..writeByte(33)
      ..write(obj.createdAt)
      ..writeByte(34)
      ..write(obj.lastConnectedAt)
      ..writeByte(35)
      ..write(obj.isConnected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PPDeviceProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
