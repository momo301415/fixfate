import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_switch.dart';
import 'controller/one5_controller.dart'; // ignore_for_file: must_be_immutable

class One5Screen extends GetWidget<One5Controller> {
  const One5Screen({Key? key})
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
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                spacing: 140,
                children: [
                  SizedBox(
                    height: 518.h,
                    width: double.maxFinite,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        _buildStackunionone(),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(
                            left: 14.h,
                            right: 6.h,
                          ),
                          child: Column(
                            spacing: 16,
                            mainAxisSize: MainAxisSize.min,
                            children: [_buildColumnoneone(), _buildColumn()],
                          ),
                        )
                      ],
                    ),
                  ),
                  CustomOutlinedButton(
                    text: "lbl136".tr,
                    margin: EdgeInsets.symmetric(horizontal: 24.h),
                    buttonStyle: CustomButtonStyles.outlinePrimary,
                    buttonTextStyle: CustomTextStyles.titleMediumPrimary,
                  ),
                  SizedBox(height: 44.h)
                ],
              ),
            ),
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
                  text: "lbl62".tr,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnoneone() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 8.h),
      padding: EdgeInsets.symmetric(vertical: 36.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10.h),
          CustomImageView(
            imagePath: ImageConstant.img1,
            height: 100.h,
            width: 60.h,
          ),
          SizedBox(height: 26.h),
          Text(
            "lbl_hansa".tr,
            style: CustomTextStyles.titleMediumManropePrimaryContainer,
          ),
          SizedBox(height: 16.h),
          Text(
            "msg_id_86549685496894".tr,
            style: CustomTextStyles.bodySmall10,
          ),
          Text(
            "msg_2023_03_242".tr,
            style: CustomTextStyles.bodySmall10,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumn() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 8.h),
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 4.h,
      ),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        spacing: 22,
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
                  "lbl137".tr,
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
          ),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 24.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "lbl138".tr,
                  style: CustomTextStyles.bodyLarge16,
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgArrowRightGray600,
                  height: 16.h,
                  width: 18.h,
                )
              ],
            ),
          ),
          SizedBox(height: 20.h)
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
