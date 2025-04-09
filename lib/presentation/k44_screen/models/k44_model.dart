import '../../../core/app_export.dart';
import 'listpulsering_item_model.dart';

/// This class defines the variables used in the [k44_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class K44Model {
  Rx<List<ListpulseringItemModel>> listpulseringItemList = Rx([
    ListpulseringItemModel(
        pulsering: "lbl_pulsering3".tr.obs,
        id: "msg_id_86549685496894".tr.obs,
        tf: "msg_2023_03_24".tr.obs,
        pulsering1: ImageConstant.imgFrame86618.obs),
    ListpulseringItemModel(
        pulsering: "lbl_hansa".tr.obs,
        id: "msg_id_86549685496894".tr.obs,
        tf: "msg_2023_03_24".tr.obs,
        pulsering1: ImageConstant.img1.obs),
    ListpulseringItemModel(
        pulsering: "lbl_pulsering3".tr.obs,
        id: "msg_id_86549685496894".tr.obs,
        tf: "msg_2023_03_24".tr.obs,
        pulsering1: ImageConstant.imgFrame86618.obs)
  ]);
}
