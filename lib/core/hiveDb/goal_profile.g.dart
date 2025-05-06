// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalProfileAdapter extends TypeAdapter<GoalProfile> {
  @override
  final int typeId = 2;

  @override
  GoalProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoalProfile(
      steps: fields[0] as int?,
      sleepHours: fields[1] as double?,
      calories: fields[2] as int?,
      distance: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, GoalProfile obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.steps)
      ..writeByte(1)
      ..write(obj.sleepHours)
      ..writeByte(2)
      ..write(obj.calories)
      ..writeByte(3)
      ..write(obj.distance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
