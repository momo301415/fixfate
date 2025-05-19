import 'package:hive/hive.dart';
part 'listen_setting.g.dart';

@HiveType(typeId: 10)
class ListenSetting extends HiveObject {
  @HiveField(0)
  int? times;
  ListenSetting({this.times});
}
