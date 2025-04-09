import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/k50_controller.dart';

// ignore_for_file: must_be_immutable
class K50Bottomsheet extends StatelessWidget {
  K50Bottomsheet(this.controller, {Key? key})
      : super(
          key: key,
        );

  K50Controller controller;

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
            "lbl146".tr,
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 32.h),
          Text(
            "lbl147".tr,
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 32.h),
          Text(
            "lbl148".tr,
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 32.h),
          Text(
            "lbl149".tr,
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 32.h),
          Text(
            "lbl143".tr,
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 32.h),
          Text(
            "lbl150".tr,
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 32.h),
          Text(
            "lbl151".tr,
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
