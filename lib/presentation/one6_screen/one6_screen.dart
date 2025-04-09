import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_switch.dart';
import 'controller/one6_controller.dart'; // ignore_for_file: must_be_immutable

class One6Screen extends GetWidget<One6Controller> {
  const One6Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.teal50,
      body: SafeArea(
        child: Container(
          height: 796.h,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 796.h,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [_buildStackunionone(), _buildColumnone()],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStackunionone() {
    return Container(
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
                text: "lbl58".tr,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnone() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 16.h,
        top: 72.h,
        right: 16.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 4.h,
      ),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(24.h, 24.h, 24.h, 22.h),
            decoration: AppDecoration.outlineGray,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "lbl141".tr,
                  style: CustomTextStyles.bodyMediumBluegray900,
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
          ),
          Container(
            padding: EdgeInsets.fromLTRB(24.h, 24.h, 24.h, 22.h),
            decoration: AppDecoration.outlineGray,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "lbl142".tr,
                  style: CustomTextStyles.bodyMediumPrimaryContainer,
                ),
                Spacer(),
                Text(
                  "lbl143".tr,
                  style: CustomTextStyles.bodyMediumGray300,
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgArrowRightGray300,
                  height: 16.h,
                  width: 18.h,
                  margin: EdgeInsets.only(left: 8.h),
                )
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 24.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "lbl144".tr,
                  style: CustomTextStyles.bodyMediumPrimaryContainer,
                ),
                Spacer(),
                Text(
                  "lbl145".tr,
                  style: CustomTextStyles.bodyMediumGray300,
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgArrowRightGray300,
                  height: 16.h,
                  width: 18.h,
                  margin: EdgeInsets.only(left: 8.h),
                )
              ],
            ),
          ),
          SizedBox(height: 24.h)
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
