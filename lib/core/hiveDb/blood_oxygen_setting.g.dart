// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_oxygen_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BloodOxygenSettingAdapter extends TypeAdapter<BloodOxygenSetting> {
  @override
  final int typeId = 4;

  @override
  BloodOxygenSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BloodOxygenSetting(
      alertEnabled: fields[0] as bool,
      lowThreshold: fields[2] as int,
      lastProcessedTimestamp: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BloodOxygenSetting obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.alertEnabled)
      ..writeByte(1)
      ..write(obj.lowThreshold)
      ..writeByte(2)
      ..write(obj.lastProcessedTimestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodOxygenSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
