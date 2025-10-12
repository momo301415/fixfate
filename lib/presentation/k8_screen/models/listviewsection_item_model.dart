import '../../../core/app_export.dart';

/// This class is used in the [listviewsection_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListviewsectionItemModel {
  ListviewsectionItemModel({this.tf, this.nine, this.tf1, this.id}) {
    tf = tf ?? Rx("lbl409".tr);
    nine = nine ?? Rx("lbl_17_92".tr);
    tf1 = tf1 ?? Rx("lbl376".tr);
    id = id ?? Rx("");
  }

  Rx<String>? tf;

  Rx<String>? nine;

  Rx<String>? tf1;

  Rx<String>? id;
}
