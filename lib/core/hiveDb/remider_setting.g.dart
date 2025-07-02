// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remider_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RemiderSettingAdapter extends TypeAdapter<RemiderSetting> {
  @override
  final int typeId = 6;

  @override
  RemiderSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RemiderSetting(
      alertEnabled: fields[0] as bool,
      frequency: fields[1] as String,
      timing: fields[2] as String,
      lastUpdated: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, RemiderSetting obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.alertEnabled)
      ..writeByte(1)
      ..write(obj.frequency)
      ..writeByte(2)
      ..write(obj.timing)
      ..writeByte(3)
      ..write(obj.lastUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RemiderSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
