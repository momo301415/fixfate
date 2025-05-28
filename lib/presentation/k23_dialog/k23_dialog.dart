import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/k23_controller.dart';

// ignore_for_file: must_be_immutable
/// 身高dialog
class K23Dialog extends StatelessWidget {
  K23Dialog(this.controller, {Key? key})
      : super(
          key: key,
        );

  K23Controller controller;

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
              SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(horizontal: 30.h),
                          child: Column(
                            children: [
                              Text(
                                "lbl52".tr,
                                style: CustomTextStyles
                                    .titleMediumErrorContainerSemiBold,
                              ),
                              Text(
                                "lbl53".tr,
                                style: CustomTextStyles.bodyMediumGray50013,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 14.h),
                        CustomTextFormField(
                          controller: controller.inputlightoneController,
                          onChanged: (value) {
                            controller.inputedText.value = value;
                          },
                          hintText: "lbl54".tr,
                          hintStyle: CustomTextStyles.bodyLargeGray50016_1,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.number,
                          suffix: Padding(
                            padding: EdgeInsets.only(
                                left: 16.h, top: 6.h, bottom: 6.h, right: 8.h),
                            child: Text(
                              "lbl_cm".tr,
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
                                                .inputlightoneController.text);
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
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
