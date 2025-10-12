import '../../../core/app_export.dart';

/// This class is used in the [deviceselectiongrid_item_widget] screen.

// ignore_for_file: must_be_immutable
class DeviceselectiongridItemModel {
  DeviceselectiongridItemModel({this.pulsering, this.pulsering1, this.id}) {
    pulsering = pulsering ?? Rx(ImageConstant.imgFrame86618);
    pulsering1 = pulsering1 ?? Rx("msg_pulsering5".tr);
    id = id ?? Rx("");
  }

  Rx<String>? pulsering;

  Rx<String>? pulsering1;

  Rx<String>? id;
}
