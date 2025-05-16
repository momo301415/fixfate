// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 0;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      avatar: fields[0] as String?,
      nickname: fields[1] as String?,
      email: fields[2] as String?,
      gender: fields[3] as String?,
      birthDate: fields[4] as String?,
      weight: fields[5] as double?,
      height: fields[6] as double?,
      waist: fields[7] as double?,
      drinking: fields[8] as String?,
      smoking: fields[9] as String?,
      sporting: fields[10] as String?,
      sitting: fields[11] as String?,
      standding: fields[12] as String?,
      lowHeadding: fields[13] as String?,
      waterIntake: fields[14] as String?,
      noneSleep: fields[15] as String?,
      foodHabits: (fields[16] as List?)?.cast<String>(),
      cookHabits: (fields[17] as List?)?.cast<String>(),
      pastDiseases: (fields[18] as List?)?.cast<String>(),
      familyDiseases: (fields[19] as List?)?.cast<String>(),
      drugAllergies: (fields[20] as List?)?.cast<String>(),
      devices: (fields[21] as List?)?.cast<DeviceProfile>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.avatar)
      ..writeByte(1)
      ..write(obj.nickname)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.birthDate)
      ..writeByte(5)
      ..write(obj.weight)
      ..writeByte(6)
      ..write(obj.height)
      ..writeByte(7)
      ..write(obj.waist)
      ..writeByte(8)
      ..write(obj.drinking)
      ..writeByte(9)
      ..write(obj.smoking)
      ..writeByte(10)
      ..write(obj.sporting)
      ..writeByte(11)
      ..write(obj.sitting)
      ..writeByte(12)
      ..write(obj.standding)
      ..writeByte(13)
      ..write(obj.lowHeadding)
      ..writeByte(14)
      ..write(obj.waterIntake)
      ..writeByte(15)
      ..write(obj.noneSleep)
      ..writeByte(16)
      ..write(obj.foodHabits)
      ..writeByte(17)
      ..write(obj.cookHabits)
      ..writeByte(18)
      ..write(obj.pastDiseases)
      ..writeByte(19)
      ..write(obj.familyDiseases)
      ..writeByte(20)
      ..write(obj.drugAllergies)
      ..writeByte(21)
      ..write(obj.devices);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
