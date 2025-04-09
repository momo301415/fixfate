import '../../../core/app_export.dart';

/// This class is used in the [chipview_item_widget] screen.

// ignore_for_file: must_be_immutable
class ChipviewItemModel {
  ChipviewItemModel({this.four, this.isSelected}) {
    four = four ?? Rx("lbl84".tr);
    isSelected = isSelected ?? Rx(false);
  }

  Rx<String>? four;

  Rx<bool>? isSelected;
}
