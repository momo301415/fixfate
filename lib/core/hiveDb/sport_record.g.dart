// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SportRecordAdapter extends TypeAdapter<SportRecord> {
  @override
  final int typeId = 11;

  @override
  SportRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SportRecord(
      sportType: fields[0] as String,
      time: fields[1] as DateTime,
      distance: fields[2] as int?,
      step: fields[3] as int?,
      bpm: fields[4] as int?,
      hours: fields[5] as int?,
      minutes: fields[6] as int?,
      seconds: fields[7] as int?,
      calories: fields[8] as int?,
      maxBpm: fields[9] as int?,
      minBpm: fields[10] as int?,
      avgBpm: fields[11] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SportRecord obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.sportType)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.distance)
      ..writeByte(3)
      ..write(obj.step)
      ..writeByte(4)
      ..write(obj.bpm)
      ..writeByte(5)
      ..write(obj.hours)
      ..writeByte(6)
      ..write(obj.minutes)
      ..writeByte(7)
      ..write(obj.seconds)
      ..writeByte(8)
      ..write(obj.calories)
      ..writeByte(9)
      ..write(obj.maxBpm)
      ..writeByte(10)
      ..write(obj.minBpm)
      ..writeByte(11)
      ..write(obj.avgBpm);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SportRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
