// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlertRecordAdapter extends TypeAdapter<AlertRecord> {
  @override
  final int typeId = 7;

  @override
  AlertRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlertRecord(
      label: fields[0] as String,
      time: fields[1] as DateTime,
      type: fields[2] as String,
      value: fields[3] as String?,
      unit: fields[4] as String?,
      synced: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AlertRecord obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.value)
      ..writeByte(4)
      ..write(obj.unit)
      ..writeByte(5)
      ..write(obj.synced);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlertRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
