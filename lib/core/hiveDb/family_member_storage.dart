import 'package:hive/hive.dart';
import 'package:pulsedevice/core/hiveDb/family_member.dart';

class FamilyMemberStorage {
  static Future<Box<FamilyMember>> _openFamilyBox(String loginUserId) {
    final boxName = 'family_$loginUserId';
    return Hive.openBox<FamilyMember>(boxName);
  }

  static Future<void> saveFamilyMember(
      String userId, FamilyMember profile) async {
    final _box = await _openFamilyBox(userId);
    await _box.put(profile.userId, profile);
  }

  static Future<List<FamilyMember>>? getFamilyMember(String userId) async {
    final _box = await _openFamilyBox(userId);
    return _box.values.toList();
  }

  static Future<void> deleteFamilyMember(String userId, String memberId) async {
    final _box = await _openFamilyBox(userId);
    await _box.delete(memberId);
  }
}
