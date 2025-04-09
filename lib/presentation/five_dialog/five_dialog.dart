import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/five_controller.dart';

// ignore_for_file: must_be_immutable
class FiveDialog extends StatelessWidget {
  FiveDialog(this.controller, {Key? key})
      : super(
          key: key,
        );

  FiveController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 22.h),
          decoration: AppDecoration.gray100.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder8,
          ),
          child: Column(
            spacing: 28,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 6.h),
              Text(
                "lbl28".tr,
                style: CustomTextStyles.titleMediumPrimaryContainerSemiBold,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: Text(
                  "lbl20".tr,
                  style: CustomTextStyles.titleMediumPrimarySemiBold,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
