import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/two3_controller.dart';

// ignore_for_file: must_be_immutable
/// 重設密碼頁面
class Two3Screen extends GetWidget<Two3Controller> {
  Two3Screen({Key? key})
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
                          spacing: 44,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 182.h,
                              padding: EdgeInsets.symmetric(
                                horizontal: 38.h,
                                vertical: 56.h,
                              ),
                              decoration: AppDecoration.column18,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "lbl27".tr,
                                    style: CustomTextStyles.titleLarge20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10.h),
                                    child: Text(
                                      "lbl43".tr,
                                      style:
                                          CustomTextStyles.bodySmallBluegray400,
                                    ),
                                  )
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
                                    "lbl15".tr,
                                    style:
                                        CustomTextStyles.bodyMediumBluegray900,
                                  ),
                                  SizedBox(height: 16.h),
                                  _buildTf(),
                                  SizedBox(height: 24.h),
                                  Text(
                                    "lbl16".tr,
                                    style:
                                        CustomTextStyles.bodyMediumBluegray900,
                                  ),
                                  SizedBox(height: 16.h),
                                  _buildTf1(),
                                  SizedBox(height: 48.h),
                                  Obx(
                                    () {
                                      final isValid = controller.isValid.value;
                                      return CustomElevatedButton(
                                        height: 58.h,
                                        text: "lbl10".tr,
                                        buttonStyle: isValid
                                            ? CustomButtonStyles.none
                                            : CustomButtonStyles.fillTeal,
                                        decoration: isValid
                                            ? CustomButtonStyles
                                                .gradientCyanToPrimaryDecoration
                                            : null,
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            controller.callApi();
                                          }
                                        },
                                      );
                                    },
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

  Widget _buildTf() {
    return Obx(() => CustomTextFormField(
          controller: controller.passwordController,
          onChanged: (value) {
            controller.checkFromIsNotEmpty();
          },
          hintText: "lbl_82".tr,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 14.h,
          ),
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          obscureText: controller.isDisablePwd.value,
          suffix: GestureDetector(
            onTap: () {
              controller.isDisablePwd.value = !controller.isDisablePwd.value;
            },
            child: Padding(
              padding: EdgeInsets.only(right: 12.h),
              child: Icon(
                controller.isDisablePwd.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey,
                size: 20.h,
              ),
            ),
          ),
          validator: (value) {
            return validPassword(value);
          },
        ));
  }

  /// Section Widget
  Widget _buildTf1() {
    return Obx(() => CustomTextFormField(
          controller: controller.passwordoneController,
          onChanged: (value) {
            controller.checkFromIsNotEmpty();
          },
          hintText: "lbl_82".tr,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 14.h,
          ),
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          obscureText: controller.isDisablePwdConfirm.value,
          suffix: GestureDetector(
            onTap: () {
              controller.isDisablePwdConfirm.value =
                  !controller.isDisablePwdConfirm.value;
            },
            child: Padding(
              padding: EdgeInsets.only(right: 12.h),
              child: Icon(
                controller.isDisablePwdConfirm.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey,
                size: 20.h,
              ),
            ),
          ),
          validator: (value) {
            if (value == null ||
                value.isEmpty ||
                controller.passwordController.text != value) {
              return "err_msg_please_enter_same_password".tr;
            }
            return null;
          },
        ));
  }
}
