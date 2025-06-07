// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_record_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SportRecordListAdapter extends TypeAdapter<SportRecordList> {
  @override
  final int typeId = 12;

  @override
  SportRecordList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SportRecordList(
      records: (fields[0] as List).cast<SportRecord>(),
    );
  }

  @override
  void write(BinaryWriter writer, SportRecordList obj) {
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
      other is SportRecordListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
