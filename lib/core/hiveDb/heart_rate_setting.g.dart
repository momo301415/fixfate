// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heart_rate_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HeartRateSettingAdapter extends TypeAdapter<HeartRateSetting> {
  @override
  final int typeId = 3;

  @override
  HeartRateSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HeartRateSetting(
      alertEnabled: fields[0] as bool,
      highThreshold: fields[1] as int,
      lowThreshold: fields[2] as int,
      lastProcessedTimestamp: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, HeartRateSetting obj) {
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
      other is HeartRateSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
