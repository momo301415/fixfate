import '../../../core/app_export.dart';

/// This class is used in the [list_one_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListOneItemModel {
  ListOneItemModel({this.one, this.two, this.id}) {
    one = one ?? Rx(ImageConstant.img102);
    two = two ?? Rx("lbl58".tr);
    id = id ?? Rx("");
  }

  Rx<String>? one;

  Rx<String>? two;

  Rx<String>? id;
}
