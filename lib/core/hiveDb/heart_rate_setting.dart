import 'package:hive/hive.dart';

part 'heart_rate_setting.g.dart';

@HiveType(typeId: 3)
class HeartRateSetting extends HiveObject {
  @HiveField(0)
  bool alertEnabled;

  @HiveField(1)
  int highThreshold;

  @HiveField(2)
  int lowThreshold;

  @HiveField(3)
  int? lastProcessedTimestamp;

  HeartRateSetting({
    required this.alertEnabled,
    required this.highThreshold,
    required this.lowThreshold,
    this.lastProcessedTimestamp,
  });
}
