import '../../../core/app_export.dart';

/// This class is used in the [foodlistsection_item_widget] screen.

// ignore_for_file: must_be_immutable
class FoodlistsectionItemModel {
  FoodlistsectionItemModel({
    this.tf,
    this.tf1,
    this.one,
    this.tf2,
    this.zipcode,
    this.kcal,
    this.tf3,
    this.eightyThree,
    this.g,
    this.tf4,
    this.one1,
    this.gOne,
    this.tf5,
    this.two,
    this.gTwo,
    this.one2,
    this.three,
    this.id,
  }) {
    tf = tf ?? Rx(ImageConstant.imgFiRrUtensils);
    tf1 = tf1 ?? Rx("lbl337".tr);
    one = one ?? Rx("lbl_13".tr);
    tf2 = tf2 ?? Rx("lbl379".tr);
    zipcode = zipcode ?? Rx("lbl_1500".tr);
    kcal = kcal ?? Rx("lbl_kcal".tr);
    tf3 = tf3 ?? Rx("lbl339".tr);
    eightyThree = eightyThree ?? Rx("lbl_8_32".tr);
    g = g ?? Rx("lbl_g".tr);
    tf4 = tf4 ?? Rx("lbl340".tr);
    one1 = one1 ?? Rx("lbl_31_02".tr);
    gOne = gOne ?? Rx("lbl_g".tr);
    tf5 = tf5 ?? Rx("lbl341".tr);
    two = two ?? Rx("lbl_3_62".tr);
    gTwo = gTwo ?? Rx("lbl_g".tr);
    one2 = one2 ?? Rx("lbl342".tr);
    three = three ?? Rx("lbl_0_0".tr);
    id = id ?? Rx("");
  }

  Rx<String>? tf;

  Rx<String>? tf1;

  Rx<String>? one;

  Rx<String>? tf2;

  Rx<String>? zipcode;

  Rx<String>? kcal;

  Rx<String>? tf3;

  Rx<String>? eightyThree;

  Rx<String>? g;

  Rx<String>? tf4;

  Rx<String>? one1;

  Rx<String>? gOne;

  Rx<String>? tf5;

  Rx<String>? two;

  Rx<String>? gTwo;

  Rx<String>? one2;

  Rx<String>? three;

  Rx<String>? id;
}
