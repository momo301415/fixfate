import '../../../core/app_export.dart';

/// This class is used in the [list_one_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListOneItemModel {
  ListOneItemModel({
    this.eleven,
    this.tf,
    this.two,
    this.kg,
    this.two1,
    this.id,
  }) {
    eleven = eleven ?? Rx("msg_2025_07_29_11_23".tr);
    tf = tf ?? Rx("lbl79".tr);
    two = two ?? Rx("lbl_68_22".tr);
    kg = kg ?? Rx("lbl_kg".tr);
    two1 = two1 ?? Rx("lbl444".tr);
    id = id ?? Rx("");
  }

  Rx<String>? eleven;

  Rx<String>? tf;

  Rx<String>? two;

  Rx<String>? kg;

  Rx<String>? two1;

  Rx<String>? id;
}
