import 'package:hive/hive.dart';
import 'package:pulsedevice/core/hiveDb/alert_record.dart';
part 'alert_record_list.g.dart';

@HiveType(typeId: 8)
class AlertRecordList extends HiveObject {
  @HiveField(0)
  List<AlertRecord> records;

  AlertRecordList({required this.records});
}
