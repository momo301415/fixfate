import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/k37_controller.dart';

// ignore_for_file: must_be_immutable
class K37Dialog extends StatelessWidget {
  K37Dialog(this.controller, {Key? key})
      : super(
          key: key,
        );

  K37Controller controller;

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
                                "lbl131".tr,
                                style: CustomTextStyles
                                    .titleMediumErrorContainerSemiBold,
                              ),
                              Text(
                                "lbl132".tr,
                                style: CustomTextStyles.bodyMediumGray50013,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 14.h),
                        CustomTextFormField(
                          controller: controller.inputlightoneController,
                          hintText: "lbl106".tr,
                          hintStyle: CustomTextStyles.bodyLargePrimaryContainer,
                          textInputAction: TextInputAction.done,
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
                              Text(
                                "lbl50".tr,
                                style: CustomTextStyles.titleMediumGray50001,
                              ),
                              Text(
                                "lbl51".tr,
                                style:
                                    CustomTextStyles.titleMediumPrimarySemiBold,
                              )
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
