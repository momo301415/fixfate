import '../../../core/app_export.dart';
import 'chipview1_item_model.dart';
import 'chipview_item_model.dart';
import 'chipview_one_item_model.dart';
import 'list_item_model.dart';

/// This class defines the variables used in the [k39_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class K39Model {
  Rx<List<ListItemModel>> listItemList = Rx([
    ListItemModel(tf: "lbl75".tr.obs, tf1: "lbl54".tr.obs),
    ListItemModel(tf: "lbl76".tr.obs, tf1: "lbl77".tr.obs),
    ListItemModel(tf: "lbl78".tr.obs, tf1: "lbl_1985_03_14".tr.obs),
    ListItemModel(tf: "lbl79".tr.obs, tf1: "lbl_65_kg".tr.obs),
    ListItemModel(tf: "lbl80".tr.obs, tf1: "lbl_175_cm".tr.obs)
  ]);

  Rx<List<ChipviewItemModel>> chipviewItemList = Rx([
    ChipviewItemModel(two: "lbl84".tr.obs),
    ChipviewItemModel(two: "lbl85".tr.obs),
    ChipviewItemModel(two: "lbl86".tr.obs),
    ChipviewItemModel(two: "lbl87".tr.obs),
    ChipviewItemModel(two: "lbl88".tr.obs),
    ChipviewItemModel(two: "lbl89".tr.obs),
    ChipviewItemModel(two: "lbl90".tr.obs),
    ChipviewItemModel(two: "lbl91".tr.obs),
    ChipviewItemModel(two: "lbl92".tr.obs),
    ChipviewItemModel(two: "lbl93".tr.obs)
  ]);

  Rx<List<ChipviewOneItemModel>> chipviewOneItemList = Rx([
    ChipviewOneItemModel(one: "lbl84".tr.obs),
    ChipviewOneItemModel(one: "lbl96".tr.obs),
    ChipviewOneItemModel(one: "lbl97".tr.obs)
  ]);

  Rx<List<Chipview1ItemModel>> chipview1ItemList = Rx([
    Chipview1ItemModel(one: "lbl98".tr.obs),
    Chipview1ItemModel(one: "lbl99".tr.obs),
    Chipview1ItemModel(one: "lbl100".tr.obs),
    Chipview1ItemModel(one: "lbl101".tr.obs),
    Chipview1ItemModel(one: "lbl93".tr.obs)
  ]);
}
