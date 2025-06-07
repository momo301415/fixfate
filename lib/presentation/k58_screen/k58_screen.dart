import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import 'package:pulsedevice/widgets/ruler_piker.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_switch.dart';
import 'controller/k58_controller.dart';

/// 心率測量告警設定頁面
class K58Screen extends GetWidget<K58Controller> {
  const K58Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      title: 'lbl174'.tr,
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

            // 心率過高報警
            Text('lbl176'.tr,
                style: CustomTextStyles.bodyMediumPrimaryContainer),
            SizedBox(height: 8.h),
            Center(
              child: Obx(() => Text(
                    '${controller.highThreshold.value.toInt()} 次/分鐘',
                    style: CustomTextStyles.titleMediumPrimaryContainer_1,
                  )),
            ),
            SizedBox(height: 8.h),
            RulerPicker(
                min: 80,
                max: 140,
                initialValue: controller.highThreshold,
                height: 52.v,
                step: 1.0,
                enabled: controller.isSelectedSwitch,
                onValueChanged: (value) {
                  controller.highThreshold.value = value;
                }

                // containerWidth: rulerWidth,
                ),

            SizedBox(height: 24.h),
            Divider(),
            SizedBox(height: 24.h),

            // 心率過低報警
            Text('lbl178'.tr,
                style: CustomTextStyles.bodyMediumPrimaryContainer),
            SizedBox(height: 8.h),
            Center(
              child: Obx(() => Text(
                    '${controller.lowThreshold.value.toInt()} 次/分鐘',
                    style: CustomTextStyles.titleMediumPrimaryContainer_1,
                  )),
            ),
            SizedBox(height: 8.h),
            RulerPicker(
              min: 40,
              max: 80,
              initialValue: controller.lowThreshold,
              height: 52.v,
              step: 1.0,
              enabled: controller.isSelectedSwitch,
              onValueChanged: (value) {
                controller.lowThreshold.value = value;
              },

              // containerWidth: rulerWidth,
            ),

            SizedBox(height: 24.h),
            Divider(),
            SizedBox(height: 24.h),

            // 正常範圍說明
            Text('msg_60_100'.tr, style: CustomTextStyles.bodySmallGray50001),
            SizedBox(height: 16.h),

            // 重設按鈕
            SizedBox(
              width: double.infinity,
              child: CustomOutlinedButton(
                text: 'lbl179'.tr,
                buttonTextStyle: CustomTextStyles.titleMediumPrimary,
                onPressed: () {
                  controller.highThreshold.value = 100;
                  controller.lowThreshold.value = 60;
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
