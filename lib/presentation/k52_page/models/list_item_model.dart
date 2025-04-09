import '../../../core/app_export.dart';

/// This class is used in the [list_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListItemModel {
  ListItemModel({this.tf, this.tf1, this.id}) {
    tf = tf ?? Rx("lbl154".tr);
    tf1 = tf1 ?? Rx("msg_2023_3_23_14_32".tr);
    id = id ?? Rx("");
  }

  Rx<String>? tf;

  Rx<String>? tf1;

  Rx<String>? id;
}
