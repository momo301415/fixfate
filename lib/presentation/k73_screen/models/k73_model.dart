import '../../../core/app_export.dart';
import 'listview_item_model.dart';

/// This class defines the variables used in the [k73_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class K73Model {
  Rx<List<ListViewItemModel>> listviewItemList = Rx([
    ListViewItemModel(
      icon: ImageConstant.imgSolidHeartbeat.obs,
      isAlert: false.obs,
      loadTime: "lbl_1".tr.obs,
      label: "lbl171".tr.obs,
      value: "lbl_792".tr.obs,
      unit: "lbl177".tr.obs,
    ),
    ListViewItemModel(
        icon: ImageConstant.imgIcon.obs,
        isAlert: false.obs,
        loadTime: "lbl_1".tr.obs,
        label: "lbl172".tr.obs,
        value: "lbl_982".tr.obs,
        unit: "lbl182".tr.obs),
    ListViewItemModel(
      icon: ImageConstant.imgIconWhiteA700.obs,
      isAlert: false.obs,
      loadTime: "lbl_1".tr.obs,
      label: "lbl173".tr.obs,
      value: "lbl_35_6".tr.obs,
      unit: "lbl_c".tr.obs,
    ),
    ListViewItemModel(
        icon: ImageConstant.imgIcon1.obs,
        isAlert: false.obs,
        label: "lbl217".tr.obs,
        loadTime: "lbl_1".tr.obs,
        value: "lbl_982".tr.obs,
        unit: "".obs),
    ListViewItemModel(
      icon: ImageConstant.imgIconWhiteA70040x40.obs,
      isAlert: false.obs,
      loadTime: "lbl_1".tr.obs,
      label: "lbl218".tr.obs,
      value: "lbl_6209".tr.obs,
      unit: "lbl187".tr.obs,
    ),
    ListViewItemModel(
        icon: ImageConstant.imgUnionWhiteA70024x36.obs,
        isAlert: false.obs,
        loadTime: "lbl_1".tr.obs,
        label: "lbl219".tr.obs,
        value: "lbl_8_22".tr.obs,
        unit: "lbl189".tr.obs),
    ListViewItemModel(
      icon: ImageConstant.imgFrame87029.obs,
      isAlert: false.obs,
      loadTime: "lbl_1".tr.obs,
      label: "lbl220".tr.obs,
      value: "lbl_200".tr.obs,
      unit: "lbl_kcal".tr.obs,
    ),
    ListViewItemModel(
        isAlert: false.obs,
        loadTime: "lbl_1".tr.obs,
        icon: ImageConstant.imgIcon40x40.obs,
        label: "lbl221".tr.obs,
        value: "lbl_7900".tr.obs,
        unit: "lbl193".tr.obs),
  ]);
}
