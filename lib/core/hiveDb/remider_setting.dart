import 'package:hive/hive.dart';

part 'remider_setting.g.dart';

@HiveType(typeId: 6)
class RemiderSetting extends HiveObject {
  @HiveField(0)
  bool alertEnabled;
  @HiveField(1)
  String frequency; // 範例："一天三次"

  @HiveField(2)
  String timing; // 範例："飯前"

  RemiderSetting({
    required this.alertEnabled,
    required this.frequency,
    required this.timing,
  });
}
