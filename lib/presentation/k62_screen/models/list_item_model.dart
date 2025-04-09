import '../../../core/app_export.dart';

/// This class is used in the [list_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListItemModel {
  ListItemModel({this.tf, this.tenThousand, this.tf1, this.id}) {
    tf = tf ?? Rx("lbl186".tr);
    tenThousand = tenThousand ?? Rx("lbl_10_000".tr);
    tf1 = tf1 ?? Rx("lbl187".tr);
    id = id ?? Rx("");
  }

  Rx<String>? tf;

  Rx<String>? tenThousand;

  Rx<String>? tf1;

  Rx<String>? id;
}
