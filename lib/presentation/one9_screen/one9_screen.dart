import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/one9_controller.dart'; // ignore_for_file: must_be_immutable

class One9Screen extends GetWidget<One9Controller> {
  const One9Screen({Key? key})
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
                alignment: Alignment.topCenter,
                children: [
                  _buildStackunionone(),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(
                      left: 16.h,
                      top: 72.h,
                      right: 16.h,
                    ),
                    padding: EdgeInsets.all(36.h),
                    decoration: AppDecoration.fillWhiteA.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "lbl197".tr,
                          style: CustomTextStyles.bodyMediumBluegray900,
                        ),
                        SizedBox(height: 16.h),
                        _buildTf(),
                        SizedBox(height: 24.h),
                        Text(
                          "lbl198".tr,
                          style: CustomTextStyles.bodyMediumBluegray900,
                        ),
                        SizedBox(height: 16.h),
                        _buildTf1(),
                        SizedBox(height: 24.h),
                        Text(
                          "lbl199".tr,
                          style: CustomTextStyles.bodyMediumBluegray900,
                        ),
                        SizedBox(height: 16.h),
                        _buildTf2(),
                        SizedBox(height: 48.h),
                        _buildTf3()
                      ],
                    ),
                  )
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
                text: "lbl195".tr,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTf() {
    return CustomTextFormField(
      controller: controller.tfController,
      hintText: "lbl_82".tr,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 14.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildTf1() {
    return CustomTextFormField(
      controller: controller.tf1Controller,
      hintText: "lbl_82".tr,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 14.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildTf2() {
    return CustomTextFormField(
      controller: controller.tf2Controller,
      hintText: "lbl_82".tr,
      textInputAction: TextInputAction.done,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 14.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildTf3() {
    return CustomElevatedButton(
      height: 58.h,
      text: "lbl200".tr,
      buttonStyle: CustomButtonStyles.fillTeal,
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
