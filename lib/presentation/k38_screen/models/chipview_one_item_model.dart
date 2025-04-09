import '../../../core/app_export.dart';

/// This class is used in the [chipview_one_item_widget] screen.

// ignore_for_file: must_be_immutable
class ChipviewOneItemModel {
  ChipviewOneItemModel({this.one, this.isSelected}) {
    one = one ?? Rx("lbl84".tr);
    isSelected = isSelected ?? Rx(false);
  }

  Rx<String>? one;

  Rx<bool>? isSelected;
}
