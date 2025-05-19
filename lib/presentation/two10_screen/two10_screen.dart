import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/two10_screen/controller/two10_controller.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';

import '../../widgets/custom_outlined_button.dart';

/// 裝置監聽設定頁面
class Two10Screen extends GetWidget<Two10Controller> {
  const Two10Screen({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      title: "lbl_listen".tr,
      child: Container(
        padding: EdgeInsets.all(36.h),
        decoration: AppDecoration.fillWhiteA.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("健康監測間隔",
                        style: CustomTextStyles.bodyMediumPrimaryContainer),
                    Row(
                      children: [
                        Text(
                          _formatValue(controller.times.value.toDouble()),
                          style: CustomTextStyles.bodyMediumPrimaryContainer,
                        ),
                        SizedBox(width: 4.h),
                        Text("分鐘",
                            style: CustomTextStyles.bodyMediumPrimaryContainer),
                      ],
                    ),
                  ],
                )),
            Obx(() => SliderTheme(
                  data: SliderThemeData(
                    trackShape: RoundedRectSliderTrackShape(),
                    activeTrackColor: theme.colorScheme.primary,
                    inactiveTrackColor: appTheme.gray300,
                    thumbColor: appTheme.whiteA700,
                    thumbShape: RoundSliderThumbShape(),
                  ),
                  child: Slider(
                    value: controller.times.value.toDouble(),
                    min: controller.timeMin.value.toDouble(),
                    max: controller.timeMax.value.toDouble(),
                    divisions:
                        ((controller.timeMax.value - controller.timeMin.value) /
                                1)
                            .round(),
                    onChanged: (v) => controller.times.value =
                        _roundToStep(v.toDouble(), 1.toDouble()).toInt(),
                  ),
                )),

            // 重設按鈕
            SizedBox(
              width: double.infinity,
              child: CustomOutlinedButton(
                text: 'lbl179'.tr,
                buttonTextStyle: CustomTextStyles.titleMediumPrimary,
                onPressed: () {
                  controller.times.value = 60;
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

  String _formatValue(double value) {
    return value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(1);
  }

  double _roundToStep(double value, double step) {
    return (value / step).round() * step;
  }
}
