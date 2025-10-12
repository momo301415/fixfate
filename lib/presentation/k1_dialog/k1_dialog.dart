import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/k1_controller.dart';

// ignore_for_file: must_be_immutable
class K1Dialog extends StatelessWidget {
  K1Dialog(this.title,this.controller, {Key? key}) : super(key: key);

  String? title;
  K1Controller controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 22.h, vertical: 20.h),
          decoration: AppDecoration.outlineBlack.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 6.h),
              Text( "${title ?? "lbl407".tr}",
                style: CustomTextStyles.titleMediumErrorContainerSemiBold,
              ),
              SizedBox(height: 12.h),
              CustomTextFormField(
                textAlign: TextAlign.center, // 添加这一行
                controller: controller.inputlightoneController,
                onChanged: (value) {
                  controller.inputedText.value = value;
                },
                hintText: "lbl54".tr,
                hintStyle: CustomTextStyles.bodyLargeGray50016_1,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.number,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.h,
                  vertical: 6.h,
                ),
                borderDecoration:
                TextFormFieldStyleHelper.fillGrayTL5,
                fillColor: appTheme.gray300,
              ),
              SizedBox(height: 26.h),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 42.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        "lbl50".tr,
                        style: CustomTextStyles.titleMediumGray500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // 点击确认时，更新 K1Controller 的 number 值
                        if (controller.inputedText.value.trim().isNotEmpty) {
                          Get.back(result: controller.inputlightoneController.text);
                        }
                      },
                      child: Text(
                        "lbl51".tr,
                        style: CustomTextStyles.titleMediumPrimarySemiBold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
