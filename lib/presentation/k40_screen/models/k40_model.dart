import 'package:pulsedevice/presentation/k40_screen/models/listpulsering_item_model.dart';

import '../../../core/app_export.dart';

/// This class defines the variables used in the [k40_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class K40Model {
  // Rx<List<ListpulseringItemModel>> listpulseringItemList = Rx([]);
  //test
  Rx<List<ListpulseringItemModel>> listpulseringItemList = Rx([
    ListpulseringItemModel(
      pulsering: "lbl_pulsering3".tr.obs,
      id: "msg_id_86549685496894".tr.obs,
      tf: "msg_2023_03_24".tr.obs,
      pulsering1: ImageConstant.imgFrame8661854x54.obs,
      power: "lbl_80".tr.obs,
    ),
    ListpulseringItemModel(
      pulsering: "lbl_hansa".tr.obs,
      id: "lbl_hansa".tr.obs,
      tf: "msg_2023_03_24".tr.obs,
      pulsering1: ImageConstant.img1.obs,
      power: "lbl_80".tr.obs,
    ),
    ListpulseringItemModel(
      pulsering: "lbl_scanfit".tr.obs,
      id: "lbl_hansa".tr.obs,
      tf: "msg_2023_03_24".tr.obs,
      pulsering1: ImageConstant.imgFrame866181.obs,
      power: "lbl_80".tr.obs,
    )
  ]);
}
