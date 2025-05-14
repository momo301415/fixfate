import 'package:hive/hive.dart';
part 'goal_profile.g.dart';

@HiveType(typeId: 2)
class GoalProfile extends HiveObject {
  @HiveField(0)
  int? steps;

  @HiveField(1)
  double? sleepHours;

  @HiveField(2)
  int? calories;

  @HiveField(3)
  int? distance;

  @HiveField(4)
  bool? isEnableSteps;

  @HiveField(5)
  bool? isEnablesleepHours;

  @HiveField(6)
  bool? isEnablecalories;

  @HiveField(7)
  bool? isEnabledistance;

  GoalProfile({
    this.steps,
    this.sleepHours,
    this.calories,
    this.distance,
    this.isEnableSteps,
    this.isEnablesleepHours,
    this.isEnablecalories,
    this.isEnabledistance,
  });
}
