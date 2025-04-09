import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/k51_controller.dart';

// ignore_for_file: must_be_immutable
class K51Bottomsheet extends StatelessWidget {
  K51Bottomsheet(this.controller, {Key? key})
      : super(
          key: key,
        );

  K51Controller controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 40.h,
      ),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "lbl145".tr,
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 32.h),
          Text(
            "lbl152".tr,
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 32.h),
          Text(
            "lbl153".tr,
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: Divider(
              color: appTheme.gray200,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "lbl50".tr,
            style: CustomTextStyles.bodyLargeGray500_1,
          )
        ],
      ),
    );
  }
}
