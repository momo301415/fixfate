import 'package:hive/hive.dart';
import 'package:pulsedevice/core/hiveDb/sport_record.dart';
part 'sport_record_list.g.dart';

@HiveType(typeId: 12)
class SportRecordList extends HiveObject {
  @HiveField(0)
  List<SportRecord> records;

  SportRecordList({required this.records});
}
