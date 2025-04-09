import '../../../core/app_export.dart';

/// This class is used in the [listview_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListviewItemModel {
  ListviewItemModel(
      {this.one,
      this.two,
      this.one1,
      this.tf,
      this.six,
      this.two1,
      this.one2,
      this.oneOne,
      this.tf1,
      this.ninetyeight,
      this.tf2,
      this.id}) {
    one = one ?? Rx(ImageConstant.imgIconWhiteA700);
    two = two ?? Rx("lbl216".tr);
    one1 = one1 ?? Rx("lbl_1".tr);
    tf = tf ?? Rx("lbl173".tr);
    six = six ?? Rx("lbl_35_6".tr);
    two1 = two1 ?? Rx(ImageConstant.img16x12);
    one2 = one2 ?? Rx(ImageConstant.imgIcon1);
    oneOne = oneOne ?? Rx("lbl_1".tr);
    tf1 = tf1 ?? Rx("lbl217".tr);
    ninetyeight = ninetyeight ?? Rx("lbl_982".tr);
    tf2 = tf2 ?? Rx("lbl182".tr);
    id = id ?? Rx("");
  }

  Rx<String>? one;

  Rx<String>? two;

  Rx<String>? one1;

  Rx<String>? tf;

  Rx<String>? six;

  Rx<String>? two1;

  Rx<String>? one2;

  Rx<String>? oneOne;

  Rx<String>? tf1;

  Rx<String>? ninetyeight;

  Rx<String>? tf2;

  Rx<String>? id;
}
