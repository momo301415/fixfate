import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/k14_controller.dart';

// ignore_for_file: must_be_immutable
/// 忘記密碼頁
class K14Screen extends GetWidget<K14Controller> {
  K14Screen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          child: Form(
            key: _formKey,
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
                                    "lbl40".tr,
                                    style: CustomTextStyles.titleLarge20,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    "lbl41".tr,
                                    style:
                                        CustomTextStyles.bodySmallBluegray400,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        _buildColumnone(), // 你的表單區塊
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
  Widget _buildColumnone() {
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "lbl14".tr,
              style: CustomTextStyles.bodyMediumBluegray900,
            ),
          ),
          SizedBox(height: 16.h),
          _buildMobileNo(),
          SizedBox(height: 48.h),
          _buildSumbit(),
          SizedBox(height: 24.h),
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
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildMobileNo() {
    return CustomTextFormField(
      controller: controller.mobileNoController,
      onChanged: (value) {
        controller.checkFromIsNotEmpty();
      },
      hintText: "lbl_0934582915".tr,
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.phone,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 14.h,
      ),
      validator: (value) {
        if (!isValidPhone(value, isRequired: true)) {
          return "err_msg_please_enter_valid_phone_number".tr;
        }
        return null;
      },
    );
  }

  Widget _buildSumbit() {
    return Obx(() {
      final isValid = controller.isValid.value;
      return CustomElevatedButton(
        height: 58.h,
        text: "lbl17".tr,
        buttonStyle:
            isValid ? CustomButtonStyles.none : CustomButtonStyles.fillTeal,
        decoration:
            isValid ? CustomButtonStyles.gradientCyanToPrimaryDecoration : null,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            controller.goOne3Screen();
          } else {}
        },
      );
    });
  }
}
