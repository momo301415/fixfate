import 'package:hive/hive.dart';

part 'body_temperature_setting.g.dart';

@HiveType(typeId: 5)
class BodyTemperatureSetting extends HiveObject {
  @HiveField(0)
  bool alertEnabled;

  @HiveField(1)
  String highThreshold;

  @HiveField(2)
  String lowThreshold;

  @HiveField(3)
  int? lastProcessedTimestamp;

  BodyTemperatureSetting({
    required this.alertEnabled,
    required this.highThreshold,
    required this.lowThreshold,
    this.lastProcessedTimestamp,
  });
}
