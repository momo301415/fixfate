import 'package:hive/hive.dart';

part 'device_profile.g.dart';

@HiveType(typeId: 1)
class DeviceProfile extends HiveObject {
  @HiveField(0)
  String macAddress;

  @HiveField(1)
  String deviceIdentifier;

  @HiveField(2)
  String name;

  @HiveField(3)
  int rssiValue;

  @HiveField(4)
  int firmwareVersion;

  @HiveField(5)
  int deviceSize;

  @HiveField(6)
  int deviceColor;

  @HiveField(7)
  int imageIndex;

  @HiveField(8)
  String deviceModel;

  @HiveField(9)
  String createdAt;

  @HiveField(10)
  String ownerUserId;

  DeviceProfile({
    required this.macAddress,
    required this.deviceIdentifier,
    required this.name,
    required this.rssiValue,
    required this.firmwareVersion,
    required this.deviceSize,
    required this.deviceColor,
    required this.imageIndex,
    required this.deviceModel,
    required this.createdAt,
    required this.ownerUserId,
  });
}
