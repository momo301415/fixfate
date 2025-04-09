import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_outlined_button.dart';
import 'controller/k45_controller.dart'; // ignore_for_file: must_be_immutable

class K45Screen extends GetWidget<K45Controller> {
  const K45Screen({Key? key})
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
            children: [
              _buildStackpulsering(),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.h,
                    vertical: 88.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Spacer(),
                      CustomOutlinedButton(
                        text: "lbl136".tr,
                        buttonStyle: CustomButtonStyles.outlinePrimary,
                        buttonTextStyle: CustomTextStyles.titleMediumPrimary,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStackpulsering() {
    return SizedBox(
      height: 334.h,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
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
          ),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 16.h),
            padding: EdgeInsets.only(top: 30.h),
            decoration: AppDecoration.fillWhiteA.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 18.h),
                CustomImageView(
                  imagePath: ImageConstant.imgFrame86618,
                  height: 84.h,
                  width: 122.h,
                ),
                SizedBox(height: 34.h),
                Text(
                  "lbl_pulsering3".tr,
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
