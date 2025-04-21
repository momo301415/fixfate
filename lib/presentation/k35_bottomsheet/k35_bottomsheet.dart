import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/k35_controller.dart';

// ignore_for_file: must_be_immutable
/// 選擇性別 Bottomsheet
class K35Bottomsheet extends StatelessWidget {
  K35Bottomsheet(this.controller, {Key? key})
      : super(
          key: key,
        );

  K35Controller controller;

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
          GestureDetector(
            onTap: () {
              Get.back(result: "lbl77".tr);
            },
            child: Text(
              "lbl77".tr,
              style: theme.textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 32.h),
          GestureDetector(
            onTap: () {
              Get.back(result: "lbl130".tr);
            },
            child: Text(
              "lbl130".tr,
              style: theme.textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: Divider(
              color: appTheme.gray200,
            ),
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Text(
              "lbl50".tr,
              style: CustomTextStyles.bodyLargeGray500_1,
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  /// Navigates to the k39Screen when the action is triggered.
  onTapTxtLabelthree() {
    Get.toNamed(
      AppRoutes.k39Screen,
    );
  }
}
