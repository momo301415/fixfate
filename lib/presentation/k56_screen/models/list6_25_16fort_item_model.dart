import '../../../core/app_export.dart';

/// This class is used in the [list6_25_16fort_item_widget] screen.

// ignore_for_file: must_be_immutable
class List62516fortItemModel {
  List62516fortItemModel({this.appVar, this.tf, this.forty, this.id}) {
    appVar = appVar ?? Rx("lbl_app".tr);
    tf = tf ?? Rx("lbl166".tr);
    forty = forty ?? Rx("lbl_6_25_16_40".tr);
    id = id ?? Rx("");
  }

  Rx<String>? appVar;

  Rx<String>? tf;

  Rx<String>? forty;

  Rx<String>? id;
}
