import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/six_controller.dart';

// ignore_for_file: must_be_immutable
class SixDialog extends StatelessWidget {
  SixDialog(this.controller, {Key? key}) : super(key: key);

  SixController controller;

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
              Text(
                "lbl402".tr,
                style: CustomTextStyles.titleMediumErrorContainerSemiBold,
              ),
              SizedBox(height: 12.h),
              CustomTextFormField(
                controller: controller.inputKcalController,
                onChanged: (value) {
                  controller.inputedText.value = value;
                },
                hintText: "lbl_1500".tr,
                hintStyle: CustomTextStyles.bodyLargeGray50016_1,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.number,
                suffix: Padding(
                  padding: EdgeInsets.only(
                      left: 8.h, top: 6.h, bottom: 6.h, right: 8.h),
                  child: Text(
                    "lbl_kcal".tr,
                    style: TextStyle(
                      color: theme.colorScheme.errorContainer,
                      fontSize: 16.fSize,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                suffixConstraints: BoxConstraints(
                  maxHeight: 40.h,
                ),
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
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        "lbl50".tr,
                        style: CustomTextStyles.titleMediumGray500,
                      ),
                    ),
                    Obx(() {
                      final isNotEmpty = controller.inputedText.value
                          .trim()
                          .isNotEmpty;
                      return GestureDetector(
                          onTap: () {
                            if (isNotEmpty) {
                              Get.back(
                                  result: controller
                                      .inputKcalController.text);
                            }
                          },
                          child: Text(
                            "lbl51".tr,
                            style: isNotEmpty
                                ? CustomTextStyles
                                .titleMediumPrimarySemiBold
                                : CustomTextStyles.titleMediumGray500,
                          ));
                    }),

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
