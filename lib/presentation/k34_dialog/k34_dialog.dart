import 'package:flutter/material.dart';
import 'package:pulsedevice/core/utils/validation_functions.dart';
import 'package:pulsedevice/widgets/custom_text_form_field.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k34_controller.dart';

// ignore_for_file: must_be_immutable
/// 輸入email dialog
class K34Dialog extends StatelessWidget {
  K34Dialog(this.controller, {Key? key})
      : super(
          key: key,
        );

  K34Controller controller;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 22.h,
                vertical: 20.h,
              ),
              decoration: AppDecoration.outlineBlack.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 6.h),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(horizontal: 44.h),
                    child: Column(
                      children: [
                        Text(
                          "lbl48".tr,
                          style: CustomTextStyles
                              .titleMediumErrorContainerSemiBold,
                        ),
                        Text(
                          "lbl49".tr,
                          style: CustomTextStyles.bodyMediumGray50013,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),
                  CustomTextFormField(
                    controller: controller.inputController,
                    onChanged: (value) {
                      controller.inputedText.value = value;
                    },
                    hintText: "msg_sample_fixfate_com".tr,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.emailAddress,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.h,
                      vertical: 14.h,
                    ),
                    borderDecoration: TextFormFieldStyleHelper.fillGrayTL5,
                    fillColor: appTheme.gray300,
                    validator: (value) {
                      return validEmail(value);
                    },
                  ),
                  SizedBox(height: 26.h),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(horizontal: 42.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Text(
                              "lbl50".tr,
                              style: CustomTextStyles.titleMediumGray500,
                            )),
                        Obx(
                          () {
                            final isNotEmpty =
                                controller.inputedText.value.trim().isNotEmpty;
                            return GestureDetector(
                                onTap: () {
                                  if (isNotEmpty) {
                                    if (_formKey.currentState!.validate()) {
                                      Get.back(
                                          result:
                                              controller.inputController.text);
                                    }
                                  }
                                },
                                child: Text(
                                  "lbl51".tr,
                                  style: isNotEmpty
                                      ? CustomTextStyles
                                          .titleMediumPrimarySemiBold
                                      : CustomTextStyles.titleMediumGray500,
                                ));
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
