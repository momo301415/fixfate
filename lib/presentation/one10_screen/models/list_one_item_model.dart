import '../../../core/app_export.dart';

/// This class is used in the [list_one_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListOneItemModel {
  ListOneItemModel({this.two, this.tf, this.id}) {
    two = two ?? Rx("lbl204".tr);
    tf = tf ?? Rx("msg_2023_03_24".tr);
    id = id ?? Rx("");
  }

  Rx<String>? two;

  Rx<String>? tf;

  Rx<String>? id;
}
