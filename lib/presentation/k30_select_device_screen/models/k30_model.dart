import '../../../core/app_export.dart';
import 'deviceselectiongrid_item_model.dart';

/// This class defines the variables used in the [k30_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class K30Model {
  Rx<List<DeviceselectiongridItemModel>> deviceselectiongridItemList = Rx([
    DeviceselectiongridItemModel(
      pulsering: ImageConstant.imgFrame8661854x54.obs,
      pulsering1: "msg_pulsering5".tr.obs,
    ),
    DeviceselectiongridItemModel(
      pulsering: ImageConstant.imgFrame866181.obs,
      pulsering1: "lbl_scanfit2".tr.obs,
    ),
    DeviceselectiongridItemModel(
      pulsering: ImageConstant.imgFrame8661854x54.obs,
      pulsering1: "msg_pulsering5".tr.obs,
    ),
    DeviceselectiongridItemModel(
      pulsering: ImageConstant.imgFrame866181.obs,
      pulsering1: "lbl_scanfit2".tr.obs,
    ),
    DeviceselectiongridItemModel(
      pulsering: ImageConstant.imgFrame8661854x54.obs,
      pulsering1: "msg_pulsering5".tr.obs,
    ),
    DeviceselectiongridItemModel(
      pulsering: ImageConstant.imgFrame866181.obs,
      pulsering1: "lbl_scanfit2".tr.obs,
    ),
  ]);
}
