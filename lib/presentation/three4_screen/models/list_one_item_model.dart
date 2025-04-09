import '../../../core/app_export.dart';

/// This class is used in the [list_one_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListOneItemModel {
  ListOneItemModel({this.two, this.id}) {
    two = two ?? Rx("lbl227".tr);
    id = id ?? Rx("");
  }

  Rx<String>? two;

  Rx<String>? id;
}
