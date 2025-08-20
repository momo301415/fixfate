import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/body_temperature_setting.dart';
import 'package:pulsedevice/core/hiveDb/body_temperature_setting_storage.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/core/utils/snackbar_helper.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';
import '../../../core/app_export.dart';
import '../models/k61_model.dart';

/// A controller class for the K61Screen.
///
/// This class manages the state of the K61Screen, including the
/// current k61ModelObj
class K61Controller extends GetxController {
  Rx<K61Model> k61ModelObj = K61Model().obs;
  final gc = Get.find<GlobalController>();
  ApiService service = ApiService();
  final isSelectedSwitch = false.obs;

  var highThreshold = 36.0.obs;
  var lowThreshold = 35.0.obs;
  late BodyTemperatureSetting profile;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void saveData() async {
    profile = BodyTemperatureSetting(
      highThreshold: "${highThreshold.value}",
      lowThreshold: "${lowThreshold.value}",
      alertEnabled: isSelectedSwitch.value,
    );
    BodyTemperatureSettingStorage.saveUserProfile(gc.userId.value, profile);
    await settingApi();
  }

  void getData() async {
    Future.delayed(const Duration(milliseconds: 100), () {
      gettingApi();
    });
  }

  Future<void> settingApi() async {
    try {
      final payload = {
        "codeType": "temperature",
        "userId": gc.apiId.value,
        "miniVal": lowThreshold.value,
        "maxVal": highThreshold.value,
        "alert": isSelectedSwitch.value
      };
      var res = await service.postJson(
        Api.measurementSet,
        payload,
      );

      Get.back();
      SnackbarHelper.showBlueSnackbar(message: "設定成功".tr);
      if (res.isNotEmpty) {}
    } catch (e) {
      DialogHelper.showError("服務錯誤，請稍後再試");
    }
  }

  Future<void> gettingApi() async {
    LoadingHelper.show();
    try {
      final payload = {
        "codeType": "temperature",
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

          if (data != null && data.length > 0) {
            lowThreshold.value = data["miniVal"].toDouble();
            highThreshold.value = data["maxVal"].toDouble();
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
