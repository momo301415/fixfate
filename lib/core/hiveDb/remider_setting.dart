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

  @HiveField(3)
  DateTime? lastUpdated;

  RemiderSetting({
    required this.alertEnabled,
    required this.frequency,
    required this.timing,
    this.lastUpdated,
  });

  bool get isValid => frequency.isNotEmpty && timing.isNotEmpty;

  bool get isActive => alertEnabled && isValid;

  RemiderSetting copyWith({
    bool? alertEnabled,
    String? frequency,
    String? timing,
    DateTime? lastUpdated,
  }) {
    return RemiderSetting(
      alertEnabled: alertEnabled ?? this.alertEnabled,
      frequency: frequency ?? this.frequency,
      timing: timing ?? this.timing,
      lastUpdated: lastUpdated ?? this.lastUpdated ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'alertEnabled': alertEnabled,
      'frequency': frequency,
      'timing': timing,
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }

  factory RemiderSetting.fromMap(Map<String, dynamic> map) {
    return RemiderSetting(
      alertEnabled: map['alertEnabled'] ?? false,
      frequency: map['frequency'] ?? '',
      timing: map['timing'] ?? '',
      lastUpdated: map['lastUpdated'] != null
          ? DateTime.parse(map['lastUpdated'])
          : null,
    );
  }

  @override
  String toString() {
    return 'RemiderSetting(alertEnabled: $alertEnabled, frequency: $frequency, timing: $timing, lastUpdated: $lastUpdated)';
  }
}
