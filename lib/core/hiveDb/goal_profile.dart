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

  GoalProfile({
    this.steps,
    this.sleepHours,
    this.calories,
    this.distance,
  });
}
