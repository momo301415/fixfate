import '../../../core/app_export.dart';

/// This class is used in the [chipview_item_widget] screen.

// ignore_for_file: must_be_immutable
class ChipviewItemModel {
  ChipviewItemModel({this.five, this.isSelected}) {
    five = five ?? Rx("lbl84".tr);
    isSelected = isSelected ?? Rx(false);
  }

  Rx<String>? five;

  Rx<bool>? isSelected;
}
