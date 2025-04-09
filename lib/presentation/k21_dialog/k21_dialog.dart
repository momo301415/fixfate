import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k21_controller.dart';

// ignore_for_file: must_be_immutable
class K21Dialog extends StatelessWidget {
  K21Dialog(this.controller, {Key? key})
      : super(
          key: key,
        );

  K21Controller controller;

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
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 44.h),
                child: Column(
                  children: [
                    Text(
                      "lbl48".tr,
                      style: CustomTextStyles.titleMediumErrorContainerSemiBold,
                    ),
                    Text(
                      "lbl49".tr,
                      style: CustomTextStyles.bodyMediumGray50013,
                    )
                  ],
                ),
              ),
              SizedBox(height: 14.h),
              CustomElevatedButton(
                height: 40.h,
                text: "msg_datou1123_gmail_com".tr,
                buttonStyle: CustomButtonStyles.fillGray,
                buttonTextStyle: CustomTextStyles.bodyLargePrimaryContainer,
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
                      style: CustomTextStyles.titleMediumGray500,
                    ),
                    Text(
                      "lbl51".tr,
                      style: CustomTextStyles.titleMediumPrimarySemiBold,
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
