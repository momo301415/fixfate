import '../../../core/app_export.dart';
import 'listview_item_model.dart';

/// This class defines the variables used in the [k73_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class K73Model {
  Rx<List<ListviewItemModel>> listviewItemList = Rx([
    ListviewItemModel(
        one: ImageConstant.imgSolidHeartbeat.obs,
        one1: "lbl_1".tr.obs,
        tf: "lbl171".tr.obs,
        seventynine: "lbl_792".tr.obs,
        tf1: "lbl177".tr.obs,
        three: ImageConstant.imgIcon.obs,
        tf2: "lbl216".tr.obs,
        oneOne: "lbl_1".tr.obs,
        tf3: "lbl172".tr.obs,
        ninetyeight: "lbl_982".tr.obs,
        tf4: "lbl182".tr.obs),
    ListviewItemModel(
        one: ImageConstant.imgIconWhiteA700.obs,
        tf: "lbl173".tr.obs,
        seventynine: "lbl_35_6".tr.obs,
        tf3: "lbl217".tr.obs,
        ninetyeight: "lbl_982".tr.obs,
        tf4: "lbl182".tr.obs),
    ListviewItemModel(
        one: ImageConstant.imgIconWhiteA70040x40.obs,
        one1: "lbl_1".tr.obs,
        tf3: "lbl219".tr.obs,
        ninetyeight: "lbl_8_22".tr.obs,
        tf4: "lbl189".tr.obs),
    ListviewItemModel(
        one: ImageConstant.imgFrame87029.obs,
        one1: "lbl_1".tr.obs,
        three: ImageConstant.imgIcon40x40.obs)
  ]);
}
