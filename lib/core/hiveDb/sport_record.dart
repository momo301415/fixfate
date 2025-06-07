import 'package:hive/hive.dart';
part 'sport_record.g.dart';

@HiveType(typeId: 11)
class SportRecord extends HiveObject {
  @HiveField(0)
  String sportType;
  @HiveField(1)
  DateTime time; // 發生時間
  @HiveField(2)
  int? distance;
  @HiveField(3)
  int? step;
  @HiveField(4)
  int? bpm;
  @HiveField(5)
  int? hours;
  @HiveField(6)
  int? minutes;
  @HiveField(7)
  int? seconds;
  @HiveField(8)
  int? calories = 0;
  @HiveField(9)
  int? maxBpm = 0;
  @HiveField(10)
  int? minBpm = 0;
  @HiveField(11)
  int? avgBpm = 0;

  SportRecord(
      {required this.sportType,
      required this.time,
      this.distance,
      this.step,
      this.bpm,
      this.hours,
      this.minutes,
      this.seconds,
      this.calories,
      this.maxBpm,
      this.minBpm,
      this.avgBpm});
}
