import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import 'package:pulsedevice/widgets/ruler_piker.dart';
import '../../core/app_export.dart';

import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_switch.dart';
import 'controller/two9_controller.dart'; // ignore_for_file: must_be_immutable

/// 壓力測量告警設定頁面
class Two9Screen extends GetWidget<Two9Controller> {
  const Two9Screen({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      title: "lbl217_2".tr,
      child: Container(
        padding: EdgeInsets.all(36.h),
        decoration: AppDecoration.fillWhiteA.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 報警開關
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('lbl175'.tr,
                          style: CustomTextStyles.titleMediumPrimaryContainer),
                      SizedBox(height: 4.h),
                      Text('msg8'.tr,
                          style: CustomTextStyles.bodySmallGray50001),
                    ],
                  ),
                ),
                Obx(() => CustomSwitch(
                      value: controller.isSelectedSwitch.value,
                      onChange: (v) => controller.isSelectedSwitch.value = v,
                    )),
              ],
            ),
            SizedBox(height: 16.h),

            // 壓力過高報警
            Text('lbl217_1'.tr,
                style: CustomTextStyles.bodyMediumPrimaryContainer),
            SizedBox(height: 8.h),
            Center(
              child: Obx(() => Text(
                    '${controller.highThreshold.value.toInt()}',
                    style: CustomTextStyles.titleMediumPrimaryContainer_1,
                  )),
            ),
            SizedBox(height: 8.h),
            RulerPicker(
                min: 0,
                max: 100,
                initialValue: controller.highThreshold,
                height: 52.v,
                step: 1.0,
                enabled: controller.isSelectedSwitch,
                onValueChanged: (value) {
                  controller.highThreshold.value = value;
                }),

            SizedBox(height: 24.h),
            Divider(),
            SizedBox(height: 24.h),

            // 正常範圍說明
            Text('lbl_0_70'.tr, style: CustomTextStyles.bodySmallGray50001),
            SizedBox(height: 16.h),

            // 重設按鈕
            SizedBox(
              width: double.infinity,
              child: CustomOutlinedButton(
                text: 'lbl179'.tr,
                buttonTextStyle: CustomTextStyles.titleMediumPrimary,
                onPressed: () {
                  controller.highThreshold.value = 90;
                },
              ),
            ),
          ],
        ),
      ),
      onBack: () {
        controller.saveData();
        Get.back();
      },
    );
  }
}
