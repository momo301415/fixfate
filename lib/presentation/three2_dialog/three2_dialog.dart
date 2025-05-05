import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/three2_controller.dart';

// ignore_for_file: must_be_immutable
class Three2Dialog extends StatelessWidget {
  Three2Dialog(this.controller, {Key? key})
      : super(
          key: key,
        );

  Three2Controller controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 34.h,
            vertical: 20.h,
          ),
          decoration: AppDecoration.outlineBlack.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder8,
          ),
          child: Column(
            spacing: 32,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 6.h),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(right: 2.h),
                child: Column(
                  children: [
                    Text(
                      "lbl139".tr,
                      style:
                          CustomTextStyles.titleMediumPrimaryContainerSemiBold,
                    ),
                    Text(
                      "msg9".tr,
                      style: CustomTextStyles.bodyMedium13,
                    )
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 14.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.h),
                      child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Text(
                            "lbl50".tr,
                            style: CustomTextStyles.titleMediumGray500,
                          )),
                    ),
                    GestureDetector(
                        onTap: () async {
                          controller.deleteAccount();
                        },
                        child: Text(
                          "lbl140".tr,
                          style: CustomTextStyles.titleMediumPrimarySemiBold,
                        ))
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
