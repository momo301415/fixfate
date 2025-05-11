// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_temperature_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BodyTemperatureSettingAdapter
    extends TypeAdapter<BodyTemperatureSetting> {
  @override
  final int typeId = 5;

  @override
  BodyTemperatureSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BodyTemperatureSetting(
      alertEnabled: fields[0] as bool,
      highThreshold: fields[1] as String,
      lowThreshold: fields[2] as String,
      lastProcessedTimestamp: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BodyTemperatureSetting obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.alertEnabled)
      ..writeByte(1)
      ..write(obj.highThreshold)
      ..writeByte(2)
      ..write(obj.lowThreshold)
      ..writeByte(3)
      ..write(obj.lastProcessedTimestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyTemperatureSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
