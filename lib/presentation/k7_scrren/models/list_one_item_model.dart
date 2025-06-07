import '../../../core/app_export.dart';

/// This class is used in the [list_one_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListOneItemModel {
  ListOneItemModel({this.one, this.two, this.bpm, this.id}) {
    one = one ?? Rx(ImageConstant.imageNotFound);
    two = two ?? Rx("lbl260".tr);
    bpm = bpm ?? Rx("msg_2025_03_21_16_20".tr);
    id = id ?? Rx("");
  }
  Rx<String>? one;

  Rx<String>? two;

  Rx<String>? bpm;

  Rx<String>? id;
}
