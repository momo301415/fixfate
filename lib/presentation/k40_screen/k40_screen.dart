import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';

import '../../widgets/custom_elevated_button.dart';
import 'controller/k40_controller.dart'; // ignore_for_file: must_be_immutable

/// 我的設備頁面
class K40Screen extends GetWidget<K40Controller> {
  const K40Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    var mediaHeight = Get.height;
    return BaseScaffoldImageHeader(
      title: "lbl133".tr,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: double.infinity,
            child: CustomImageView(
              imagePath: ImageConstant.imgBag,
              height: 82.h,
              width: 102.h,
            ),
          ),

          SizedBox(height: 22.h),
          Text(
            "lbl134".tr,
            style: CustomTextStyles.bodySmallPrimaryContainer,
          ),
          // Spacer(),
          SizedBox(
            height: mediaHeight * 0.5,
          ),
          CustomElevatedButton(
            text: "lbl135".tr,
            buttonStyle: CustomButtonStyles.none,
            decoration: CustomButtonStyles.gradientCyanToPrimaryDecoration,
            onPressed: () {
              controller.goK10Screen();
            },
          ),
          SizedBox(height: 16.h)
        ],
      ),
    );
  }

  /// Section Widget

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
