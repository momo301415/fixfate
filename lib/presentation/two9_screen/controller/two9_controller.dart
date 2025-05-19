import 'package:pulsedevice/core/global_controller.dart' show GlobalController;
import 'package:pulsedevice/core/hiveDb/pressure_setting.dart';
import 'package:pulsedevice/core/hiveDb/pressure_setting_storage.dart';
import 'package:pulsedevice/presentation/two9_screen/models/two9_model.dart';
import '../../../core/app_export.dart';

/// A controller class for the Two9Screen.
///
/// This class manages the state of the Two9Screen, including the
/// current Two9ModelObj
class Two9Controller extends GetxController {
  Rx<Two9Model> Two9ModelObj = Two9Model().obs;
  final gc = Get.find<GlobalController>();
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
    profile = PressureSetting(
      highThreshold: highThreshold.value.toInt(),
      alertEnabled: isSelectedSwitch.value,
    );
    PressureSettingStorage.saveUserProfile(gc.userId.value, profile);
  }

  void getData() async {
    var data = await PressureSettingStorage.getUserProfile(gc.userId.value);

    isSelectedSwitch.value = data?.alertEnabled ?? false;
    if (data != null) {
      highThreshold.value = data.highThreshold.toDouble();
      isSelectedSwitch.value = data.alertEnabled;
    }
  }
}
