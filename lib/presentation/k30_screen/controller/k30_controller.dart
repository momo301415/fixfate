import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/user_profile.dart';
import 'package:pulsedevice/core/hiveDb/user_profile_storage.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/core/utils/snackbar_helper.dart';
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
import 'package:pulsedevice/presentation/k90_bottomsheet/controller/k90_controller.dart';
import 'package:pulsedevice/presentation/k90_bottomsheet/k90_bottomsheet.dart';
import 'package:pulsedevice/presentation/k91_bottomsheet/controller/k91_controller.dart';
import 'package:pulsedevice/presentation/k91_bottomsheet/k91_bottomsheet.dart';
import 'package:pulsedevice/presentation/k92_bottomsheet/controller/k92_controller.dart';
import 'package:pulsedevice/presentation/k92_bottomsheet/k92_bottomsheet.dart';

import 'package:pulsedevice/presentation/k93_bottomsheet/controller/k93_controller.dart';
import 'package:pulsedevice/presentation/k93_bottomsheet/k93_bottomsheet.dart';
import 'package:pulsedevice/presentation/k94_bottomsheet/controller/k94_controller.dart';
import 'package:pulsedevice/presentation/k94_bottomsheet/k94_bottomsheet.dart';
import 'package:pulsedevice/presentation/k95_bottomsheet/controller/k95_controller.dart';
import 'package:pulsedevice/presentation/k95_bottomsheet/k95_bottomsheet.dart';
import 'package:pulsedevice/presentation/k96_bottomsheet/controller/k96_controller.dart';
import 'package:pulsedevice/presentation/k96_bottomsheet/k96_bottomsheet.dart';
import 'package:pulsedevice/presentation/k97_bottomsheet/controller/k97_controller.dart';
import 'package:pulsedevice/presentation/k97_bottomsheet/k97_bottomsheet.dart';

import '../../../core/app_export.dart';
import '../models/k30_model.dart';

/// A controller class for the K30Screen.
///
/// This class manages the state of the K30Screen, including the
/// current k30ModelObj
class K30Controller extends GetxController {
  Rx<K30Model> k30ModelObj = K30Model().obs;
  final gc = Get.find<GlobalController>();
  var avatarPath = "".obs;
  var nickName = "".obs;
  var email = "".obs;
  var gender = "".obs;
  var birth = "".obs;
  var height = 0.0.obs;
  var weight = 0.0.obs;
  var waistline = 0.0.obs;
  var inputTexted = "".obs;
  var drikValue = "".obs;
  var smokeValue = "".obs;
  var sportValue = "".obs;
  var longSitValue = "".obs;
  var longStandValue = "".obs;
  var lowHeadValue = "".obs;
  var waterValue = "".obs;
  var noneSleepValue = "".obs;
  RxList<String> personalHabits = <String>[].obs;
  RxList<String> foodHabits = <String>[].obs;
  RxList<String> cookHabits = <String>[].obs;
  RxList<String> pastDiseases = <String>[].obs;
  RxList<String> familyDiseases = <String>[].obs;
  RxList<String> drugAllergies = <String>[].obs;
  ApiService api = ApiService();

  @override

  /// Called when the widget is initialized.
  ///
  /// This method is called when the `K30Controller` is created.
  /// It loads the user profile from the local storage.
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

  Future<void> selectDrink() async {
    final result = await DialogHelper.showCustomBottomSheet(
        Get.context!, K90Bottomsheet(Get.put(K90Controller())));
    if (result != null && result.isNotEmpty) {
      drikValue.value = result;
    }
  }

  Future<void> selectSmoke() async {
    final result = await DialogHelper.showCustomBottomSheet(
        Get.context!, K91Bottomsheet(Get.put(K91Controller())));
    if (result != null && result.isNotEmpty) {
      smokeValue.value = result;
    }
  }

  Future<void> selectSport() async {
    final result = await DialogHelper.showCustomBottomSheet(
        Get.context!, K92Bottomsheet(Get.put(K92Controller())));
    if (result != null && result.isNotEmpty) {
      sportValue.value = result;
    }
  }

  Future<void> selectLongSit() async {
    final result = await DialogHelper.showCustomBottomSheet(
        Get.context!, K93Bottomsheet(Get.put(K93Controller())));
    if (result != null && result.isNotEmpty) {
      longSitValue.value = result;
    }
  }

