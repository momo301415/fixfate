import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_switch.dart';
import 'controller/two7_controller.dart'; // ignore_for_file: must_be_immutable

class Two7Screen extends GetWidget<Two7Controller> {
  const Two7Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.teal50,
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 430.h,
                width: double.maxFinite,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [_buildStackunionone(), _buildColumnone()],
                ),
              ),
              Spacer(),
              CustomOutlinedButton(
                text: "lbl211".tr,
                margin: EdgeInsets.symmetric(horizontal: 24.h),
                buttonStyle: CustomButtonStyles.outlinePrimary,
                buttonTextStyle: CustomTextStyles.titleMediumPrimary,
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStackunionone() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 90.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgUnion90x374,
              height: 90.h,
              width: double.maxFinite,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: CustomAppBar(
                leadingWidth: 55.h,
                leading: AppbarLeadingImage(
                  imagePath: ImageConstant.imgArrowLeft,
                  margin: EdgeInsets.only(left: 31.h),
                  onTap: () {
                    onTapArrowleftone();
                  },
                ),
                centerTitle: true,
                title: AppbarSubtitle(
                  text: "lbl209".tr,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnone() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 14.h,
        right: 6.h,
      ),
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(right: 8.h),
            padding: EdgeInsets.symmetric(vertical: 48.h),
            decoration: AppDecoration.fillWhiteA.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder24,
            ),
            child: Column(
              spacing: 16,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgEllipse8296x96,
                  height: 96.h,
                  width: 98.h,
                  radius: BorderRadius.circular(
                    48.h,
                  ),
                ),
                Text(
                  "lbl204".tr,
                  style: CustomTextStyles.titleMediumManropePrimaryContainer,
                ),
                Text(
                  "msg_2023_03_24".tr,
                  style: CustomTextStyles.bodySmall10,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 8.h),
            padding: EdgeInsets.symmetric(
              horizontal: 32.h,
              vertical: 28.h,
            ),
            decoration: AppDecoration.fillWhiteA.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder24,
            ),
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "lbl210".tr,
                  style: CustomTextStyles.bodyLarge16,
                ),
                Obx(
                  () => CustomSwitch(
                    value: controller.isSelectedSwitch.value,
                    onChange: (value) {
                      controller.isSelectedSwitch.value = value;
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
