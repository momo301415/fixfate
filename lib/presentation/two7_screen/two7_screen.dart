import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';

import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_switch.dart';
import 'controller/two7_controller.dart'; // ignore_for_file: must_be_immutable

/// 家人設定頁面
class Two7Screen extends GetWidget<Two7Controller> {
  const Two7Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
        title: "lbl209".tr,
        child: _buildColumnone(),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
            child: CustomOutlinedButton(
              text: "lbl211".tr,
              margin: EdgeInsets.symmetric(horizontal: 24.h),
              buttonStyle: CustomButtonStyles.outlinePrimary,
              buttonTextStyle: CustomTextStyles.titleMediumPrimary,
              onPressed: () {
                controller.showDelete();
              },
            ),
          ),
        ));
  }

  /// Section Widget
  Widget _buildColumnone() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 14.h,
        right: 6.h,
      ),
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(right: 8.h),
            padding: EdgeInsets.symmetric(vertical: 48.h),
            decoration: AppDecoration.fillWhiteA.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder24,
            ),
            child: Column(
              spacing: 16,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImageView(
                  imagePath: controller.model.path?.value,
                  height: 100.h,
                  width: 100.h,
                  fit: BoxFit.cover,
                  radius: BorderRadius.circular(
                    48.h,
                  ),
                ),
                Text(
                  controller.model.two!.value,
                  style: CustomTextStyles.titleMediumManropePrimaryContainer,
                ),
                Text(
                  controller.model.tf!.value,
                  style: CustomTextStyles.bodySmall10,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 8.h),
            padding: EdgeInsets.symmetric(
              horizontal: 32.h,
              vertical: 28.h,
            ),
            decoration: AppDecoration.fillWhiteA.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder24,
            ),
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "lbl210".tr,
                  style: CustomTextStyles.bodyLarge16,
                ),
                Obx(
                  () => CustomSwitch(
                    value: controller.isSelectedSwitch.value,
                    onChange: (value) {
                      controller.switchChange(value);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
