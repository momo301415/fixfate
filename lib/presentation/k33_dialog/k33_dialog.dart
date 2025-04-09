import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k33_controller.dart';

// ignore_for_file: must_be_immutable
class K33Dialog extends StatelessWidget {
  K33Dialog(this.controller, {Key? key})
      : super(
          key: key,
        );

  K33Controller controller;

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
              CustomElevatedButton(
                height: 40.h,
                text: "lbl129".tr,
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
