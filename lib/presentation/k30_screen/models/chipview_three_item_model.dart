import '../../../core/app_export.dart';

/// This class is used in the [chipview_three_item_widget] screen.

// ignore_for_file: must_be_immutable
class ChipviewThreeItemModel {
  ChipviewThreeItemModel({this.three, this.isSelected}) {
    three = three ?? Rx("lbl84".tr);
    isSelected = isSelected ?? Rx(false);
  }

  Rx<String>? three;

  Rx<bool>? isSelected;
}
