import 'package:hive/hive.dart';
part 'family_member.g.dart';

@HiveType(typeId: 13)
class FamilyMember extends HiveObject {
  @HiveField(0)
  String? userId;
  @HiveField(1)
  String? nickname; // 對方設定
  @HiveField(2)
  String? remarkName; // 自己備註
  @HiveField(3)
  String? avatarUrl;
  @HiveField(4)
  bool? alertEnabled;

  FamilyMember({
    this.userId,
    this.nickname,
    this.remarkName,
    this.avatarUrl,
    this.alertEnabled,
  });
}
