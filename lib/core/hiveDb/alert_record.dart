import 'package:hive/hive.dart';
part 'alert_record.g.dart';

@HiveType(typeId: 7)
class AlertRecord extends HiveObject {
  @HiveField(0)
  String label; // 例：血壓偏高、心率偏高、傾倒偵測等

  @HiveField(1)
  DateTime time; // 發生時間

  @HiveField(2)
  String type; // 類別：如 bloodPressure、heartRate、fall 等（方便分類統計）

  @HiveField(3)
  String? value; // 類別的數值

  @HiveField(4)
  String? unit; // 類別的單位

  @HiveField(5)
  bool synced = false; // 是否已同步

  AlertRecord({
    required this.label,
    required this.time,
    required this.type,
    this.value,
    this.unit,
    this.synced = false,
  });

  String get formattedTime =>
      '${time.year}年${_twoDigits(time.month)}月${_twoDigits(time.day)}日 ${_twoDigits(time.hour)}:${_twoDigits(time.minute)}';

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AlertRecord && other.time == time && other.type == type;
  }

  @override
  int get hashCode => time.hashCode ^ type.hashCode;
}
