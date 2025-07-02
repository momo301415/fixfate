import '../../../core/app_export.dart';

/// This class is used in the [list1_item_widget] screen.

// ignore_for_file: must_be_immutable
class List1ItemModel {
  List1ItemModel({this.two, this.id}) {
    two = two ?? Rx("lbl313".tr);
    id = id ?? Rx("");
  }

  Rx<String>? two;

  Rx<String>? id;
}
