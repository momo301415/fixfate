import '../../../core/app_export.dart';

/// This class is used in the [gridmonth_item_widget] screen.

// ignore_for_file: must_be_immutable
class GridmonthItemModel {
  GridmonthItemModel({this.month, this.id}) {
    month = month ?? Rx("lbl_2025".tr);
    id = id ?? Rx("");
  }

  Rx<String>? month;

  Rx<String>? id;
}
