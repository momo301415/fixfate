import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pulsedevice/core/hiveDb/user_profile.dart';
import 'package:pulsedevice/core/hiveDb/user_profile_storage.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/presentation/k22_bottomsheet/controller/k22_controller.dart';
import 'package:pulsedevice/presentation/k22_bottomsheet/k22_bottomsheet.dart';
import 'package:pulsedevice/presentation/k23_dialog/controller/k23_controller.dart';
import 'package:pulsedevice/presentation/k23_dialog/k23_dialog.dart';
import 'package:pulsedevice/presentation/k25_dialog/controller/k25_controller.dart';
import 'package:pulsedevice/presentation/k25_dialog/k25_dialog.dart';
import 'package:pulsedevice/presentation/k28_dialog/controller/k28_controller.dart';
import 'package:pulsedevice/presentation/k28_dialog/k28_dialog.dart';
import 'package:pulsedevice/presentation/k30_screen/models/chipview_four_item_model.dart';
import 'package:pulsedevice/presentation/k30_screen/models/chipview_item_model.dart';
import 'package:pulsedevice/presentation/k30_screen/models/chipview_one_item_model.dart';
import 'package:pulsedevice/presentation/k30_screen/models/chipview_three_item_model.dart';
import 'package:pulsedevice/presentation/k30_screen/models/chipview_two_item_model.dart';
import 'package:pulsedevice/presentation/k31_bottomsheet/controller/k31_controller.dart';
import 'package:pulsedevice/presentation/k31_bottomsheet/k31_bottomsheet.dart';
import 'package:pulsedevice/presentation/k32_dialog/controller/k32_controller.dart';
import 'package:pulsedevice/presentation/k32_dialog/k32_dialog.dart';
import 'package:pulsedevice/presentation/k34_dialog/controller/k34_controller.dart';
import 'package:pulsedevice/presentation/k34_dialog/k34_dialog.dart';
import 'package:pulsedevice/presentation/k35_bottomsheet/controller/k35_controller.dart';
import 'package:pulsedevice/presentation/k35_bottomsheet/k35_bottomsheet.dart';
import 'package:pulsedevice/presentation/k36_dialog/controller/k36_controller.dart';
import 'package:pulsedevice/presentation/k36_dialog/k36_dialog.dart';

import '../../../core/app_export.dart';
import '../models/k30_model.dart';

/// A controller class for the K30Screen.
///
/// This class manages the state of the K30Screen, including the
/// current k30ModelObj
class K30Controller extends GetxController {
  Rx<K30Model> k30ModelObj = K30Model().obs;
  var avatarPath = "".obs;
  var nickName = "".obs;
  var email = "".obs;
  var gender = "".obs;
  var birth = "".obs;
  var height = 0.0.obs;
  var weight = 0.0.obs;
  var waistline = 0.0.obs;
  var inputTexted = "".obs;
  RxList<String> personalHabits = <String>[].obs;
  RxList<String> dietHabits = <String>[].obs;
  RxList<String> pastDiseases = <String>[].obs;
  RxList<String> familyDiseases = <String>[].obs;
  RxList<String> drugAllergies = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  Future<void> selectAvatar() async {
    final path = await DialogHelper.showCustomBottomSheet<String>(
      Get.context!,
      K31Bottomsheet(Get.put(K31Controller())),
    );

    if (path != null && path.isNotEmpty) {
      avatarPath.value = path;
    }
  }

  Future<void> showInputNickName() async {
    final result = await DialogHelper.showCustomDialog(
        Get.context!, K32Dialog(Get.put(K32Controller())));
    if (result != null && result.isNotEmpty) {
      nickName.value = result;
    }
  }

  Future<void> showInputEmail() async {
    final result = await DialogHelper.showCustomDialog<String>(
        Get.context!, K34Dialog(Get.put(K34Controller())));
    if (result != null && result.isNotEmpty) {
      email.value = result;
    }
  }

  Future<void> selectGender() async {
    final result = await DialogHelper.showCustomBottomSheet(
        Get.context!, K35Bottomsheet(Get.put(K35Controller())));
    if (result != null && result.isNotEmpty) {
      gender.value = result;
    } else {
      // 預設
      gender.value = "男";
    }
  }

  Future<void> selectBirth() async {
    final result = await showModalBottomSheet(
        context: Get.context!,
        builder: (_) => K22Bottomsheet(Get.put(K22Controller())));
    if (result != null && result.isNotEmpty) {
      birth.value = result;
    } else {
      // 預設
      birth.value = "1985.03.14";
    }
  }

