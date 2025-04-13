import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/three_controller.dart';

// ignore_for_file: must_be_immutable
class ThreeDialog extends StatelessWidget {
  ThreeDialog(this.controller, {Key? key})
      : super(
          key: key,
        );

  ThreeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 234.h,
          padding: EdgeInsets.symmetric(vertical: 22.h),
          decoration: AppDecoration.gray100.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder8,
          ),
          child: Column(
            spacing: 28,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "lbl19".tr,
                style: CustomTextStyles.titleMediumPrimaryContainerSemiBold,
              ),
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    "lbl20".tr,
                    style: CustomTextStyles.titleMediumPrimarySemiBold,
                  ))
            ],
          ),
        )
      ],
    );
  }
}
