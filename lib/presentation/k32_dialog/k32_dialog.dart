import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_text_form_field.dart';
import '../../core/app_export.dart';
import 'controller/k32_controller.dart';

// ignore_for_file: must_be_immutable
/// 輸入暱稱dialog
class K32Dialog extends StatelessWidget {
  K32Dialog(this.controller, {Key? key})
      : super(
          key: key,
        );

  K32Controller controller;

  @override
  Widget build(BuildContext context) {
    return Column(
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
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.h),
                    child: Text(
                      "lbl127".tr,
                      style: CustomTextStyles.titleMediumErrorContainerSemiBold,
                    ),
                  ),
                  Text(
                    "lbl_ai".tr,
                    style: CustomTextStyles.bodyMediumGray50013,
                  )
                ],
              ),
              SizedBox(height: 14.h),
              CustomTextFormField(
                controller: controller.inputController,
                onChanged: (value) {
                  controller.inputedText.value = value;
                },
                hintText: "lbl128".tr,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.text,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.h,
                  vertical: 14.h,
                ),
                borderDecoration: TextFormFieldStyleHelper.fillGrayTL5,
                fillColor: appTheme.gray300,
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
                                Get.back(
                                    result: controller.inputController.text);
                              }
                            },
                            child: Text(
                              "lbl51".tr,
                              style: isNotEmpty
                                  ? CustomTextStyles.titleMediumPrimarySemiBold
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
    );
  }
}
