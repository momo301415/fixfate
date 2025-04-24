import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/presentation/k50_bottomsheet/controller/k50_controller.dart';
import 'package:pulsedevice/presentation/k50_bottomsheet/k50_bottomsheet.dart';
import 'package:pulsedevice/presentation/k51_bottomsheet/controller/k51_controller.dart';
import 'package:pulsedevice/presentation/k51_bottomsheet/k51_bottomsheet.dart';
import '../../../core/app_export.dart';
import '../models/k48_model.dart';

/// A controller class for the K48Screen.
///
/// This class manages the state of the K48Screen, including the
/// current k48ModelObj
class K48Controller extends GetxController {
  Rx<K48Model> k48ModelObj = K48Model().obs;

  Rx<bool> isSelectedSwitch = false.obs;
  var alertTime = ''.obs;
  var eatTime = ''.obs;
  Future<void> selectAlertTime() async {
    final result = await DialogHelper.showCustomBottomSheet(
        Get.context!, K50Bottomsheet(Get.put(K50Controller())));
    if (result != null && result.isNotEmpty) {
      alertTime.value = result;
    }
  }

  Future<void> selectEatTime() async {
    final result = await DialogHelper.showCustomBottomSheet(
        Get.context!, K51Bottomsheet(Get.put(K51Controller())));
    if (result != null && result.isNotEmpty) {
      eatTime.value = result;
    }
  }
}
