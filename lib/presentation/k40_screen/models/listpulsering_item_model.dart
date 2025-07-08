import '../../../core/app_export.dart';

/// This class is used in the [listpulsering_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListpulseringItemModel {
  ListpulseringItemModel(
      {this.pulsering, this.id, this.tf, this.pulsering1, this.power}) {
    pulsering = pulsering ?? Rx("lbl_pulsering3".tr);
    id = id ?? Rx("msg_id_86549685496894".tr);
    tf = tf ?? Rx("msg_2023_03_24".tr);
    pulsering1 = pulsering1 ?? Rx(ImageConstant.imgFrame86618);
    power = power ?? Rx("");
  }

  Rx<String>? pulsering;
  Rx<String>? id;

  Rx<String>? tf;

  Rx<String>? pulsering1;
  Rx<String>? power;
}
