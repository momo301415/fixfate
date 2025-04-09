import '../../../core/app_export.dart';
import 'chipview_item_model.dart';
import 'chipview_one_item_model.dart';
import 'chipview_two_item_model.dart';

/// This class defines the variables used in the [k38_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class K38Model {
  Rx<List<ChipviewItemModel>> chipviewItemList = Rx([
    ChipviewItemModel(four: "lbl84".tr.obs),
    ChipviewItemModel(four: "lbl96".tr.obs),
    ChipviewItemModel(four: "lbl97".tr.obs),
    ChipviewItemModel(four: "lbl98".tr.obs),
    ChipviewItemModel(four: "lbl99".tr.obs),
    ChipviewItemModel(four: "lbl100".tr.obs),
    ChipviewItemModel(four: "lbl101".tr.obs),
    ChipviewItemModel(four: "lbl93".tr.obs)
  ]);

  Rx<List<ChipviewOneItemModel>> chipviewOneItemList = Rx([
    ChipviewOneItemModel(one: "lbl84".tr.obs),
    ChipviewOneItemModel(one: "lbl103".tr.obs),
    ChipviewOneItemModel(one: "lbl104".tr.obs),
    ChipviewOneItemModel(one: "lbl105".tr.obs),
    ChipviewOneItemModel(one: "lbl106".tr.obs),
    ChipviewOneItemModel(one: "lbl107".tr.obs),
    ChipviewOneItemModel(one: "lbl108".tr.obs),
    ChipviewOneItemModel(one: "lbl109".tr.obs),
    ChipviewOneItemModel(one: "lbl110".tr.obs),
    ChipviewOneItemModel(one: "lbl111".tr.obs),
    ChipviewOneItemModel(one: "lbl106".tr.obs),
    ChipviewOneItemModel(one: "lbl93".tr.obs)
  ]);

  Rx<List<ChipviewTwoItemModel>> chipviewTwoItemList = Rx([
    ChipviewTwoItemModel(two: "lbl84".tr.obs),
    ChipviewTwoItemModel(two: "lbl103".tr.obs),
    ChipviewTwoItemModel(two: "lbl104".tr.obs),
    ChipviewTwoItemModel(two: "lbl105".tr.obs),
    ChipviewTwoItemModel(two: "lbl106".tr.obs),
    ChipviewTwoItemModel(two: "lbl107".tr.obs),
    ChipviewTwoItemModel(two: "lbl108".tr.obs),
    ChipviewTwoItemModel(two: "lbl109".tr.obs),
    ChipviewTwoItemModel(two: "lbl110".tr.obs),
    ChipviewTwoItemModel(two: "lbl111".tr.obs),
    ChipviewTwoItemModel(two: "lbl93".tr.obs)
  ]);
}
