import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/one_controller.dart'; // ignore_for_file: must_be_immutable

class OneScreen extends GetWidget<OneController> {
  const OneScreen({Key? key})
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
                            decoration: AppDecoration.column5,
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
                                  style: CustomTextStyles.bodySmallBluegray400,
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
                                  style: CustomTextStyles.bodyMediumBluegray900,
                                ),
                                SizedBox(height: 16.h),
                                _buildOne(),
                                SizedBox(height: 24.h),
                                Text(
                                  "lbl15".tr,
                                  style: CustomTextStyles.bodyMediumBluegray900,
                                ),
                                SizedBox(height: 16.h),
                                _buildTf(),
                                SizedBox(height: 24.h),
                                Text(
                                  "lbl16".tr,
                                  style: CustomTextStyles.bodyMediumBluegray900,
                                ),
                                SizedBox(height: 16.h),
                                _buildTf1(),
                                SizedBox(height: 48.h),
                                _buildTf2()
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
  Widget _buildOne() {
    return CustomTextFormField(
      controller: controller.oneController,
      hintText: "lbl_0912345678".tr,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 14.h,
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
      textInputAction: TextInputAction.done,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 14.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildTf2() {
    return CustomElevatedButton(
      height: 58.h,
      text: "lbl17".tr,
      buttonStyle: CustomButtonStyles.fillTeal,
    );
  }
}
