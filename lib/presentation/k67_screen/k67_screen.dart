import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import 'controller/k67_controller.dart'; // ignore_for_file: must_be_immutable

/// 家人管理頁面
class K67Screen extends GetWidget<K67Controller> {
  const K67Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      title: "lbl66".tr,
      child: Container(
        width: double.maxFinite,
        height: Get.height * 0.85,
        padding: EdgeInsets.symmetric(
          horizontal: 24.h,
          vertical: 44.h,
        ),
        child: Column(
          children: [
            SizedBox(height: 28.h),
            CustomImageView(
              imagePath: ImageConstant.imgBag,
              height: 82.h,
              width: 102.h,
            ),
            SizedBox(height: 22.h),
            Text(
              "lbl201".tr,
              style: CustomTextStyles.bodySmallPrimaryContainer,
            ),
            Spacer(),
            CustomElevatedButton(
              text: "lbl202".tr,
              buttonStyle: CustomButtonStyles.none,
              decoration: CustomButtonStyles.gradientCyanToPrimaryDecoration,
              onPressed: () {
                controller.go72Screen();
              },
            ),
            SizedBox(
              height: 16.h,
            ),
            CustomOutlinedButton(
              text: "lbl203".tr,
              margin: EdgeInsets.only(bottom: 12.h),
              buttonStyle: CustomButtonStyles.outlinePrimary,
              buttonTextStyle: CustomTextStyles.titleMediumPrimary,
              onPressed: () {
                controller.gok71Screen();
              },
            )
          ],
        ),
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
