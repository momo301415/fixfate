import 'package:pulsedevice/core/global_controller.dart' show GlobalController;
import 'package:pulsedevice/core/hiveDb/pressure_setting.dart';
import 'package:pulsedevice/core/hiveDb/pressure_setting_storage.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/presentation/two9_screen/models/two9_model.dart';
import '../../../core/app_export.dart';

/// A controller class for the Two9Screen.
///
/// This class manages the state of the Two9Screen, including the
/// current Two9ModelObj
class Two9Controller extends GetxController {
  Rx<Two9Model> Two9ModelObj = Two9Model().obs;
  final gc = Get.find<GlobalController>();
  ApiService service = ApiService();
  final isSelectedSwitch = false.obs;
  // 壓力過高門檻
  var highThreshold = 70.0.obs;
  late PressureSetting profile;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void saveData() async {
    if (isSelectedSwitch.value) {
      profile = PressureSetting(
        highThreshold: highThreshold.value.toInt(),
        alertEnabled: isSelectedSwitch.value,
      );
      PressureSettingStorage.saveUserProfile(gc.userId.value, profile);
      await settingApi();
    } else {
      Get.back();
    }
  }

  void getData() async {
    var data = await PressureSettingStorage.getUserProfile(gc.userId.value);

    isSelectedSwitch.value = data?.alertEnabled ?? false;
    if (data != null) {
      highThreshold.value = data.highThreshold.toDouble();
      isSelectedSwitch.value = data.alertEnabled;
    } else {
      await gettingApi();
    }
  }

  Future<void> settingApi() async {
    LoadingHelper.show();
    try {
      final payload = {
        "codeType": "pressure",
        "userId": gc.apiId.value,
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
        "codeType": "pressure",
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
