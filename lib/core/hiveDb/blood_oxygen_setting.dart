import 'package:hive/hive.dart';

part 'blood_oxygen_setting.g.dart';

@HiveType(typeId: 4)
class BloodOxygenSetting extends HiveObject {
  @HiveField(0)
  bool alertEnabled;

  @HiveField(1)
  int lowThreshold;

  @HiveField(2)
  int? lastProcessedTimestamp;

  BloodOxygenSetting({
    required this.alertEnabled,
    required this.lowThreshold,
    this.lastProcessedTimestamp,
  });
}
