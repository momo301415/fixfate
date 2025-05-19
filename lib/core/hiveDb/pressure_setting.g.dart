// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pressure_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PressureSettingAdapter extends TypeAdapter<PressureSetting> {
  @override
  final int typeId = 9;

  @override
  PressureSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PressureSetting(
      alertEnabled: fields[0] as bool,
      highThreshold: fields[1] as int,
      lastProcessedTimestamp: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PressureSetting obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.alertEnabled)
      ..writeByte(1)
      ..write(obj.highThreshold)
      ..writeByte(2)
      ..write(obj.lastProcessedTimestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PressureSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
