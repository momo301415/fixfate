import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/two_controller.dart';

// ignore_for_file: must_be_immutable
class TwoScreen extends GetWidget<TwoController> {
  TwoScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.maxFinite,
        height: SizeUtils.height,
        decoration: AppDecoration.gradientLightBlueToOnErrorContainer,
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Container(
                  height: 768.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgUnionWhiteA700,
                        height: 506.h,
                        width: double.maxFinite,
                        alignment: Alignment.topCenter,
                      ),
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Column(
                          spacing: 32,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.all(30.h),
                              decoration: AppDecoration.column7,
                              child: Column(
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgMusic,
                                    height: 42.h,
                                    width: 44.h,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.h),
                                    child: Text(
                                      "lbl12".tr,
                                      style: CustomTextStyles.titleLarge20,
                                    ),
                                  ),
                                  Text(
                                    "lbl13".tr,
                                    style:
                                        CustomTextStyles.bodySmallBluegray400,
                                  ),
                                  SizedBox(height: 18.h)
                                ],
                              ),
                            ),
                            Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.h,
                                vertical: 36.h,
                              ),
                              decoration: AppDecoration.gray50.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder8,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "lbl14".tr,
                                    style:
                                        CustomTextStyles.bodyMediumBluegray900,
                                  ),
                                  SizedBox(height: 16.h),
                                  _buildMobileNo(),
                                  SizedBox(height: 24.h),
                                  Text(
                                    "lbl15".tr,
                                    style:
                                        CustomTextStyles.bodyMediumBluegray900,
                                  ),
                                  SizedBox(height: 16.h),
                                  _buildPassword(),
                                  SizedBox(height: 24.h),
                                  Text(
                                    "lbl16".tr,
                                    style:
                                        CustomTextStyles.bodyMediumBluegray900,
                                  ),
                                  SizedBox(height: 16.h),
                                  _buildPasswordone(),
                                  SizedBox(height: 48.h),
                                  _buildTf()
                                ],
                              ),
                            )
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
      ),
    );
  }

  /// Section Widget
  Widget _buildMobileNo() {
    return CustomTextFormField(
      controller: controller.mobileNoController,
      hintText: "lbl_0934582915".tr,
      textInputType: TextInputType.phone,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 14.h,
      ),
      validator: (value) {
        if (!isValidPhone(value)) {
          return "err_msg_please_enter_valid_phone_number".tr;
        }
        return null;
      },
    );
  }

  /// Section Widget
  Widget _buildPassword() {
    return CustomTextFormField(
      controller: controller.passwordController,
      hintText: "lbl18".tr,
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
      text: "lbl17".tr,
      buttonStyle: CustomButtonStyles.none,
      decoration: CustomButtonStyles.gradientCyanToPrimaryDecoration,
    );
  }
}
