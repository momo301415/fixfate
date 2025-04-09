import '../../../core/app_export.dart';
import 'list_item_model.dart';

/// This class defines the variables used in the [k62_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class K62Model {
  Rx<List<ListItemModel>> listItemList = Rx([
    ListItemModel(
        tf: "lbl186".tr.obs,
        tenThousand: "lbl_10_000".tr.obs,
        tf1: "lbl187".tr.obs),
    ListItemModel(
        tf: "lbl188".tr.obs,
        tenThousand: "lbl_8_02".tr.obs,
        tf1: "lbl189".tr.obs),
    ListItemModel(
        tf: "lbl190".tr.obs,
        tenThousand: "lbl_2_500".tr.obs,
        tf1: "lbl191".tr.obs),
    ListItemModel(
        tf: "lbl192".tr.obs,
        tenThousand: "lbl_6_000".tr.obs,
        tf1: "lbl193".tr.obs)
  ]);
}
