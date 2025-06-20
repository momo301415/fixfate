import 'package:pulsedevice/core/app_export.dart';

class FamilyItemModel {
  FamilyItemModel({
    this.two,
    this.tf,
    this.path,
    this.isAlert,
    this.familyId,
  }) {
    two = two ?? Rx("lbl204".tr);
    tf = tf ?? Rx("msg_2023_03_24".tr);
    path = path ?? Rx(ImageConstant.imgEllipse8296x96);
    isAlert = isAlert ?? Rx(false);
    familyId = familyId ?? Rx("");
  }

  Rx<String>? two;

  Rx<String>? tf;

  Rx<String>? path;

  Rx<bool>? isAlert;

  Rx<String>? familyId;
}
