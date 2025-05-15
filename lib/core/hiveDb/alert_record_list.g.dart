// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_record_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlertRecordListAdapter extends TypeAdapter<AlertRecordList> {
  @override
  final int typeId = 8;

  @override
  AlertRecordList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlertRecordList(
      records: (fields[0] as List).cast<AlertRecord>(),
    );
  }

  @override
  void write(BinaryWriter writer, AlertRecordList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.records);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlertRecordListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
