import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:pulsedevice/core/app_export.dart';

/// This class is used in the [list_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListItemModel2 {
  ListItemModel2({this.tf, this.tf1, this.tf2}) {
    tf = tf ?? Rx("lbl163".tr);
    tf1 = tf1 ?? Rx(1);
    tf2 = tf2 ?? Rx(1.0);
  }

  Rx<String>? tf;

  Rx<int>? tf1;

  Rx<double>? tf2;
}
