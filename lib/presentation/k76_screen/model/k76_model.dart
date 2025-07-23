import 'package:get/get_utils/src/extensions/export.dart';
import 'package:get/state_manager.dart';
import 'package:pulsedevice/core/utils/image_constant.dart';
import 'package:pulsedevice/presentation/k76_screen/model/list_icon_bar_model.dart';

class K76Model {
  Rx<List<ListIconBarModel>> listIconBarModelObj = Rx([
    ListIconBarModel(
        icon: ImageConstant.solidHeartbeat.obs, label: "lbl171".tr.obs),
    // ListIconBarModel(
    //     icon: ImageConstant.solidBlood.obs, label: "lbl172_1".tr.obs),
    ListIconBarModel(
        icon: ImageConstant.solidTemp.obs, label: "lbl173_1".tr.obs),
    ListIconBarModel(
        icon: ImageConstant.solidPressure.obs, label: "lbl217".tr.obs),
    ListIconBarModel(icon: ImageConstant.solidStep.obs, label: "lbl218".tr.obs),
    ListIconBarModel(
        icon: ImageConstant.solidSleep.obs, label: "lbl219".tr.obs),
    ListIconBarModel(icon: ImageConstant.solidFire.obs, label: "lbl220".tr.obs),
    ListIconBarModel(
        icon: ImageConstant.solidDistance.obs, label: "lbl221_1".tr.obs),
  ]);
}
