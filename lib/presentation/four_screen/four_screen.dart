import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_pin_code_text_field.dart';
import 'controller/four_controller.dart'; // ignore_for_file: must_be_immutable

class FourScreen extends GetWidget<FourController> {
  const FourScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.maxFinite,
        height: SizeUtils.height,
        decoration: AppDecoration.gradientLightBlueToOnErrorContainer,
        child: SafeArea(
          child: Container(
            height: 768.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
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
                              decoration: AppDecoration.column9,
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.h),
                                    child: Text(
                                      "lbl21".tr,
                                      style: CustomTextStyles.titleLarge20,
                                    ),
                                  ),
                                  Text(
                                    "lbl22".tr,
                                    style:
                                        CustomTextStyles.bodySmallBluegray400,
                                  ),
                                  SizedBox(height: 10.h)
                                ],
                              ),
                            ),
                            _buildColumn()
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
    );
  }

  /// Section Widget
  Widget _buildColumn() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 24.h,
        vertical: 36.h,
      ),
      decoration: AppDecoration.gray50.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        spacing: 22,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "lbl23".tr,
              style: CustomTextStyles.bodyMedium15,
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: Obx(
              () => CustomPinCodeTextField(
                context: Get.context!,
                controller: controller.otpController.value,
                onChanged: (value) {},
              ),
            ),
          ),
          Obx(
            () => Text(
              "${controller.countdown}" + "lbl_60s".tr,
              style: CustomTextStyles.bodyMediumGray500,
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Obx(
                  () {
                    final isValid = controller.isReadPrivacyPolicy.value;
                    return isValid
                        ? CustomImageView(
                            imagePath: ImageConstant.imgUCheckCirclePrimary,
                            height: 16.h,
                            width: 16.h,
                          )
                        : CustomImageView(
                            imagePath: ImageConstant.imgUCheckCircle,
                            height: 16.h,
                            width: 16.h,
                          );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.h),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "lbl24".tr,
                          style: theme.textTheme.bodyMedium,
                        ),
                        TextSpan(
                            text: "lbl25".tr,
                            style: CustomTextStyles.bodyMediumPrimary,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                controller.goPravacyPolicyScreen();
                              })
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          ),
          CustomElevatedButton(
            height: 58.h,
            text: "lbl27".tr,
            buttonStyle: CustomButtonStyles.none,
            decoration: CustomButtonStyles.gradientCyanToPrimaryDecoration,
            onPressed: () {
              if (!controller.isReadPrivacyPolicy.value) {
                DialogHelper.showError("lbl28".tr);
              }
            },
          )
        ],
      ),
    );
  }
}
