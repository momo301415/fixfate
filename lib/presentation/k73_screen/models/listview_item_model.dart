import '../../../core/app_export.dart';

/// This class is used in the [listview_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListviewItemModel {
  ListviewItemModel(
      {this.one,
      this.one1,
      this.tf,
      this.seventynine,
      this.tf1,
      this.three,
      this.tf2,
      this.oneOne,
      this.tf3,
      this.ninetyeight,
      this.tf4,
      this.id}) {
    one = one ?? Rx(ImageConstant.imgSolidHeartbeat);
    one1 = one1 ?? Rx("lbl_1".tr);
    tf = tf ?? Rx("lbl171".tr);
    seventynine = seventynine ?? Rx("lbl_792".tr);
    tf1 = tf1 ?? Rx("lbl177".tr);
    three = three ?? Rx(ImageConstant.imgIcon);
    tf2 = tf2 ?? Rx("lbl216".tr);
    oneOne = oneOne ?? Rx("lbl_1".tr);
    tf3 = tf3 ?? Rx("lbl172".tr);
    ninetyeight = ninetyeight ?? Rx("lbl_982".tr);
    tf4 = tf4 ?? Rx("lbl182".tr);
    id = id ?? Rx("");
  }

  Rx<String>? one;

  Rx<String>? one1;

  Rx<String>? tf;

  Rx<String>? seventynine;

  Rx<String>? tf1;

  Rx<String>? three;

  Rx<String>? tf2;

  Rx<String>? oneOne;

  Rx<String>? tf3;

  Rx<String>? ninetyeight;

  Rx<String>? tf4;

  Rx<String>? id;
}
