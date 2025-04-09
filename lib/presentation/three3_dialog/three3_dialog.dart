import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/three3_controller.dart';

// ignore_for_file: must_be_immutable
class Three3Dialog extends StatelessWidget {
  Three3Dialog(this.controller, {Key? key})
      : super(
          key: key,
        );

  Three3Controller controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 50.h,
            vertical: 20.h,
          ),
          decoration: AppDecoration.outlineBlack.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder8,
          ),
          child: Column(
            spacing: 34,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 6.h),
              SizedBox(
                width: 140.h,
                child: Column(
                  children: [
                    Text(
                      "lbl139".tr,
                      style:
                          CustomTextStyles.titleMediumPrimaryContainerSemiBold,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "lbl212".tr,
                            style: CustomTextStyles.bodyMedium13_1,
                          ),
                          TextSpan(
                            text: "msg10".tr,
                            style: CustomTextStyles.bodyMedium13_1,
                          )
                        ],
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.h),
                      child: Text(
                        "lbl50".tr,
                        style: CustomTextStyles.titleMediumGray500,
                      ),
                    ),
                    Text(
                      "lbl140".tr,
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
