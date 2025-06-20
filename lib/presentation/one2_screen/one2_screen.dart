import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pulsedevice/core/utils/validation_functions.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/one2_controller.dart'; // ignore_for_file: must_be_immutable

/// 登入頁面
class One2Screen extends GetWidget<One2Controller> {
  One2Screen({Key? key})
      : super(
          key: key,
        );
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
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
                            decoration: AppDecoration.column14,
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
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "lbl14".tr,
                                    style:
                                        CustomTextStyles.bodyMediumBluegray900,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                _buildOne(),
                                SizedBox(height: 24.h),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "lbl15".tr,
                                    style:
                                        CustomTextStyles.bodyMediumBluegray900,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                _buildTf(),
                                SizedBox(height: 48.h),
                                _buildTf2(),
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
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              controller.goK14Screen();
                                            })
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
        )),
      ),
    );
  }

  Widget _buildOne() {
    return CustomTextFormField(
      controller: controller.oneController,
      onChanged: (value) {
        controller.checkFromIsNotEmpty();
      },
      hintText: "lbl_0912345678".tr,
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.phone,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 14.h,
      ),
      validator: (value) {
        if (!isValidPhone(value)) {
          return "err_msg_please_enter_valid_phone_number".tr;
        } else if (value == null || value.isEmpty) {
          return "err_msg_please_enter_phone_number".tr;
        }
        return null;
      },
    );
  }

  Widget _buildTf() {
    return Obx(() => CustomTextFormField(
          controller: controller.tfController,
          onChanged: (value) {
            controller.checkFromIsNotEmpty();
          },
          hintText: "lbl_82".tr,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 14.h,
          ),
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

  Widget _buildTf2() {
    return Obx(
      () {
        final isValid = controller.isValid.value;
        return CustomElevatedButton(
          height: 58.h,
          text: "lbl10".tr,
          buttonStyle:
              isValid ? CustomButtonStyles.none : CustomButtonStyles.fillTeal,
          decoration: isValid
              ? CustomButtonStyles.gradientCyanToPrimaryDecoration
              : null,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              var res = await controller.pressFetchLogin();
              if (res) {
                controller.goHomePage();
              }
            } else {}
          },
        );
      },
    );
  }
}
