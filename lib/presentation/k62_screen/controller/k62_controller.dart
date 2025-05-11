import 'package:hive/hive.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/goal_profile.dart';
import 'package:pulsedevice/core/hiveDb/goal_profile_storage.dart';
import 'package:pulsedevice/core/utils/snackbar_helper.dart';
import 'package:pulsedevice/presentation/k62_screen/models/list_item_model.dart';

import '../../../core/app_export.dart';
import '../models/k62_model.dart';

/// A controller class for the K62Screen.
///
/// This class manages the state of the K62Screen, including the
/// current k62ModelObj
class K62Controller extends GetxController {
  Rx<K62Model> k62ModelObj = K62Model().obs;
  final gc = Get.find<GlobalController>();
  var steps = 10000.0.obs;
  var sleepHours = 8.0.obs;
  var calories = 2500.0.obs;
  var distance = 6000.0.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void initData() async {
    await loadGoalProfile();
    k62ModelObj.value.listItemList.value = [
      ListItemModel(
        label: "lbl186".tr,
        value: steps,
        min: 1000,
        max: 30000,
        division: 1000,
        unit: "lbl187".tr,
      ),
      ListItemModel(
        label: "lbl188".tr,
        value: sleepHours,
        min: 0.5,
        max: 12.0,
        division: 0.5,
        unit: "lbl189".tr,
      ),
      ListItemModel(
        label: "lbl190".tr,
        value: calories,
        min: 1000,
        max: 4000,
        division: 100,
        unit: "lbl191".tr,
      ),
      ListItemModel(
        label: "lbl192".tr,
        value: distance,
        min: 500,
        max: 8000,
        division: 500,
        unit: "lbl193".tr,
      ),
    ];
  }

  Future<void> saveGoalProfile() async {
    final box = await Hive.openBox<GoalProfile>('goal_profile');
    final user = box.get(gc.userId.value) ?? GoalProfile();
    var a = k62ModelObj.value.listItemList.value[0];
    var b = k62ModelObj.value.listItemList.value[1];
    var c = k62ModelObj.value.listItemList.value[2];
    var d = k62ModelObj.value.listItemList.value[3];
    user.steps = a.value.toInt();
    user.sleepHours = b.value.toDouble();
    user.calories = c.value.toInt();
    user.distance = d.value.toInt();
    await GoalProfileStorage.saveUserProfile(gc.userId.value, user);
    Get.back();
    SnackbarHelper.showBlueSnackbar(message: "目標設定成功".tr);
  }

  Future<void> loadGoalProfile() async {
    var user = await GoalProfileStorage.getUserProfile(gc.userId.value);
    if (user != null) {
      steps = user.steps!.toDouble().obs;
      sleepHours = user.sleepHours!.toDouble().obs;
      calories = user.calories!.toDouble().obs;
      distance = user.distance!.toDouble().obs;
    }
  }
}
