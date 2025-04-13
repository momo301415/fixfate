import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_pin_code_text_field.dart';
import 'controller/one3_controller.dart'; // ignore_for_file: must_be_immutable

/// 忘記密碼sms頁
class One3Screen extends GetWidget<One3Controller> {
  const One3Screen({Key? key})
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
                        imagePath: ImageConstant.imgUnionWhiteA700506x374,
                        height: 506.h,
                        width: double.maxFinite,
                      ),
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: 28.h),
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Column(
                          spacing: 44,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 182.h,
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.h,
                                vertical: 56.h,
                              ),
                              decoration: AppDecoration.column16,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 12.h),
                                    child: Text(
                                      "lbl21".tr,
                                      style: CustomTextStyles.titleLarge20,
                                    ),
                                  ),
                                  Text(
                                    "lbl22".tr,
                                    style:
                                        CustomTextStyles.bodySmallBluegray400,
                                  )
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
                onChanged: (value) {
                  controller.checkFromIsNotEmpty();
                },
              ),
            ),
          ),
          Obx(
            () => Text(
              "${controller.countdown.value}" + "lbl_60s".tr,
              style: CustomTextStyles.bodyMediumGray500,
            ),
          ),
          Obx(() {
            final isValid = controller.isValid.value;
            return CustomElevatedButton(
                height: 58.h,
                text: "lbl27".tr,
                buttonStyle: isValid
                    ? CustomButtonStyles.none
                    : CustomButtonStyles.fillTeal,
                decoration: isValid
                    ? CustomButtonStyles.gradientCyanToPrimaryDecoration
                    : null,
                onPressed: () {
                  if (!isValid) return;
                  controller.goTwo3Screen();
                });
          }),
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgArrowDown,
                    height: 16.h,
                    width: 16.h,
                  ),
                  Text(
                    "lbl42".tr,
                    style: theme.textTheme.bodyMedium,
                  )
                ],
              ))
        ],
      ),
    );
  }
}
