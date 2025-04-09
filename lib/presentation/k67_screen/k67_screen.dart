import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import 'controller/k67_controller.dart'; // ignore_for_file: must_be_immutable

class K67Screen extends GetWidget<K67Controller> {
  const K67Screen({Key? key})
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
              _buildStackunionone(),
              Expanded(
                child: Container(
                  width: double.maxFinite,
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
                        decoration:
                            CustomButtonStyles.gradientCyanToPrimaryDecoration,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildColumn(),
    );
  }

  /// Section Widget
  Widget _buildStackunionone() {
    return SizedBox(
      height: 90.h,
      width: double.maxFinite,
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
                text: "lbl66".tr,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumn() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomOutlinedButton(
            text: "lbl203".tr,
            margin: EdgeInsets.only(bottom: 12.h),
            buttonStyle: CustomButtonStyles.outlinePrimary,
            buttonTextStyle: CustomTextStyles.titleMediumPrimary,
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
