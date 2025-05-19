import 'package:hive/hive.dart';

part 'pressure_setting.g.dart';

@HiveType(typeId: 9)
class PressureSetting extends HiveObject {
  @HiveField(0)
  bool alertEnabled;

  @HiveField(1)
  int highThreshold;

  @HiveField(2)
  int? lastProcessedTimestamp;

  PressureSetting({
    required this.alertEnabled,
    required this.highThreshold,
    this.lastProcessedTimestamp,
  });
}
