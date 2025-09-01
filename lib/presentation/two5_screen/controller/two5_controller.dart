import 'package:pulsedevice/core/global_controller.dart' show GlobalController;
import 'package:pulsedevice/core/hiveDb/blood_oxygen_setting.dart';
import 'package:pulsedevice/core/hiveDb/blood_oxygen_setting_storage.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';
import '../../../core/app_export.dart';
import '../models/two5_model.dart';

/// A controller class for the Two5Screen.
///
/// This class manages the state of the Two5Screen, including the
/// current two5ModelObj
class Two5Controller extends GetxController {
  Rx<Two5Model> two5ModelObj = Two5Model().obs;
  final gc = Get.find<GlobalController>();
  ApiService service = ApiService();
  final isSelectedSwitch = false.obs;
  // 血氧過低門檻
  var lowThreshold = 60.0.obs;
  late BloodOxygenSetting profile;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void saveData() async {
    profile = BloodOxygenSetting(
      lowThreshold: lowThreshold.value.toInt(),
      alertEnabled: isSelectedSwitch.value,
    );
    BloodOxygenSettingStorage.saveUserProfile(gc.userId.value, profile);
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
        "codeType": "oxygen",
        "userId": gc.apiId.value,
        "miniVal": lowThreshold.value,
        "maxVal": 0,
        "alert": isSelectedSwitch.value
      };
      var res = await service.postJson(
        Api.measurementSet,
        payload,
      );

      Get.back();
      if (res.isNotEmpty) {}
    } catch (e) {
      DialogHelper.showError("服務錯誤，請稍後再試");
    }
  }

  Future<void> gettingApi() async {
    LoadingHelper.show();
    try {
      final payload = {
        "codeType": "oxygen",
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
