import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/k30_select_device_screen/controller/k30_select_device_controller.dart';
import '../../../core/app_export.dart';

import '../models/deviceselectiongrid_item_model.dart';

// ignore_for_file: must_be_immutable
class DeviceselectiongridItemWidget extends StatelessWidget {
  DeviceselectiongridItemWidget(
    this.deviceselectiongridItemModelObj, {
    Key? key,
  }) : super(key: key);

  DeviceselectiongridItemModel deviceselectiongridItemModelObj;

  var controller = Get.find<K30SelectDeviceController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => CustomImageView(
              imagePath: deviceselectiongridItemModelObj.pulsering!.value,
              height: 80.h,
              width: 82.h,
            ),
          ),
          Obx(
            () => Text(
              deviceselectiongridItemModelObj.pulsering1!.value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: CustomTextStyles.bodyLarge16,
            ),
          ),
          SizedBox(height: 14.h),
        ],
      ),
    );
  }
}
