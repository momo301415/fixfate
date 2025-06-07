import '../../../core/app_export.dart';

/// This class is used in the [list_one_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListOneItemModel {
  ListOneItemModel({
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
    one = one ?? ImageConstant.imgFrame86912;
    two = two ?? "lbl253".tr;
    time = time ?? "lbl_16_30".tr;
    m130kcaltwo = m130kcaltwo ?? "lbl_2_344".tr;
    m130kcaltwo1 = m130kcaltwo1 ?? "lbl193".tr;
    m30kcaltwo2 = m30kcaltwo2 ?? "lbl_3122".tr;
    m30kcaltwo3 = m30kcaltwo3 ?? "lbl191".tr;
    m0kcaltwo4 = m0kcaltwo4 ?? "lbl_672".tr;
    m0kcaltwo5 = m0kcaltwo5 ?? "lbl254".tr;
    id = id ?? "";
  }

  String? one;

  String? two;

  String? time;

  String? m130kcaltwo;

  String? m130kcaltwo1;

  String? m30kcaltwo2;

  String? m30kcaltwo3;

  String? m0kcaltwo4;

  String? m0kcaltwo5;

  String? id;
}
