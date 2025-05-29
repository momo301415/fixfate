import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/heart_rate_setting.dart';
import 'package:pulsedevice/core/hiveDb/heart_rate_setting_storage.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';

import '../../../core/app_export.dart';
import '../models/k58_model.dart';

/// A controller class for the K58Screen.
///
/// This class manages the state of the K58Screen, including the
/// current k58ModelObj
class K58Controller extends GetxController {
  Rx<K58Model> k58ModelObj = K58Model().obs;
  final gc = Get.find<GlobalController>();
  ApiService service = ApiService();
  final isSelectedSwitch = false.obs;
  // 心率過高／過低門檻
  var highThreshold = 80.0.obs;
  var lowThreshold = 70.0.obs;
  late HeartRateSetting profile;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void saveData() async {
    if (isSelectedSwitch.value) {
      YcProductPlugin()
          .setDeviceHeartRateAlarm(
              isEnable: isSelectedSwitch.value,
              maxHeartRate: highThreshold.value.toInt(),
              minHeartRate: lowThreshold.value.toInt())
          .then((value) {
        if (value?.statusCode == PluginState.succeed) {
          print("心率設定成功！！！！！！！");
        } else {
          print("心率設定失敗！ -> ${value?.statusCode} ; ");
        }
      });
      profile = HeartRateSetting(
        highThreshold: highThreshold.value.toInt(),
        lowThreshold: lowThreshold.value.toInt(),
        alertEnabled: isSelectedSwitch.value,
      );
      HeartRateSettingStorage.saveUserProfile(gc.userId.value, profile);
      settingApi();
    }
  }

  void getData() async {
    var data = await HeartRateSettingStorage.getUserProfile(gc.userId.value);

    ///如果db有資料
    if (data != null) {
      highThreshold.value = data.highThreshold.toDouble();
      lowThreshold.value = data.lowThreshold.toDouble();
      isSelectedSwitch.value = data.alertEnabled;
    } else {
      await gettingApi();
    }
  }

  Future<void> settingApi() async {
    LoadingHelper.show();
    try {
      final payload = {
        "codeType": "heartRate",
        "userId": gc.apiId.value,
        "miniVal": lowThreshold.value,
        "maxVal": highThreshold.value,
        "alert": isSelectedSwitch.value
      };
      var res = await service.postJson(
        Api.measurementSet,
        payload,
      );
      LoadingHelper.hide();
      if (res.isNotEmpty) {}
    } catch (e) {
      LoadingHelper.hide();
      DialogHelper.showError("服務錯誤，請稍後再試");
    }
  }

  Future<void> gettingApi() async {
    LoadingHelper.show();
    try {
      final payload = {
        "codeType": "heartRate",
        "userId": gc.apiId.value,
      };
      var res = await service.postJson(
        Api.measurementGet,
        payload,
      );
      LoadingHelper.hide();
      if (res.isNotEmpty) {
        final resMsg = res["message"];
        if (resMsg == "SUCCESS") {
          final data = res["data"];
          if (data != null) {
            highThreshold.value = data["maxVal"].toDouble();
            lowThreshold.value = data["miniVal"].toDouble();
            isSelectedSwitch.value = data["alert"];
          }
        }
      }
    } catch (e) {
      LoadingHelper.hide();
      DialogHelper.showError("服務錯誤，請稍後再試");
    }
  }
}
