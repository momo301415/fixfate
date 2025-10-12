import '../../../core/app_export.dart';

/// This class is used in the [listweightvalue_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListweightvalueItemModel {
  ListweightvalueItemModel({this.weightValue, this.one, this.one1, this.id}) {
    weightValue = weightValue ?? Rx("lbl_76_2".tr);
    one = one ?? Rx("lbl376".tr);
    one1 = one1 ?? Rx("lbl235".tr);
    id = id ?? Rx("");
  }

  Rx<String>? weightValue;

  Rx<String>? one;

  Rx<String>? one1;

  Rx<String>? id;
}
