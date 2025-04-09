import '../../../core/app_export.dart';

/// This class is used in the [chipview_two_item_widget] screen.

// ignore_for_file: must_be_immutable
class ChipviewTwoItemModel {
  ChipviewTwoItemModel({this.two, this.isSelected}) {
    two = two ?? Rx("lbl84".tr);
    isSelected = isSelected ?? Rx(false);
  }

  Rx<String>? two;

  Rx<bool>? isSelected;
}
