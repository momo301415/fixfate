import '../../../core/app_export.dart';
import 'list_item_model.dart';
import 'list_one1_item_model.dart';
import 'list_one_item_model.dart';

/// This class defines the variables used in the [k1_page],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class K6Model {
  Rx<List<ListOneItemModel>> listOneItemList = Rx([]);

  Rx<List<ListItemModel>> listItemList = Rx([
    ListItemModel(
      two: "lbl253".tr.obs,
      time: "lbl_16_30".tr.obs,
      m130kcaltwo: "lbl_2_344".tr.obs,
      m130kcaltwo1: "lbl193".tr.obs,
      m30kcaltwo2: "lbl_3122".tr.obs,
      m30kcaltwo3: "lbl191".tr.obs,
      m0kcaltwo4: "lbl_672".tr.obs,
      m0kcaltwo5: "lbl254".tr.obs,
    ),
    ListItemModel(),
  ]);

  Rx<List<ListOne1ItemModel>> listOne1ItemList = Rx([
    ListOne1ItemModel(
      one: ImageConstant.imgFrame86912.obs,
      two: "lbl253".tr.obs,
      time: "lbl_16_30".tr.obs,
      m130kcaltwo: "lbl_2_344".tr.obs,
      m130kcaltwo1: "lbl193".tr.obs,
      m30kcaltwo2: "lbl_3122".tr.obs,
      m30kcaltwo3: "lbl191".tr.obs,
      m0kcaltwo4: "lbl_672".tr.obs,
      m0kcaltwo5: "lbl254".tr.obs,
    ),
    ListOne1ItemModel(
      one: ImageConstant.imgFrame86911.obs,
      two: "lbl255".tr.obs,
      time: "lbl_16_30".tr.obs,
      m130kcaltwo: "lbl_2_344".tr.obs,
      m130kcaltwo1: "lbl193".tr.obs,
      m30kcaltwo2: "lbl_3122".tr.obs,
      m30kcaltwo3: "lbl191".tr.obs,
      m0kcaltwo4: "lbl_672".tr.obs,
      m0kcaltwo5: "lbl254".tr.obs,
    ),
    ListOne1ItemModel(),
  ]);
}
