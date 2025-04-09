import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/two6_controller.dart';

// ignore_for_file: must_be_immutable
class Two6Screen extends GetWidget<Two6Controller> {
  Two6Screen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.teal50,
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                          _buildPassword(),
                          SizedBox(height: 24.h),
                          Text(
                            "lbl198".tr,
                            style: CustomTextStyles.bodyMediumBluegray900,
                          ),
                          SizedBox(height: 16.h),
                          _buildPasswordone(),
                          SizedBox(height: 24.h),
                          Text(
                            "lbl199".tr,
                            style: CustomTextStyles.bodyMediumBluegray900,
                          ),
                          SizedBox(height: 16.h),
                          _buildPasswordtwo(),
                          SizedBox(height: 48.h),
                          _buildTf()
                        ],
                      ),
                    )
                  ],
                ),
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
  Widget _buildPassword() {
    return CustomTextFormField(
      controller: controller.passwordController,
      hintText: "lbl18".tr,
      hintStyle: CustomTextStyles.bodyLarge16_1,
      textInputType: TextInputType.visiblePassword,
      obscureText: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 14.h,
      ),
      validator: (value) {
        if (value == null || (!isValidPassword(value, isRequired: true))) {
          return "err_msg_please_enter_valid_password".tr;
        }
        return null;
      },
    );
  }

  /// Section Widget
  Widget _buildPasswordone() {
    return CustomTextFormField(
      controller: controller.passwordoneController,
      hintText: "lbl18".tr,
      hintStyle: CustomTextStyles.bodyLarge16_1,
      textInputType: TextInputType.visiblePassword,
      obscureText: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 14.h,
      ),
      validator: (value) {
        if (value == null || (!isValidPassword(value, isRequired: true))) {
          return "err_msg_please_enter_valid_password".tr;
        }
        return null;
      },
    );
  }

  /// Section Widget
  Widget _buildPasswordtwo() {
    return CustomTextFormField(
      controller: controller.passwordtwoController,
      hintText: "lbl18".tr,
      hintStyle: CustomTextStyles.bodyLarge16_1,
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.visiblePassword,
      obscureText: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 14.h,
      ),
      validator: (value) {
        if (value == null || (!isValidPassword(value, isRequired: true))) {
          return "err_msg_please_enter_valid_password".tr;
        }
        return null;
      },
    );
  }

  /// Section Widget
  Widget _buildTf() {
    return CustomElevatedButton(
      height: 58.h,
      text: "lbl200".tr,
      buttonStyle: CustomButtonStyles.none,
      decoration: CustomButtonStyles.gradientCyanToPrimaryDecoration,
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
