// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeviceProfileAdapter extends TypeAdapter<DeviceProfile> {
  @override
  final int typeId = 1;

  @override
  DeviceProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeviceProfile(
      macAddress: fields[0] as String,
      deviceIdentifier: fields[1] as String,
      name: fields[2] as String,
      rssiValue: fields[3] as int,
      firmwareVersion: fields[4] as int,
      deviceSize: fields[5] as int,
      deviceColor: fields[6] as int,
      imageIndex: fields[7] as int,
      deviceModel: fields[8] as String,
      createdAt: fields[9] as String,
      ownerUserId: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeviceProfile obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.macAddress)
      ..writeByte(1)
      ..write(obj.deviceIdentifier)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.rssiValue)
      ..writeByte(4)
      ..write(obj.firmwareVersion)
      ..writeByte(5)
      ..write(obj.deviceSize)
      ..writeByte(6)
      ..write(obj.deviceColor)
      ..writeByte(7)
      ..write(obj.imageIndex)
      ..writeByte(8)
      ..write(obj.deviceModel)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.ownerUserId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
