import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k72_controller.dart'; // ignore_for_file: must_be_immutable

class K72Screen extends GetWidget<K72Controller> {
  const K72Screen({Key? key})
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
            child: Container(
              height: 796.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 782.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgRectangle1404,
                          height: 782.h,
                          width: double.maxFinite,
                        ),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.h,
                            vertical: 104.h,
                          ),
                          decoration: AppDecoration.column31,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(height: 94.h),
                              CustomImageView(
                                imagePath: ImageConstant.imgFrame86948,
                                height: 240.h,
                                width: 240.h,
                              ),
                              Spacer(),
                              CustomElevatedButton(
                                text: "lbl215".tr,
                                margin: EdgeInsets.only(left: 16.h),
                                leftIcon: Container(
                                  margin: EdgeInsets.only(right: 10.h),
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgFi,
                                    height: 24.h,
                                    width: 24.h,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                buttonStyle: CustomButtonStyles.fillWhiteATL8,
                                buttonTextStyle: CustomTextStyles
                                    .titleMediumPrimaryContainer16,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  _buildStackunionone()
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
                leadingWidth: 56.h,
                leading: AppbarLeadingImage(
                  imagePath: ImageConstant.imgArrowLeft,
                  margin: EdgeInsets.only(left: 32.h),
                  onTap: () {
                    onTapArrowleftone();
                  },
                ),
                centerTitle: true,
                title: AppbarSubtitle(
                  text: "lbl202".tr,
                ),
                actions: [
                  AppbarTrailingImage(
                    imagePath: ImageConstant.imgUQrcodeScan,
                    margin: EdgeInsets.only(right: 31.h),
                  )
                ],
              ),
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
