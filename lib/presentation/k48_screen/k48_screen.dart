import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_switch.dart';
import 'controller/k48_controller.dart'; // ignore_for_file: must_be_immutable‘

/// 用藥提醒頁面
class K48Screen extends GetWidget<K48Controller> {
  const K48Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
        title: "lbl58".tr, child: Container(child: _buildColumnone()));
  }

  /// Section Widget
  Widget _buildColumnone() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 16.h,
        top: 16.h,
        right: 16.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 4.h,
      ),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20.h, 24.h, 20.h, 22.h),
            decoration: AppDecoration.outlineGray,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "lbl141".tr,
                  style: CustomTextStyles.bodyMediumBluegray900,
                ),
                Obx(
                  () => CustomSwitch(
                    value: controller.isSelectedSwitch.value,
                    onChange: (value) {
                      controller.isSelectedSwitch.value = value;
                    },
                  ),
                )
              ],
            ),
          ),
          Obx(
            () {
              final isSwitchOpen = controller.isSelectedSwitch.value;
              final alertTime = controller.alertTime.value;
              return GestureDetector(
                  onTap: () {
                    if (isSwitchOpen) {
                      controller.selectAlertTime();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(24.h, 24.h, 24.h, 22.h),
                    decoration: AppDecoration.outlineGray,
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "lbl142".tr,
                          style: CustomTextStyles.bodyMediumPrimaryContainer,
                        ),
                        Spacer(),
                        Text(
                          alertTime.isNotEmpty ? alertTime : "lbl143".tr,
                          style: isSwitchOpen == true
                              ? CustomTextStyles.bodyMediumPrimaryContainer
                              : CustomTextStyles.bodyMediumGray300,
                        ),
                        CustomImageView(
                          imagePath: isSwitchOpen == true
                              ? ImageConstant.imgArrowRightGray600
                              : ImageConstant.imgArrowRightGray300,
                          height: 16.h,
                          width: 18.h,
                          margin: EdgeInsets.only(left: 8.h),
                        )
                      ],
                    ),
                  ));
            },
          ),
          SizedBox(height: 24.h),
          Obx(
            () {
              final isSwitchOpen = controller.isSelectedSwitch.value;
              final eatTime = controller.eatTime.value;
              return GestureDetector(
                  onTap: () {
                    if (isSwitchOpen) {
                      controller.selectEatTime();
                    }
                  },
                  child: Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(horizontal: 24.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "lbl144".tr,
                          style: CustomTextStyles.bodyMediumPrimaryContainer,
                        ),
                        Spacer(),
                        Text(
                          eatTime.isNotEmpty ? eatTime : "lbl145".tr,
                          style: isSwitchOpen == true
                              ? CustomTextStyles.bodyMediumPrimaryContainer
                              : CustomTextStyles.bodyMediumGray300,
                        ),
                        CustomImageView(
                          imagePath: isSwitchOpen == true
                              ? ImageConstant.imgArrowRightGray600
                              : ImageConstant.imgArrowRightGray300,
                          height: 16.h,
                          width: 18.h,
                          margin: EdgeInsets.only(left: 8.h),
                        )
                      ],
                    ),
                  ));
            },
          ),
          SizedBox(height: 24.h)
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
