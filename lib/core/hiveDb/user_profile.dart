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
  String? drinking;

  @HiveField(9)
  String? smoking;

  @HiveField(10)
  String? sporting;

  @HiveField(11)
  String? sitting;

  @HiveField(12)
  String? standding;

  @HiveField(13)
  String? lowHeadding;

  @HiveField(14)
  String? waterIntake;

  @HiveField(15)
  String? noneSleep;

  @HiveField(16)
  List<String>? foodHabits;

  @HiveField(17)
  List<String>? cookHabits;

  @HiveField(18)
  List<String>? pastDiseases;

  @HiveField(19)
  List<String>? familyDiseases;

  @HiveField(20)
  List<String>? drugAllergies;

  @HiveField(21)
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
    this.drinking,
    this.smoking,
    this.sporting,
    this.sitting,
    this.standding,
    this.lowHeadding,
    this.waterIntake,
    this.noneSleep,
    this.foodHabits = const [],
    this.cookHabits = const [],
    this.pastDiseases = const [],
    this.familyDiseases = const [],
    this.drugAllergies = const [],
    this.devices = const [],
  });
}
