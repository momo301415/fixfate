import '../../../core/app_export.dart';
import 'chipview_four_item_model.dart';
import 'chipview_item_model.dart';
import 'chipview_one_item_model.dart';
import 'chipview_three_item_model.dart';
import 'chipview_two_item_model.dart';
import 'list_item_model.dart';

/// This class defines the variables used in the [k30_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class K30Model {
  Rx<List<ListItemModel>> listItemList = Rx([
    ListItemModel(tf: "lbl74".tr.obs, tf1: "lbl54".tr.obs),
    ListItemModel(tf: "lbl75".tr.obs, tf1: "lbl54".tr.obs),
    ListItemModel(tf: "lbl76".tr.obs, tf1: "lbl77".tr.obs),
    ListItemModel(tf: "lbl78".tr.obs, tf1: "lbl_1985_03_14".tr.obs),
    ListItemModel(tf: "lbl79".tr.obs, tf1: "lbl_65_kg".tr.obs),
    ListItemModel(tf: "lbl80".tr.obs, tf1: "lbl_175_cm".tr.obs)
  ]);

  Rx<List<ListItemModel>> listItemList2 = Rx([
    ListItemModel(tf: "lbl300".tr.obs, tf1: "lbl300_1".tr.obs),
    ListItemModel(tf: "lbl301".tr.obs, tf1: "lbl301_1".tr.obs),
    ListItemModel(tf: "lbl302".tr.obs, tf1: "lbl299".tr.obs),
    ListItemModel(tf: "lbl303".tr.obs, tf1: "lbl303_1".tr.obs),
    ListItemModel(tf: "lbl304".tr.obs, tf1: "lbl303_1".tr.obs),
    ListItemModel(tf: "lbl305".tr.obs, tf1: "lbl303_1".tr.obs),
    ListItemModel(tf: "lbl306".tr.obs, tf1: "lbl306_3".tr.obs),
    ListItemModel(tf: "lbl307".tr.obs, tf1: "lbl307_1".tr.obs),
  ]);

  RxList<ChipviewItemModel> chipviewItemList = <ChipviewItemModel>[
    ChipviewItemModel(five: "lbl84".tr.obs),
    ChipviewItemModel(five: "lbl309".tr.obs),
    ChipviewItemModel(five: "lbl310".tr.obs),
    ChipviewItemModel(five: "lbl311".tr.obs),
    ChipviewItemModel(five: "lbl312".tr.obs),
    ChipviewItemModel(five: "lbl313".tr.obs),
    ChipviewItemModel(five: "lbl314".tr.obs),
    ChipviewItemModel(five: "lbl93".tr.obs)
  ].obs;

  RxList<ChipviewOneItemModel> chipviewOneItemList = <ChipviewOneItemModel>[
    ChipviewOneItemModel(one: "lbl84".tr.obs),
    ChipviewOneItemModel(one: "lbl316".tr.obs),
    ChipviewOneItemModel(one: "lbl317".tr.obs),
    ChipviewOneItemModel(one: "lbl318".tr.obs),
    ChipviewOneItemModel(one: "lbl319".tr.obs),
    ChipviewOneItemModel(one: "lbl320".tr.obs),
    ChipviewOneItemModel(one: "lbl321".tr.obs),
    ChipviewOneItemModel(one: "lbl322".tr.obs),
    ChipviewOneItemModel(one: "lbl93".tr.obs)
  ].obs;

  RxList<ChipviewTwoItemModel> chipviewTwoItemList = <ChipviewTwoItemModel>[
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
  ].obs;

  RxList<ChipviewThreeItemModel> chipviewThreeItemList =
      <ChipviewThreeItemModel>[
    ChipviewThreeItemModel(three: "lbl84".tr.obs),
    ChipviewThreeItemModel(three: "lbl103".tr.obs),
    ChipviewThreeItemModel(three: "lbl104".tr.obs),
    ChipviewThreeItemModel(three: "lbl105".tr.obs),
    ChipviewThreeItemModel(three: "lbl106".tr.obs),
    ChipviewThreeItemModel(three: "lbl107".tr.obs),
    ChipviewThreeItemModel(three: "lbl108".tr.obs),
    ChipviewThreeItemModel(three: "lbl109".tr.obs),
    ChipviewThreeItemModel(three: "lbl110".tr.obs),
    ChipviewThreeItemModel(three: "lbl111".tr.obs),
    ChipviewThreeItemModel(three: "lbl93".tr.obs)
  ].obs;

  RxList<ChipviewFourItemModel> chipviewFourItemList = <ChipviewFourItemModel>[
    ChipviewFourItemModel(four: "lbl84".tr.obs),
    ChipviewFourItemModel(four: "lbl115".tr.obs),
    ChipviewFourItemModel(four: "lbl116".tr.obs),
    ChipviewFourItemModel(four: "lbl117".tr.obs),
    ChipviewFourItemModel(four: "lbl118".tr.obs),
    ChipviewFourItemModel(four: "lbl119".tr.obs),
    ChipviewFourItemModel(four: "lbl_b1".tr.obs),
    ChipviewFourItemModel(four: "lbl120".tr.obs),
    ChipviewFourItemModel(four: "lbl121".tr.obs),
    ChipviewFourItemModel(four: "lbl122".tr.obs),
    ChipviewFourItemModel(four: "lbl93".tr.obs)
  ].obs;
}
