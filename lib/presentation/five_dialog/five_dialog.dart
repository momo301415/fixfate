import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/five_controller.dart';

// ignore_for_file: must_be_immutable
class FiveDialog extends StatelessWidget {
  final String message;
  final VoidCallback? onOk;
  FiveDialog(this.controller, {Key? key, required this.message, this.onOk})
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
          width: 294.h,
          height: 134.h,
          padding: EdgeInsets.symmetric(vertical: 22.h),
          decoration: AppDecoration.gray100.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder8,
          ),
          child: Column(
            spacing: 28,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.h),
                child: Text(
                  message,
                  style: CustomTextStyles.titleMediumPrimaryContainerSemiBold,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: GestureDetector(
                  onTap: onOk ??
                      () {
                        Get.back();
                      },
                  child: Text(
                    "lbl20".tr,
                    style: CustomTextStyles.titleMediumPrimarySemiBold,
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
