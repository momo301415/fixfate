import '../../../core/app_export.dart';
import 'list_one_item_model.dart';
import 'listview_item_model.dart';

/// This class is used in the [three_initial_page] screen.

// ignore_for_file: must_be_immutable
class ThreeInitialModel {
  Rx<List<ListOneItemModel>> listOneItemList = Rx([
    ListOneItemModel(two: "lbl227".tr.obs),
    ListOneItemModel(two: "lbl204".tr.obs),
    ListOneItemModel(two: "lbl205".tr.obs),
    ListOneItemModel(two: "lbl206".tr.obs),
    ListOneItemModel(two: "lbl206".tr.obs),
    ListOneItemModel(two: "lbl206".tr.obs)
  ]);

  Rx<List<ListviewItemModel>> listviewItemList = Rx([
    ListviewItemModel(
        one: ImageConstant.imgIconWhiteA700.obs,
        two: "lbl216".tr.obs,
        one1: "lbl_1".tr.obs,
        tf: "lbl173".tr.obs,
        six: "lbl_35_6".tr.obs,
        two1: ImageConstant.img16x12.obs,
        one2: ImageConstant.imgIcon1.obs,
        oneOne: "lbl_1".tr.obs,
        tf1: "lbl217".tr.obs,
        ninetyeight: "lbl_982".tr.obs,
        tf2: "lbl182".tr.obs),
    ListviewItemModel(
        one: ImageConstant.imgIconWhiteA70040x40.obs,
        oneOne: "lbl_1".tr.obs,
        tf1: "lbl219".tr.obs,
        ninetyeight: "lbl_8_22".tr.obs,
        tf2: "lbl189".tr.obs),
    ListviewItemModel(
        one: ImageConstant.imgFrame87029.obs,
        one2: ImageConstant.imgIcon40x40.obs,
        oneOne: "lbl_1".tr.obs)
  ]);
}
