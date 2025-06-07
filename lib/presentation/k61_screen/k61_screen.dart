import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import 'package:pulsedevice/widgets/ruler_piker.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_switch.dart';
import 'controller/k61_controller.dart'; // ignore_for_file: must_be_immutable

/// 體溫測量告警頁面
class K61Screen extends GetWidget<K61Controller> {
  const K61Screen({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      title: "lbl183".tr,
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

            // 體溫過高報警
            Text('lbl184'.tr,
                style: CustomTextStyles.bodyMediumPrimaryContainer),
            SizedBox(height: 8.h),
            Center(
              child: Obx(() => Text(
                    '${controller.highThreshold.value} °C',
                    style: CustomTextStyles.titleMediumPrimaryContainer_1,
                  )),
            ),
            SizedBox(height: 8.h),
            RulerPicker(
                min: 35.0,
                max: 40.0,
                initialValue: controller.highThreshold,
                height: 52.v,
                step: 0.1,
                enabled: controller.isSelectedSwitch,
                onValueChanged: (value) {
                  controller.highThreshold.value = value;
                }

                // containerWidth: rulerWidth,
                ),

            SizedBox(height: 24.h),
            Divider(),
            SizedBox(height: 24.h),

            // 體溫過低報警
            Text('lbl185'.tr,
                style: CustomTextStyles.bodyMediumPrimaryContainer),
            SizedBox(height: 8.h),
            Center(
              child: Obx(() => Text(
                    '${controller.lowThreshold.value} °C',
                    style: CustomTextStyles.titleMediumPrimaryContainer_1,
                  )),
            ),
            SizedBox(height: 8.h),
            RulerPicker(
              min: 35.0,
              max: 40.0,
              initialValue: controller.lowThreshold,
              height: 52.v,
              step: 0.1,
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
            Text('lbl_35_37_2_c'.tr,
                style: CustomTextStyles.bodySmallGray50001),
            SizedBox(height: 16.h),

            // 重設按鈕
            SizedBox(
              width: double.infinity,
              child: CustomOutlinedButton(
                text: 'lbl179'.tr,
                buttonTextStyle: CustomTextStyles.titleMediumPrimary,
                onPressed: () {
                  controller.highThreshold.value = 36.0;
                  controller.lowThreshold.value = 33.0;
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
