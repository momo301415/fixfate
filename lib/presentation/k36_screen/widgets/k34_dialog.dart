import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pulsedevice/core/app_export.dart';
import 'package:pulsedevice/theme/app_decoration.dart';

// ignore_for_file: must_be_immutable
class K34DeleteDialog extends StatelessWidget {
  K34DeleteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // 模糊程度
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.h),

            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 50.h, vertical: 20.h),
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
                  margin: EdgeInsets.only(left: 10.h, right: 14.h),
                  child: Column(
                    children: [
                      Text(
                        "lbl430".tr,
                        style: CustomTextStyles
                            .titleMediumPrimaryContainerSemiBold,
                      ),
                      Text("lbl431".tr, style: CustomTextStyles.bodyMedium13),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.h),
                        child: Text(
                          "lbl432".tr,
                          style: CustomTextStyles.titleMediumGray500,
                        ),
                      ),
                      Text(
                        "lbl433".tr,
                        style: CustomTextStyles.titleMediumPrimarySemiBold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
