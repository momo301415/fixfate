import '../../../core/app_export.dart';
import 'gridview_item_model.dart';

/// This class defines the variables used in the [one11_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class One11Model {
  Rx<List<GridviewItemModel>> gridviewItemList = Rx([
    GridviewItemModel(
        one: ImageConstant.imgSolidHeartbeat.obs,
        one1: "lbl_1".tr.obs,
        tf: "lbl171".tr.obs,
        seventynine: "lbl_792".tr.obs,
        tf1: "lbl177".tr.obs),
    GridviewItemModel(
        one: ImageConstant.imgIcon.obs,
        tf: "lbl172".tr.obs,
        seventynine: "lbl_982".tr.obs,
        tf1: "lbl182".tr.obs),
    GridviewItemModel(
        one: ImageConstant.imgIconWhiteA700.obs,
        tf: "lbl173".tr.obs,
        seventynine: "lbl_35_6".tr.obs),
    GridviewItemModel(
        one: ImageConstant.imgIcon1.obs,
        one1: "lbl_1".tr.obs,
        tf: "lbl217".tr.obs,
        seventynine: "lbl_982".tr.obs,
        tf1: "lbl182".tr.obs),
    GridviewItemModel(
        one: ImageConstant.imgIconWhiteA70040x40.obs, one1: "lbl_1".tr.obs),
    GridviewItemModel(
        one: ImageConstant.imgFrame87029.obs, one1: "lbl_1".tr.obs),
    GridviewItemModel(
        one: ImageConstant.imgIcon40x40.obs, one1: "lbl_1".tr.obs),
    GridviewItemModel(
        one1: "lbl_1".tr.obs,
        tf: "lbl219".tr.obs,
        seventynine: "lbl_8_22".tr.obs,
        tf1: "lbl189".tr.obs),
    GridviewItemModel(),
    GridviewItemModel()
  ]);
}
