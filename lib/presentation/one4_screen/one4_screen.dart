import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/one4_controller.dart'; // ignore_for_file: must_be_immutable

class One4Screen extends GetWidget<One4Controller> {
  const One4Screen({Key? key})
      : super(
          key: key,
        );

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
                              vertical: 56.h,
                            ),
                            decoration: AppDecoration.column26,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.h),
                                  child: Text(
                                    "lbl29".tr,
                                    style: CustomTextStyles.titleLarge20,
                                  ),
                                ),
                                Text(
                                  "lbl30".tr,
                                  style: CustomTextStyles.bodySmallBluegray400,
                                ),
                                SizedBox(height: 10.h)
                              ],
                            ),
                          ),
                          Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.h,
                              vertical: 32.h,
                            ),
                            decoration: AppDecoration.gray50.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder8,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildPulsering(),
                                _buildPulsering1(),
                                _buildHansaone(),
                                SizedBox(height: 60.h),
                                _buildTf(),
                                SizedBox(height: 22.h),
                                Text(
                                  "lbl32".tr,
                                  style: CustomTextStyles.bodyLargeBluegray400,
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
    );
  }

  /// Section Widget
  Widget _buildPulsering() {
    return CustomTextFormField(
      controller: controller.pulseringController,
      hintText: "lbl_pulsering".tr,
      hintStyle: CustomTextStyles.bodyLarge16,
      prefix: Container(
        margin: EdgeInsets.only(
          top: 18.h,
          right: 12.h,
          bottom: 18.h,
        ),
        child: CustomImageView(
          imagePath: ImageConstant.imgFrameErrorcontainer16x16,
          height: 16.h,
          width: 16.h,
          fit: BoxFit.contain,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 54.h,
      ),
      contentPadding: EdgeInsets.only(
        top: 14.h,
        right: 12.h,
        bottom: 14.h,
      ),
      borderDecoration: TextFormFieldStyleHelper.underLine,
      filled: false,
    );
  }

  /// Section Widget
  Widget _buildPulsering1() {
    return CustomTextFormField(
      controller: controller.pulsering1Controller,
      hintText: "lbl_pulsering".tr,
      hintStyle: CustomTextStyles.bodyLarge16,
      prefix: Container(
        margin: EdgeInsets.only(
          top: 18.h,
          right: 12.h,
          bottom: 18.h,
        ),
        child: CustomImageView(
          imagePath: ImageConstant.imgFrameErrorcontainer16x16,
          height: 16.h,
          width: 16.h,
          fit: BoxFit.contain,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 54.h,
      ),
      contentPadding: EdgeInsets.only(
        top: 14.h,
        right: 12.h,
        bottom: 14.h,
      ),
      borderDecoration: TextFormFieldStyleHelper.underLine,
      filled: false,
    );
  }

  /// Section Widget
  Widget _buildHansaone() {
    return CustomTextFormField(
      controller: controller.hansaoneController,
      hintText: "lbl_hansa".tr,
      hintStyle: CustomTextStyles.bodyLarge16,
      textInputAction: TextInputAction.done,
      prefix: Container(
        margin: EdgeInsets.only(
          top: 18.h,
          right: 12.h,
          bottom: 18.h,
        ),
        child: CustomImageView(
          imagePath: ImageConstant.imgFrameErrorcontainer16x16,
          height: 16.h,
          width: 16.h,
          fit: BoxFit.contain,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 54.h,
      ),
      contentPadding: EdgeInsets.only(
        top: 14.h,
        right: 12.h,
        bottom: 14.h,
      ),
      borderDecoration: TextFormFieldStyleHelper.underLine,
      filled: false,
    );
  }

  /// Section Widget
  Widget _buildTf() {
    return CustomElevatedButton(
      height: 58.h,
      text: "lbl31".tr,
      leftIcon: Container(
        margin: EdgeInsets.only(right: 10.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgFirotatecw,
          height: 16.h,
          width: 16.h,
          fit: BoxFit.contain,
        ),
      ),
      buttonStyle: CustomButtonStyles.none,
      decoration: CustomButtonStyles.gradientCyanToPrimaryDecoration,
    );
  }
}