  Future<void> showInputHeight() async {
    final result = await DialogHelper.showCustomDialog(
        Get.context!, K23Dialog(Get.put(K23Controller())));
    if (result != null && result.isNotEmpty) {
      height.value = double.parse(result);
    } else {
      // 預設
      height.value = 175;
    }
  }

  Future<void> showInputWeight() async {
    final result = await DialogHelper.showCustomDialog(
        Get.context!, K25Dialog(Get.put(K25Controller())));
    if (result != null && result.isNotEmpty) {
      weight.value = double.parse(result);
    } else {
      // 預設
      weight.value = 65;
    }
  }

  Future<void> showInputWaistline() async {
    final result = await DialogHelper.showCustomDialog(
        Get.context!, K28Dialog(Get.put(K28Controller())));
    if (result != null && result.isNotEmpty) {
      waistline.value = double.parse(result);
    } else {
      // 預設
      waistline.value = 100;
    }
  }

  Future<void> showInputTexted() async {
    final result = await DialogHelper.showCustomDialog(
        Get.context!, K36Dialog(Get.put(K36Controller())));
    if (result != null && result.isNotEmpty) {
      inputTexted.value = result;
    }
  }

  void handleChipTap<T>({
    required int index,
    required T model,
    required BuildContext context,
    required String title,
    required String subTitle,
    required RxList<T> list,
    required T Function(String text) createModel,
    RxList<T>? Function()? onRefresh, // 若需特殊 refresh 可擴展
    void Function(T model)? onToggle,
  }) async {
    final lastIndex = list.length - 1;
    final isLastChip = index == lastIndex;

    if (isLastChip) {
      final result = await DialogHelper.showCustomDialog<String>(
        context,
        K36Dialog(
          Get.put(K36Controller()),
          title: title,
          subTitle: subTitle,
        ),
      );

      if (result != null && result.trim().isNotEmpty) {
        list.insert(lastIndex, createModel(result));
        onRefresh?.call()?.refresh();
        // 👉 清除 K36 的輸入框文字
        final dialogController = Get.find<K36Controller>();
        dialogController.inputlightoneController.clear();
        dialogController.inputedText.value = '';
      }
    } else {
      onToggle?.call(model);
    }
  }

  /// 更新選中的個人習慣
  void updateSelectedPersonalHabits() {
    final selected = k30ModelObj.value.chipviewItemList
        .where((item) => item.isSelected?.value == true)
        .map((item) => item.five?.value ?? '')
        .where((value) => value.isNotEmpty)
        .toList();

    personalHabits.assignAll(selected);
    print(personalHabits.toList().cast<String>());
  }

  /// 更新選中的飲食習慣
  void updateSelectedDietHabits() {
    final selected = k30ModelObj.value.chipviewOneItemList
        .where((item) => item.isSelected?.value == true)
        .map((item) => item.one?.value ?? '')
        .where((value) => value.isNotEmpty)
        .toList();

    dietHabits.assignAll(selected);
    print(dietHabits.toList().cast<String>());
  }

  /// 更新選中的過去疾病
  void updateSelectedPastDiseases() {
    final selected = k30ModelObj.value.chipviewTwoItemList
        .where((item) => item.isSelected?.value == true)
        .map((item) => item.two?.value ?? '')
        .where((value) => value.isNotEmpty)
        .toList();

    pastDiseases.assignAll(selected);
    print(pastDiseases.toList().cast<String>());
  }

  /// 更新選中的家族疾病
  void updateSelectedFamilyDiseases() {
    final selected = k30ModelObj.value.chipviewThreeItemList
        .where((item) => item.isSelected?.value == true)
        .map((item) => item.three?.value ?? '')
        .where((value) => value.isNotEmpty)
        .toList();

    familyDiseases.assignAll(selected);
    print(familyDiseases.toList().cast<String>());
  }

  /// 更新選中的藥物過敏
  void updateSelectedDrugAllergies() {
    final selected = k30ModelObj.value.chipviewFourItemList
        .where((item) => item.isSelected?.value == true)
        .map((item) => item.four?.value ?? '')
        .where((value) => value.isNotEmpty)
        .toList();

    drugAllergies.assignAll(selected);
    print(drugAllergies.toList().cast<String>());
  }

