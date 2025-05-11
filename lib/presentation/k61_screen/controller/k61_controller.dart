import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/body_temperature_setting.dart';
import 'package:pulsedevice/core/hiveDb/body_temperature_setting_storage.dart';
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
  final isSelectedSwitch = false.obs;

  var highThreshold = 36.0.obs;
  var lowThreshold = 33.0.obs;
  late BodyTemperatureSetting profile;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void saveData() async {
    YcProductPlugin()
        .setDeviceTemperatureAlarm(isSelectedSwitch.value,
            "${highThreshold.value}", "${lowThreshold.value}")
        .then((value) {
      if (value?.statusCode == PluginState.succeed) {
        print("體溫設定成功！！！！！！！");
      } else {
        print("體溫設定失敗！ -> ${value?.statusCode} ; ");
      }
    });
    profile = BodyTemperatureSetting(
      highThreshold: "${highThreshold.value}",
      lowThreshold: "${lowThreshold.value}",
      alertEnabled: isSelectedSwitch.value,
    );
    BodyTemperatureSettingStorage.saveUserProfile(gc.userId.value, profile);
  }

  void getData() async {
    var data =
        await BodyTemperatureSettingStorage.getUserProfile(gc.userId.value);
    if (data != null) {
      highThreshold.value = double.parse(data.highThreshold);
      lowThreshold.value = double.parse(data.lowThreshold);
      isSelectedSwitch.value = data.alertEnabled;
    }
  }
}
