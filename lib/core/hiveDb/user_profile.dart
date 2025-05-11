import 'package:hive/hive.dart';
import 'package:pulsedevice/core/hiveDb/device_profile.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 0)
class UserProfile extends HiveObject {
  @HiveField(0)
  String? avatar;

  @HiveField(1)
  String? nickname;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? gender;

  @HiveField(4)
  String? birthDate;

  @HiveField(5)
  double? weight;

  @HiveField(6)
  double? height;

  @HiveField(7)
  double? waist;

  @HiveField(8)
  List<String>? personalHabits;

  @HiveField(9)
  List<String>? dietHabits;

  @HiveField(10)
  List<String>? pastDiseases;

  @HiveField(11)
  List<String>? familyDiseases;

  @HiveField(12)
  List<String>? drugAllergies;

  @HiveField(13)
  List<DeviceProfile>? devices;

  UserProfile({
    this.avatar,
    this.nickname,
    this.email,
    this.gender,
    this.birthDate,
    this.weight,
    this.height,
    this.waist,
    this.personalHabits = const [],
    this.dietHabits = const [],
    this.pastDiseases = const [],
    this.familyDiseases = const [],
    this.drugAllergies = const [],
    this.devices = const [],
  });
}
