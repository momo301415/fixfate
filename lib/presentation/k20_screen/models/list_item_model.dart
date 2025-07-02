import '../../../core/app_export.dart';

/// This class is used in the [list_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListItemModel {
  ListItemModel({this.two, this.id}) {
    two = two ?? Rx("lbl311".tr);
    id = id ?? Rx("");
  }

  Rx<String>? two;

  Rx<String>? id;
}
