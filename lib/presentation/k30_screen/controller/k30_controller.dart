import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/presentation/k31_bottomsheet/controller/k31_controller.dart';
import 'package:pulsedevice/presentation/k31_bottomsheet/k31_bottomsheet.dart';
import 'package:pulsedevice/presentation/k32_dialog/controller/k32_controller.dart';
import 'package:pulsedevice/presentation/k32_dialog/k32_dialog.dart';

import '../../../core/app_export.dart';
import '../models/k30_model.dart';

/// A controller class for the K30Screen.
///
/// This class manages the state of the K30Screen, including the
/// current k30ModelObj
class K30Controller extends GetxController {
  Rx<K30Model> k30ModelObj = K30Model().obs;
  var avatarPath = "".obs;
  var nickName = "".obs;

  Future<void> selectAvatar() async {
    final path = await DialogHelper.showCustomBottomSheet<String>(
      Get.context!,
      K31Bottomsheet(Get.put(K31Controller())),
    );

    if (path != null && path.isNotEmpty) {
      avatarPath.value = path;
    }
  }

  Future<void> showInputNickName() async {
    final result = await DialogHelper.showCustomDialog(
        Get.context!, K32Dialog(Get.put(K32Controller())));
    if (result != null && result.isNotEmpty) {
      nickName.value = result;
    }
  }
}
