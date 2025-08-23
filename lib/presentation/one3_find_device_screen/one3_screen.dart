import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/one3_find_device_screen/controller/one3_controller.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';

class One3FindDeviceScreen extends GetWidget<One3FindDeviceController> {
  const One3FindDeviceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
        title: "lbl421".tr,
        isShowBackButton: true,
        child: Column(
          children: [
             SizedBox(
            width: double.maxFinite,
            child: Column(
              spacing: 14,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "msg_scanfit".tr,
                  style: CustomTextStyles.bodySmallPrimaryContainer_1,
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgImage764,
                  height: 200.h,
                  width: 240.h,
                ),
                Text(
                  "msg42".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodySmallPrimaryContainer_1,
                ),
              ],
            ),
          ),
            _buildSearchingNearbyDevicesRow(),
          ],
        ));
  }

  /// Section Widget

  /// Section Widget
  Widget _buildSearchingNearbyDevicesRow() {
    return Container(
      margin: EdgeInsets.only(left: 12.h, right: 12.h,top: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 36.h),
      decoration: AppDecoration.gray50.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      width: double.maxFinite,
      child: Row(
        children: [
          AnimatedRotation(
            turns: 10,
            duration: Duration(milliseconds: 1500),
            child: CustomImageView(
              imagePath: ImageConstant.img11611,
              height: 16.h,
              width: 16.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              "lbl421".tr, 
              style: CustomTextStyles.labelLargePrimary_1,
            ),
          ),
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapImgArrowleftone() {
    Get.back();
  }
}
