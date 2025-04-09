import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/k20_controller.dart';

// ignore_for_file: must_be_immutable
class K20Dialog extends StatelessWidget {
  K20Dialog(this.controller, {Key? key})
      : super(
          key: key,
        );

  K20Controller controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 20.h),
          decoration: AppDecoration.outlineBlack.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder8,
          ),
          child: Column(
            spacing: 32,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 6.h),
              Column(
                children: [
                  Text(
                    "lbl45".tr,
                    style: CustomTextStyles.titleMediumPrimaryContainerSemiBold,
                  ),
                  Text(
                    "lbl46".tr,
                    style: CustomTextStyles.bodyMedium13,
                  )
                ],
              ),
              Text(
                "lbl47".tr,
                style: CustomTextStyles.titleMediumPrimarySemiBold,
              )
            ],
          ),
        )
      ],
    );
  }
}
