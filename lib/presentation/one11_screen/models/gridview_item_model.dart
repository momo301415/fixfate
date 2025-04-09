import '../../../core/app_export.dart';

/// This class is used in the [gridview_item_widget] screen.

// ignore_for_file: must_be_immutable
class GridviewItemModel {
  GridviewItemModel(
      {this.one, this.one1, this.tf, this.seventynine, this.tf1, this.id}) {
    one = one ?? Rx(ImageConstant.imgSolidHeartbeat);
    one1 = one1 ?? Rx("lbl_1".tr);
    tf = tf ?? Rx("lbl171".tr);
    seventynine = seventynine ?? Rx("lbl_792".tr);
    tf1 = tf1 ?? Rx("lbl177".tr);
    id = id ?? Rx("");
  }

  Rx<String>? one;

  Rx<String>? one1;

  Rx<String>? tf;

  Rx<String>? seventynine;

  Rx<String>? tf1;

  Rx<String>? id;
}
