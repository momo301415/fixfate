import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/two4_controller.dart';

// ignore_for_file: must_be_immutable
class Two4Dialog extends StatelessWidget {
  Two4Dialog(this.controller, {Key? key})
      : super(
          key: key,
        );

  Two4Controller controller;

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
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 4.h),
                child: Column(
                  children: [
                    Text(
                      "lbl139".tr,
                      style:
                          CustomTextStyles.titleMediumPrimaryContainerSemiBold,
                    ),
                    Text(
                      "msg7".tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.bodyMedium13.copyWith(
                        height: 1.38,
                      ),
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
