import 'package:pulsedevice/core/global_controller.dart' show GlobalController;
import 'package:pulsedevice/core/hiveDb/blood_oxygen_setting.dart';
import 'package:pulsedevice/core/hiveDb/blood_oxygen_setting_storage.dart';
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
    YcProductPlugin()
        .setDeviceBloodOxygenAlarm(
      isEnable: isSelectedSwitch.value,
      minimum: lowThreshold.value.toInt(),
    )
        .then((value) {
      if (value?.statusCode == PluginState.succeed) {
        print("血氧設定成功！！！！！！！");
      } else {
        print("血氧設定失敗！ -> ${value?.statusCode} ; ");
      }
    });
    profile = BloodOxygenSetting(
      lowThreshold: lowThreshold.value.toInt(),
      alertEnabled: isSelectedSwitch.value,
    );
    BloodOxygenSettingStorage.saveUserProfile(gc.userId.value, profile);
  }

  void getData() async {
    var data = await BloodOxygenSettingStorage.getUserProfile(gc.userId.value);

    isSelectedSwitch.value = data?.alertEnabled ?? false;
    if (data != null) {
      lowThreshold.value = data.lowThreshold.toDouble();
      isSelectedSwitch.value = data.alertEnabled;
    }
  }
}
