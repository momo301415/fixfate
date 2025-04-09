import '../../../core/app_export.dart';

/// This class is used in the [gridframe_item_widget] screen.

// ignore_for_file: must_be_immutable
class GridframeItemModel {
  GridframeItemModel({this.frame, this.id}) {
    frame = frame ?? Rx("lbl_01".tr);
    id = id ?? Rx("");
  }

  Rx<String>? frame;

  Rx<String>? id;
}
