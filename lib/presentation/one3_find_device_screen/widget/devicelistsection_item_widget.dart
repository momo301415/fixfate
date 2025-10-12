import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/one3_find_device_screen/controller/one3_controller.dart';
import '../../../core/app_export.dart';
import '../models/devicelistsection_item_model.dart';

// ignore_for_file: must_be_immutable
class DevicelistsectionItemWidget extends StatelessWidget {
  DevicelistsectionItemWidget(this.devicelistsectionItemModelObj, {Key? key})
    : super(key: key);

  DevicelistsectionItemModel devicelistsectionItemModelObj;



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.h, bottom: 8.h),
      decoration: AppDecoration.outlineGray200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgFrameErrorcontainer1,
            height: 16.h,
            width: 16.h,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      devicelistsectionItemModelObj.pulsering!.value,
                      style: CustomTextStyles.bodyMedium15,
                    ),
                  ),
                  Obx(
                    () => Text(
                      devicelistsectionItemModelObj.d!.value,
                      style: CustomTextStyles.bodySmall11,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Obx(
              () => Text(
                devicelistsectionItemModelObj.two!.value,
                style: CustomTextStyles.labelMediumPrimarySemiBold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Obx(
              () => Text(
                devicelistsectionItemModelObj.one!.value,
                style: CustomTextStyles.labelMediumPrimarySemiBold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Obx(
              () => Text(
                devicelistsectionItemModelObj.m!.value,
                style: CustomTextStyles.labelMediumPrimarySemiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
