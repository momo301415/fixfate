import '../../../core/app_export.dart';

/// This class is used in the [list_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListItemModel {
  ListItemModel({this.tf, this.id}) {
    tf = tf ?? Rx("lbl239".tr);
    id = id ?? Rx("");
  }

  Rx<String>? tf;

  Rx<String>? id;
}
