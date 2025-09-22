import 'package:hive/hive.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/service/firebase_analytics_service.dart';
import 'package:pulsedevice/core/hiveDb/goal_profile.dart';
import 'package:pulsedevice/core/hiveDb/goal_profile_storage.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
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
  ApiService service = ApiService();
  var steps = 10000.0.obs;
  var sleepHours = 8.0.obs;
  var calories = 2500.0.obs;
  var distance = 6000.0.obs;
  var isEnableSteps = false.obs;
  var isEnablesleepHours = false.obs;
  var isEnablecalories = false.obs;
  var isEnabledistance = false.obs;

  // 目標類型常數定義
  static const String STEPS_CODE = "step";
  static const String SLEEP_CODE = "sleep";
  static const String CALORIES_CODE = "calories";
  static const String DISTANCE_CODE = "distance";

  @override
  void onInit() {
    super.onInit();

    // 📊 記錄目標設定頁面瀏覽事件
    FirebaseAnalyticsService.instance.logViewGoalPage();

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
        isEnable: isEnableSteps,
      ),
      ListItemModel(
        label: "lbl188".tr,
        value: sleepHours,
        min: 0.5,
        max: 12.0,
        division: 0.5,
        unit: "lbl189".tr,
        isEnable: isEnablesleepHours,
      ),
      ListItemModel(
        label: "lbl190".tr,
        value: calories,
        min: 1000,
        max: 4000,
        division: 100,
        unit: "lbl191".tr,
        isEnable: isEnablecalories,
      ),
      ListItemModel(
        label: "lbl192".tr,
        value: distance,
        min: 500,
        max: 8000,
        division: 500,
        unit: "lbl193".tr,
        isEnable: isEnabledistance,
      ),
    ];
  }

  Future<void> saveGoalProfile() async {
    // 📊 記錄設定目標按鈕點擊事件
    FirebaseAnalyticsService.instance.logClickSetGoal(
      goalType: 'multiple',
      goalValue: steps.value.toInt(),
    );

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
    for (int i = 0; i < k62ModelObj.value.listItemList.value.length; i++) {
      var dic = k62ModelObj.value.listItemList.value[i];
      switch (i) {
        case 0:
          user.isEnableSteps = dic.isEnable.value;
          isEnableSteps = dic.isEnable;
          break;
        case 1:
          user.isEnablesleepHours = dic.isEnable.value;
          isEnablesleepHours = dic.isEnable;
          break;
        case 2:
          user.isEnablecalories = dic.isEnable.value;
          isEnablecalories = dic.isEnable;
          break;
        case 3:
          user.isEnabledistance = dic.isEnable.value;
          isEnabledistance = dic.isEnable;
          break;
      }
    }

    // 保存到本地數據庫
    await GoalProfileStorage.saveUserProfile(gc.userId.value, user);

    // 批次發送所有目標設定到API
    await sendAllGoalsToApi();

    Get.back();
    SnackbarHelper.showBlueSnackbar(message: "目標設定成功".tr);
  }

  /// 批次發送所有目標設定到API
  Future<void> sendAllGoalsToApi() async {
    // 並行發送所有目標設定
    await Future.wait([
      settingApi(
        type: STEPS_CODE,
        val: steps.value.toInt().toString(),
        isAlert: isEnableSteps.value,
      ),
      settingApi(
        type: SLEEP_CODE,
        val: sleepHours.value.toString(),
        isAlert: isEnablesleepHours.value,
      ),
      settingApi(
        type: CALORIES_CODE,
        val: calories.value.toInt().toString(),
        isAlert: isEnablecalories.value,
      ),
      settingApi(
        type: DISTANCE_CODE,
        val: distance.value.toInt().toString(),
        isAlert: isEnabledistance.value,
      ),
    ]);
  }

  Future<void> loadGoalProfile() async {
    var user = await GoalProfileStorage.getUserProfile(gc.userId.value);
    if (user != null) {
      steps = user.steps!.toDouble().obs;
      sleepHours = user.sleepHours!.toDouble().obs;
      calories = user.calories!.toDouble().obs;
      distance = user.distance!.toDouble().obs;
      isEnableSteps = user.isEnableSteps!.obs;
      isEnablesleepHours = user.isEnablesleepHours!.obs;
      isEnablecalories = user.isEnablecalories!.obs;
      isEnabledistance = user.isEnabledistance!.obs;
    }
  }

  Future<void> settingApi({String? type, String? val, bool? isAlert}) async {
    try {
      final payload = {
        "codeType": type,
        "userId": gc.apiId.value,
        "maxVal": val,
        "alert": isAlert
      };
      var res = await service.postJson(
        Api.measurementSet,
        payload,
      );
      if (res.isNotEmpty) {}
    } catch (e) {}
  }
}
