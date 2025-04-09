import '../../../core/app_export.dart';

/// This class is used in the [listtwentyfour_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListtwentyfourItemModel {
  ListtwentyfourItemModel({this.twentyfour, this.tf, this.tf1, this.id}) {
    twentyfour = twentyfour ?? Rx("lbl_52".tr);
    tf = tf ?? Rx("lbl161".tr);
    tf1 = tf1 ?? Rx("lbl246".tr);
    id = id ?? Rx("");
  }

  Rx<String>? twentyfour;

  Rx<String>? tf;

  Rx<String>? tf1;

  Rx<String>? id;
}
