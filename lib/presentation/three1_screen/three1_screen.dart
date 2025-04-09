import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/three1_controller.dart';

// ignore_for_file: must_be_immutable
class Three1Screen extends GetWidget<Three1Controller> {
  Three1Screen({Key? key})
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
                    alignment: Alignment.topCenter,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgUnionWhiteA700,
                        height: 506.h,
                        width: double.maxFinite,
                      ),
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: 28.h),
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Column(
                          spacing: 32,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.h,
                                vertical: 30.h,
                              ),
                              decoration: AppDecoration.column19,
                              child: Column(
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgMusic,
                                    height: 42.h,
                                    width: 44.h,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.h),
                                    child: Text(
                                      "lbl35".tr,
                                      style: CustomTextStyles.titleLarge20,
                                    ),
                                  ),
                                  Text(
                                    "lbl36".tr,
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
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "lbl14".tr,
                                      style: CustomTextStyles
                                          .bodyMediumBluegray900,
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  CustomTextFormField(
                                    controller: controller.mobileNoController,
                                    hintText: "lbl_0934582915".tr,
                                    textInputType: TextInputType.phone,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.h,
                                      vertical: 14.h,
                                    ),
                                    validator: (value) {
                                      if (!isValidPhone(value)) {
                                        return "err_msg_please_enter_valid_phone_number"
                                            .tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 24.h),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "lbl15".tr,
                                      style: CustomTextStyles
                                          .bodyMediumBluegray900,
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  CustomTextFormField(
                                    controller: controller.passwordController,
                                    hintText: "lbl18".tr,
                                    textInputAction: TextInputAction.done,
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    obscureText: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.h,
                                      vertical: 14.h,
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          (!isValidPassword(value,
                                              isRequired: true))) {
                                        return "err_msg_please_enter_valid_password"
                                            .tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 48.h),
                                  CustomElevatedButton(
                                    height: 58.h,
                                    text: "lbl10".tr,
                                    buttonStyle: CustomButtonStyles.none,
                                    decoration: CustomButtonStyles
                                        .gradientCyanToPrimaryDecoration,
                                  ),
                                  SizedBox(height: 24.h),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "lbl37".tr,
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                        TextSpan(
                                          text: "lbl38".tr,
                                          style: CustomTextStyles
                                              .bodyMediumPrimary,
                                        )
                                      ],
                                    ),
                                    textAlign: TextAlign.left,
                                  )
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
}
