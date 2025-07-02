import '../../../core/app_export.dart';

/// This class is used in the [list2_item_widget] screen.

// ignore_for_file: must_be_immutable
class List2ItemModel {
  List2ItemModel({this.tf, this.id}) {
    tf = tf ?? Rx("lbl315".tr);
    id = id ?? Rx("");
  }

  Rx<String>? tf;

  Rx<String>? id;
}
