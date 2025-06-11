import 'package:flutter/material.dart';
import 'package:pulsedevice/core/utils/validation_functions.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';

import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/one9_controller.dart'; // ignore_for_file: must_be_immutable

///修改密碼頁面
class One9Screen extends GetWidget<One9Controller> {
  One9Screen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
        title: "lbl195".tr,
        child: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(
              left: 8.h,
              top: 10.h,
              right: 8.h,
            ),
            padding: EdgeInsets.all(36.h),
            decoration: AppDecoration.fillWhiteA.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl197".tr,
                  style: CustomTextStyles.bodyMediumBluegray900,
                ),
                SizedBox(height: 16.h),
                _buildTf(),
                SizedBox(height: 24.h),
                Text(
                  "lbl198".tr,
                  style: CustomTextStyles.bodyMediumBluegray900,
                ),
                SizedBox(height: 16.h),
                _buildTf1(),
                SizedBox(height: 24.h),
                Text(
                  "lbl199".tr,
                  style: CustomTextStyles.bodyMediumBluegray900,
                ),
                SizedBox(height: 16.h),
                _buildTf2(),
                SizedBox(height: 48.h),
                _buildTf3()
              ],
            ),
          ),
        ));
  }

  /// Section Widget
  Widget _buildTf() {
    return Obx(() => CustomTextFormField(
          controller: controller.tfController,
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
  Widget _buildTf3() {
    return Obx(
      () {
        final isValid = controller.isValid.value;
        return CustomElevatedButton(
          height: 58.h,
          text: "lbl200".tr,
          buttonStyle:
              isValid ? CustomButtonStyles.none : CustomButtonStyles.fillTeal,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              controller.callApi();
            } else {}
          },
        );
      },
    );
  }

  Widget _buildTf1() {
    return Obx(() => CustomTextFormField(
          controller: controller.tf1Controller,
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
  Widget _buildTf2() {
    return Obx(() => CustomTextFormField(
          controller: controller.tf2Controller,
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
                controller.tf1Controller.text != value) {
              return "err_msg_please_enter_same_password".tr;
            }
            return null;
          },
        ));
  }
}
