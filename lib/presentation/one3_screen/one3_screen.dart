import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                      // ✅ 調整後的圓圈背景與文字組件
                      Container(
                        // padding: EdgeInsets.only(right: 40.h),

                        width: 250.h,
                        height: 200.h, // 建議與 SVG 高度一致
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // 背景 SVG 圓圈往左偏移
                            Positioned(
                              left: 20.h,
                              child: SvgPicture.asset(
                                ImageConstant.imgUnionWhiteA700157x180,
                                height: 160.h,
                                width: 160.h,
                                fit: BoxFit.fill,
                              ),
                            ),
                            // 置中的文字
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "lbl21".tr,
                                  style: CustomTextStyles.titleLarge20,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "lbl22".tr,
                                  style: CustomTextStyles.bodySmallBluegray400,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      _buildColumn(), // 你的表單區塊
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
                  controller.fetchSmsVerify(
                      controller.phone, controller.otpController.value.text);
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
