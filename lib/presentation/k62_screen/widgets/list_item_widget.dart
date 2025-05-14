import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_switch.dart';
import '../../../core/app_export.dart';
import '../models/list_item_model.dart';

// ignore_for_file: must_be_immutable
class ListItemWidget extends StatelessWidget {
  final ListItemModel model;
  ListItemWidget(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 20.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(model.label,
                      style: CustomTextStyles.bodyMediumPrimaryContainer),
                  Row(
                    children: [
                      Text(
                        _formatValue(model.value.value),
                        style: CustomTextStyles.bodyMediumPrimaryContainer,
                      ),
                      SizedBox(width: 4.h),
                      Text(model.unit,
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
                  value: model.value.value,
                  min: model.min,
                  max: model.max,
                  divisions: ((model.max - model.min) / model.division).round(),
                  onChanged: (v) =>
                      model.value.value = _roundToStep(v, model.division),
                ),
              )),
          SizedBox(height: 24.h),

          // 達成通知區塊
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("達成通知", style: CustomTextStyles.bodyLarge16),
                  SizedBox(height: 4.h),
                  Text("根據目標達成狀況，推送系統通知。",
                      style: CustomTextStyles.bodySmallGray50001),
                ],
              ),
              Obx(
                () => CustomSwitch(
                  value: model.isEnable.value,
                  onChange: (value) {
                    model.isEnable.value = value;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatValue(double value) {
    return value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(1);
  }

  double _roundToStep(double value, double step) {
    return (value / step).round() * step;
  }
}
