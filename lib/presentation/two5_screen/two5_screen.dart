import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import 'package:pulsedevice/widgets/ruler_piker.dart';
import '../../core/app_export.dart';

import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_switch.dart';
import 'controller/two5_controller.dart'; // ignore_for_file: must_be_immutable

/// 血氧測量告警設定頁面
class Two5Screen extends GetWidget<Two5Controller> {
  const Two5Screen({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      title: "lbl180_1".tr,
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

            // 血壓過高報警
            Text('lbl181'.tr,
                style: CustomTextStyles.bodyMediumPrimaryContainer),
            SizedBox(height: 8.h),
            Center(
              child: Obx(() => Text(
                    '${controller.lowThreshold.value.toInt()}',
                    style: CustomTextStyles.titleMediumPrimaryContainer_1,
                  )),
            ),
            SizedBox(height: 8.h),
            RulerPicker(
                min: 70,
                max: 100,
                initialValue: controller.lowThreshold,
                height: 52.v,
                step: 1.0,
                enabled: controller.isSelectedSwitch,
                onValueChanged: (value) {
                  controller.lowThreshold.value = value;
                }

                // containerWidth: rulerWidth,
                ),

            SizedBox(height: 24.h),
            Divider(),
            SizedBox(height: 24.h),

            // 正常範圍說明
            Text('lbl_98_100'.tr, style: CustomTextStyles.bodySmallGray50001),
            SizedBox(height: 16.h),

            // 重設按鈕
            SizedBox(
              width: double.infinity,
              child: CustomOutlinedButton(
                text: 'lbl179'.tr,
                buttonTextStyle: CustomTextStyles.titleMediumPrimary,
                onPressed: () {
                  controller.lowThreshold.value = 90;
                },
              ),
            ),
          ],
        ),
      ),
      onBack: () {
        controller.saveData();
      },
    );
  }
}