  Future<void> selectLongStand() async {
    final result = await DialogHelper.showCustomBottomSheet(
        Get.context!, K94Bottomsheet(Get.put(K94Controller())));
    if (result != null && result.isNotEmpty) {
      longStandValue.value = result;
    }
  }

  Future<void> selectLowHead() async {
    final result = await DialogHelper.showCustomBottomSheet(
        Get.context!, K95Bottomsheet(Get.put(K95Controller())));
    if (result != null && result.isNotEmpty) {
      lowHeadValue.value = result;
    }
  }

  Future<void> selectWater() async {
    final result = await DialogHelper.showCustomBottomSheet(
        Get.context!, K96Bottomsheet(Get.put(K96Controller())));
    if (result != null && result.isNotEmpty) {
      waterValue.value = result;
    }
  }

  Future<void> selectNoneSleep() async {
    final result = await DialogHelper.showCustomBottomSheet(
        Get.context!, K97Bottomsheet(Get.put(K97Controller())));
    if (result != null && result.isNotEmpty) {
      noneSleepValue.value = result;
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

  /// 更新選中的飲食習慣
  void updateSelectedFoodHabits() {
    final selected = k30ModelObj.value.chipviewItemList
        .where((item) => item.isSelected?.value == true)
        .map((item) => item.five?.value ?? '')
        .where((value) => value.isNotEmpty)
        .toList();

    foodHabits.assignAll(selected);
    print(foodHabits.toList().cast<String>());
  }

  /// 更新選中的飲食習慣
  void updateSelectedCookHabits() {
    final selected = k30ModelObj.value.chipviewOneItemList
        .where((item) => item.isSelected?.value == true)
        .map((item) => item.one?.value ?? '')
        .where((value) => value.isNotEmpty)
        .toList();

    cookHabits.assignAll(selected);
    print(cookHabits.toList().cast<String>());
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
      final user = box.get(gc.userId.value) ?? UserProfile();
      user.avatar = avatarPath.value;
      user.nickname = nickName.value;
      user.email = email.value;
      user.gender = gender.value.isEmpty ? '男' : gender.value;
      user.birthDate =
          birth.value.isEmpty ? '1985-03-14' : birth.value.replaceAll(".", "-");
      user.height = height.value > 0 ? height.value : 175;
      user.weight = weight.value > 0 ? weight.value : 65;
      user.waist = waistline.value > 0 ? waistline.value : 100;
      user.drinking = drikValue.value.isEmpty ? 'lbl300_1'.tr : drikValue.value;
      user.smoking =
          smokeValue.value.isEmpty ? 'lbl301_1'.tr : smokeValue.value;
      user.sporting = sportValue.value.isEmpty ? 'lbl299'.tr : sportValue.value;
      user.sitting =
          longSitValue.value.isEmpty ? 'lbl303_1'.tr : longSitValue.value;
      user.standding =
          longStandValue.value.isEmpty ? 'lbl303_1'.tr : longStandValue.value;
      user.lowHeadding =
          lowHeadValue.value.isEmpty ? 'lbl303_1'.tr : lowHeadValue.value;
      user.waterIntake =
          waterValue.value.isEmpty ? 'lbl306_3'.tr : waterValue.value;
      user.noneSleep =
          noneSleepValue.value.isEmpty ? 'lbl307_1'.tr : noneSleepValue.value;
      user.foodHabits = foodHabits.toList().cast<String>();
      user.cookHabits = cookHabits.toList().cast<String>();
      user.pastDiseases = pastDiseases.toList().cast<String>();
      user.familyDiseases = familyDiseases.toList().cast<String>();
      user.drugAllergies = drugAllergies.toList().cast<String>();

      await UserProfileStorage.saveUserProfile(gc.userId.value, user);

      res = true;
    } catch (e) {
      res = false;
    }
    return res;
  }

  Future<void> loadUserProfile() async {
    final box = await Hive.openBox<UserProfile>('user_profile');
    var user = box.get(gc.userId.value);

    ///如果手機資料庫沒資料就撈api
    if (user == null || user.gender == null) {
      user = await getUserProfile(gc.userId.value);
    }
    if (user.gender != null) {
      var list = k30ModelObj.value.listItemList.value;
      var list2 = k30ModelObj.value.listItemList2.value;
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

      list2[0].tf1?.value = user.drinking ?? 'lbl300_1'.tr;
      drikValue.value = user.drinking ?? 'lbl300_1'.tr;
      list2[1].tf1?.value = user.smoking ?? 'lbl301_1'.tr;
      smokeValue.value = user.smoking ?? 'lbl301_1'.tr;
      list2[2].tf1?.value = user.sporting ?? 'lbl299'.tr;
      sportValue.value = user.sporting ?? 'lbl299'.tr;
      list2[3].tf1?.value = user.sitting ?? 'lbl303_1'.tr;
      longSitValue.value = user.sitting ?? 'lbl303_1'.tr;
      list2[4].tf1?.value = user.standding ?? 'lbl303_1'.tr;
      longStandValue.value = user.standding ?? 'lbl303_1'.tr;
      list2[5].tf1?.value = user.lowHeadding ?? 'lbl303_1'.tr;
      lowHeadValue.value = user.lowHeadding ?? 'lbl303_1  ';
      list2[6].tf1?.value = user.waterIntake ?? 'lbl306_3'.tr;
      waterValue.value = user.waterIntake ?? 'lbl306_3'.tr;
      list2[7].tf1?.value = user.noneSleep ?? 'lbl307_1'.tr;
      noneSleepValue.value = user.noneSleep ?? 'lbl307_1'.tr;

      foodHabits.assignAll(user.foodHabits ?? []);
      cookHabits.assignAll(user.cookHabits ?? []);
      pastDiseases.assignAll(user.pastDiseases ?? []);
      familyDiseases.assignAll(user.familyDiseases ?? []);
      drugAllergies.assignAll(user.drugAllergies ?? []);
      // Chip 還原
      restoreSelectedChipByText<ChipviewItemModel>(
        k30ModelObj.value.chipviewItemList,
        user.foodHabits!,
        (m) => m.five?.value ?? '',
        (m) => m.isSelected!,
        (text) => ChipviewItemModel(five: text.obs, isSelected: true.obs),
      );

      restoreSelectedChipByText<ChipviewOneItemModel>(
        k30ModelObj.value.chipviewOneItemList,
        user.cookHabits!,
        (m) => m.one?.value ?? '',
        (m) => m.isSelected!,
        (text) => ChipviewOneItemModel(one: text.obs, isSelected: true.obs),
      );

      restoreSelectedChipByText<ChipviewTwoItemModel>(
        k30ModelObj.value.chipviewTwoItemList,
        user.pastDiseases!,
        (m) => m.two?.value ?? '',
        (m) => m.isSelected!,
        (text) => ChipviewTwoItemModel(two: text.obs, isSelected: true.obs),
      );

      restoreSelectedChipByText<ChipviewThreeItemModel>(
        k30ModelObj.value.chipviewThreeItemList,
        user.familyDiseases!,
        (m) => m.three?.value ?? '',
        (m) => m.isSelected!,
        (text) => ChipviewThreeItemModel(three: text.obs, isSelected: true.obs),
      );

      restoreSelectedChipByText<ChipviewFourItemModel>(
        k30ModelObj.value.chipviewFourItemList,
        user.drugAllergies!,
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

  /// call api上傳圖片
  Future<String> uploadAvatar() async {
    if (avatarPath.value.isEmpty) return "";
    LoadingHelper.show();
    try {
      final res = await api.uploadImage(
          path: Api.avatar,
          imageFile: File(avatarPath.value),
          phone: gc.userId.value);
      LoadingHelper.hide();
      if (res.isNotEmpty) {
        var resBody = res['data'];
        if (resBody != null) {
          return resBody['avatarUrl'];
        } else {
          DialogHelper.showError("${res["message"]}");
        }
      }
    } catch (e) {
      LoadingHelper.hide();
      DialogHelper.showError("服務錯誤，請稍後再試");
    } finally {
      LoadingHelper.hide();
    }
    return "";
  }

  /// call api取得個人資訊
  Future<UserProfile> getUserProfile(String phone) async {
    LoadingHelper.show();
    try {
      final res = await api.postJson(Api.userProfile, {'phone': phone});
      LoadingHelper.hide();
      if (res.isNotEmpty) {
        var resBody = res['data'];
        if (resBody != null) {
          final user = UserProfile();
          user.avatar = resBody['avatarUrl'] ?? '';
          user.nickname = resBody['name'] ?? '';
          user.email = resBody['email'] ?? '';
          user.gender = resBody['gender'] ?? '';
          user.birthDate = resBody['birthDate'] ?? '';
          user.height = double.tryParse(resBody['bodyHeight'] ?? '0') ?? 0.0;
          user.weight = double.tryParse(resBody['bodyWeight'] ?? '0') ?? 0.0;
          user.waist = double.tryParse(resBody['waistline'] ?? '0') ?? 0.0;
          final otherData = resBody['otherData'];
          final habits = otherData['habits'];

          user.drinking = habits['drinking'] ?? '';
          user.smoking = habits['smoking'] ?? '';
          user.sporting = habits['exercise'] ?? '';
          user.sitting = habits['sitting'] ?? '';
          user.standding = habits['standing'] ?? '';
          user.lowHeadding = habits['lowHead'] ?? '';
          user.waterIntake = habits['waterIntake'] ?? '';
          user.noneSleep = habits['noneSleep'] ?? '';
          user.foodHabits?.assignAll(List<String>.from(
            otherData['foodPreferences']?["favoriteTypes"] ?? [],
          ));

          user.cookHabits?.assignAll(List<String>.from(
            otherData['cookingPreferences']?["favoriteTypes"] ?? [],
          ));

          user.pastDiseases?.assignAll(List<String>.from(
            otherData['medicalHistory']?["pastDiseases"] ?? [],
          ));

          user.familyDiseases?.assignAll(List<String>.from(
            otherData['familyHistory']?["pastDiseases"] ?? [],
          ));

          user.drugAllergies?.assignAll(List<String>.from(
            otherData['allergies']?["drug"] ?? [],
          ));
          return user;
        } else {
          DialogHelper.showError("${res["message"]}");
        }
      }
    } catch (e) {
      LoadingHelper.hide();
      DialogHelper.showError("服務錯誤，請稍後再試");
    } finally {
      LoadingHelper.hide();
    }
    return UserProfile();
  }

  /// call api更新個人資訊
  Future<bool> updateUserProfile(String imgPath) async {
    LoadingHelper.show();
    try {
      var params = {
        "phone": gc.userId.value,
        "email": email.value,
        "name": nickName.value,
        "birthDate": birth.value.replaceAll(".", "-"),
        "gender": gender.value,
        "avatarUrl": imgPath.isEmpty ? null : imgPath,
        "bodyWeight": weight.value,
        "bodyHeight": height.value,
        "waistline": waistline.value,
        "otherData": {
          "habits": {
            "drinking": drikValue.value,
            "smoking": smokeValue.value,
            "exercise": sportValue.value,
            "sedentaryTime": longSitValue.value,
            "standingTime": longStandValue.value,
            "lowActivityTime": lowHeadValue.value,
            "waterIntake": waterValue.value,
            "stayUpLateFrequency": noneSleepValue.value
          },
          "foodPreferences": {
            "favoriteTypes": foodHabits.toList(),
            "others": null
          },
          "cookingPreferences": {
            "favoriteTypes": cookHabits.toList(),
            "others": null
          },
          "medicalHistory": {
            "pastDiseases": pastDiseases.toList(),
            "others": null
          },
          "familyHistory": {
            "pastDiseases": familyDiseases.toList(),
            "others": null
          },
          "allergies": {"drug": drugAllergies.toList(), "others": null}
        },
      };
      final res = await api.postJson(Api.updateUserProfile, params);
      LoadingHelper.hide();
      if (res.isNotEmpty) {
        var resBody = res['data'];
        if (resBody != null) {
          return true;
        } else {
          DialogHelper.showError("${res["message"]}");
        }
      }
    } catch (e) {
      LoadingHelper.hide();
      DialogHelper.showError("服務錯誤，請稍後再試");
    } finally {
      LoadingHelper.hide();
    }
    return false;
  }

  Future<bool> prossesSaveProfile() async {
    var res = await saveUserProfile();
    if (res) {
      if (avatarPath.value.isNotEmpty) {
        var imgPath = await uploadAvatar();
        if (imgPath.isNotEmpty) {
          var res = await updateUserProfile(imgPath);
          if (res) {
            Future.delayed(const Duration(milliseconds: 500), () {
              SnackbarHelper.showBlueSnackbar(
                  message: "snackbar_save_success".tr);
            });
            return true;
          }
        }
      } else {
        var res = await updateUserProfile('');
        if (res) {
          Future.delayed(const Duration(milliseconds: 500), () {
            SnackbarHelper.showBlueSnackbar(
                message: "snackbar_save_success".tr);
          });
          return true;
        }
      }
    }
    return false;
  }
}
