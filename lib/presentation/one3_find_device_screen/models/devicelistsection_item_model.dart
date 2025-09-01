import '../../../core/app_export.dart';

/// This class is used in the [devicelistsection_item_widget] screen.

// ignore_for_file: must_be_immutable
class DevicelistsectionItemModel {
  DevicelistsectionItemModel({
    this.pulsering,
    this.d,
    this.two,
    this.one,
    this.m,
    this.id,
  }) {
    pulsering = pulsering ?? Rx("msg_pulsering4".tr);
    d = d ?? Rx("msg_07_41_00_00_2d_fc".tr);
    two = two ?? Rx("lbl264".tr);
    one = one ?? Rx("lbl_0_12".tr);
    m = m ?? Rx("lbl_m".tr);
    id = id ?? Rx("");
  }

  Rx<String>? pulsering;

  Rx<String>? d;

  Rx<String>? two;

  Rx<String>? one;

  Rx<String>? m;

  Rx<String>? id;
}
