import '../../../core/app_export.dart';
import 'gridmonth_item_model.dart';

/// This class defines the variables used in the [one7_bottomsheet],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class One7Model {
  Rx<List<GridmonthItemModel>> gridmonthItemList = Rx([
    GridmonthItemModel(month: "lbl_2025".tr.obs),
    GridmonthItemModel(month: "lbl_01".tr.obs),
    GridmonthItemModel(month: "lbl_02".tr.obs),
    GridmonthItemModel(month: "lbl_03".tr.obs),
    GridmonthItemModel(month: "lbl_04".tr.obs),
    GridmonthItemModel(month: "lbl_05".tr.obs),
    GridmonthItemModel(month: "lbl_06".tr.obs),
    GridmonthItemModel(month: "lbl_07".tr.obs),
    GridmonthItemModel(month: "lbl_08".tr.obs),
    GridmonthItemModel(month: "lbl_09".tr.obs),
    GridmonthItemModel(month: "lbl_103".tr.obs),
    GridmonthItemModel(month: "lbl_112".tr.obs),
    GridmonthItemModel(month: "lbl_122".tr.obs),
    GridmonthItemModel()
  ]);
}
