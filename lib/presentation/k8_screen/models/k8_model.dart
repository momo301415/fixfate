import '../../../core/app_export.dart';
import 'listviewsection_item_model.dart';
import 'listweightvalue_item_model.dart';

/// This class defines the variables used in the [k8_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class K8Model {
  Rx<List<ListviewsectionItemModel>> listviewsectionItemList = Rx([
    ListviewsectionItemModel(
      tf: "lbl409".tr.obs,
      nine: "lbl_17_92".tr.obs,
      tf1: "lbl376".tr.obs,
    ),
    ListviewsectionItemModel(
      tf: "lbl410".tr.obs,
      nine: "lbl_43_4".tr.obs,
      tf1: "lbl376".tr.obs,
    ),
    ListviewsectionItemModel(
      tf: "lbl411".tr.obs,
      nine: "lbl_11_72".tr.obs,
      tf1: "lbl376".tr.obs,
    ),
    ListviewsectionItemModel(),
  ]);

  Rx<List<ListweightvalueItemModel>> listweightvalueItemList = Rx([
    ListweightvalueItemModel(
      weightValue: "lbl_76_2".tr.obs,
      one: "lbl376".tr.obs,
      one1: "lbl235".tr.obs,
    ),
    ListweightvalueItemModel(
      weightValue: "lbl_77_8".tr.obs,
      one: "lbl376".tr.obs,
      one1: "lbl236".tr.obs,
    ),
    ListweightvalueItemModel(
      weightValue: "lbl_75_9".tr.obs,
      one: "lbl376".tr.obs,
      one1: "lbl237".tr.obs,
    ),
  ]);
}