  Future<bool> saveUserProfile() async {
    bool res = false;
    try {
      final box = await Hive.openBox<UserProfile>('user_profile');
      final user = box.get('me') ?? UserProfile();
      user.avatar = avatarPath.value;
      user.nickname = nickName.value;
      user.email = email.value;
      user.gender = gender.value.isEmpty ? '男' : gender.value;
      user.birthDate = birth.value.isEmpty ? '1985.03.14' : birth.value;
      user.height = height.value > 0 ? height.value : 175;
      user.weight = weight.value > 0 ? weight.value : 65;
      user.waist = waistline.value > 0 ? waistline.value : 100;
      user.dietHabits = dietHabits.toList().cast<String>();
      user.pastDiseases = pastDiseases.toList().cast<String>();
      user.familyDiseases = familyDiseases.toList().cast<String>();
      user.drugAllergies = drugAllergies.toList().cast<String>();
      user.personalHabits = personalHabits.toList().cast<String>();
      await UserProfileStorage.saveUserProfile('me', user);
      res = true;
    } catch (e) {
      res = false;
    }
    return res;
  }

  Future<void> loadUserProfile() async {
    final box = await Hive.openBox<UserProfile>('user_profile');
    final user = box.get('me');
    if (user != null) {
      var list = k30ModelObj.value.listItemList.value;
      avatarPath.value = user.avatar ?? '';
      nickName.value = user.nickname ?? '';
      list[0].tf1?.value = user.nickname ?? '';
      email.value = user.email ?? '';
      list[1].tf1?.value = user.email ?? '';
      gender.value = user.gender ?? '';
      list[2].tf1?.value = user.gender ?? '';
      birth.value = user.birthDate ?? '';
      list[3].tf1?.value = user.birthDate ?? '';
      height.value = user.height ?? 175;
      list[4].tf1?.value = user.height.toString();
      weight.value = user.weight ?? 65;
      list[5].tf1?.value = user.weight.toString();
      waistline.value = user.waist ?? 100;
      personalHabits.assignAll(user.personalHabits);

      dietHabits.assignAll(user.dietHabits);
      pastDiseases.assignAll(user.pastDiseases);
      familyDiseases.assignAll(user.familyDiseases);
      drugAllergies.assignAll(user.drugAllergies);
      // Chip 還原
      restoreSelectedChipByText<ChipviewItemModel>(
        k30ModelObj.value.chipviewItemList,
        user.personalHabits,
        (m) => m.five?.value ?? '',
        (m) => m.isSelected!,
        (text) => ChipviewItemModel(five: text.obs, isSelected: true.obs),
      );

      restoreSelectedChipByText<ChipviewOneItemModel>(
        k30ModelObj.value.chipviewOneItemList,
        user.dietHabits,
        (m) => m.one?.value ?? '',
        (m) => m.isSelected!,
        (text) => ChipviewOneItemModel(one: text.obs, isSelected: true.obs),
      );

      restoreSelectedChipByText<ChipviewTwoItemModel>(
        k30ModelObj.value.chipviewTwoItemList,
        user.pastDiseases,
        (m) => m.two?.value ?? '',
        (m) => m.isSelected!,
        (text) => ChipviewTwoItemModel(two: text.obs, isSelected: true.obs),
      );

      restoreSelectedChipByText<ChipviewThreeItemModel>(
        k30ModelObj.value.chipviewThreeItemList,
        user.familyDiseases,
        (m) => m.three?.value ?? '',
        (m) => m.isSelected!,
        (text) => ChipviewThreeItemModel(three: text.obs, isSelected: true.obs),
      );

      restoreSelectedChipByText<ChipviewFourItemModel>(
        k30ModelObj.value.chipviewFourItemList,
        user.drugAllergies,
        (m) => m.four?.value ?? '',
        (m) => m.isSelected!,
        (text) => ChipviewFourItemModel(four: text.obs, isSelected: true.obs),
      );

      // 更新 UI
      k30ModelObj.refresh();
    }
  }

  /// 更新選中的Chip
  void restoreSelectedChipByText<T>(
    RxList<T> chipList,
    List<String> selectedTexts,
    String Function(T model) getText,
    Rx<bool> Function(T model) getSelected,
    T Function(String text) createModel, // ✅ 新增建構方法
  ) {
    // 先標記所有為未選中
    for (final chip in chipList) {
      getSelected(chip).value = false;
    }

    for (final text in selectedTexts) {
      final match = chipList.firstWhereOrNull((chip) => getText(chip) == text);
      if (match != null) {
        getSelected(match).value = true;
      } else {
        final newChip = createModel(text);
        getSelected(newChip).value = true;
        chipList.insert(chipList.length - 1, newChip); // 插入最後一個選項之前
      }
    }
  }
}
