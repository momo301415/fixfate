import '../../../core/app_export.dart';

/// This class is used in the [list_one1_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListOne1ItemModel {
  ListOne1ItemModel({
    this.one,
    this.two,
    this.time,
    this.m130kcaltwo,
    this.m130kcaltwo1,
    this.m30kcaltwo2,
    this.m30kcaltwo3,
    this.m0kcaltwo4,
    this.m0kcaltwo5,
    this.id,
  }) {
    one = one ?? Rx(ImageConstant.imgFrame86911);
    two = two ?? Rx("lbl255".tr);
    time = time ?? Rx("lbl_16_30".tr);
    m130kcaltwo = m130kcaltwo ?? Rx("lbl_2_344".tr);
    m130kcaltwo1 = m130kcaltwo1 ?? Rx("lbl193".tr);
    m30kcaltwo2 = m30kcaltwo2 ?? Rx("lbl_3122".tr);
    m30kcaltwo3 = m30kcaltwo3 ?? Rx("lbl191".tr);
    m0kcaltwo4 = m0kcaltwo4 ?? Rx("lbl_672".tr);
    m0kcaltwo5 = m0kcaltwo5 ?? Rx("lbl254".tr);
    id = id ?? Rx("");
  }

  Rx<String>? one;

  Rx<String>? two;

  Rx<String>? time;

  Rx<String>? m130kcaltwo;

  Rx<String>? m130kcaltwo1;

  Rx<String>? m30kcaltwo2;

  Rx<String>? m30kcaltwo3;

  Rx<String>? m0kcaltwo4;

  Rx<String>? m0kcaltwo5;

  Rx<String>? id;
}
