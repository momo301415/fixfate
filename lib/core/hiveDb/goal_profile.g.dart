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
      isEnableSteps: fields[4] as bool?,
      isEnablesleepHours: fields[5] as bool?,
      isEnablecalories: fields[6] as bool?,
      isEnabledistance: fields[7] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, GoalProfile obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.steps)
      ..writeByte(1)
      ..write(obj.sleepHours)
      ..writeByte(2)
      ..write(obj.calories)
      ..writeByte(3)
      ..write(obj.distance)
      ..writeByte(4)
      ..write(obj.isEnableSteps)
      ..writeByte(5)
      ..write(obj.isEnablesleepHours)
      ..writeByte(6)
      ..write(obj.isEnablecalories)
      ..writeByte(7)
      ..write(obj.isEnabledistance);
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
