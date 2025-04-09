import '../../../core/app_export.dart';

/// This class is used in the [chipview_item_widget] screen.

// ignore_for_file: must_be_immutable
class ChipviewItemModel {
  ChipviewItemModel({this.one, this.isSelected}) {
    one = one ?? Rx("lbl229".tr);
    isSelected = isSelected ?? Rx(false);
  }

  Rx<String>? one;

  Rx<bool>? isSelected;
}
