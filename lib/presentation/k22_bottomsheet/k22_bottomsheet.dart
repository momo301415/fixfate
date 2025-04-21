import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/theme/custom_button_style.dart';
import 'package:pulsedevice/widgets/custom_elevated_button.dart';
import '../../core/app_export.dart';
import 'controller/k22_controller.dart';

// ignore_for_file: must_be_immutable
/// 生日選擇器
class K22Bottomsheet extends StatelessWidget {
  K22Bottomsheet(this.controller, {Key? key, this.onDateConfirmed})
      : super(
          key: key,
        );

  K22Controller controller;
  final void Function(DateTime)? onDateConfirmed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.h)),
      ),
      padding: EdgeInsets.only(top: 20.h, bottom: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'lbl_selector_birth'.tr,
                  style: CustomTextStyles.labelLargeBlack900,
                ),
                IconButton(
                  icon: Icon(Icons.close, color: appTheme.gray500),
                  onPressed: () => Get.back(),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          /// Pickers
          SizedBox(
            height: 180.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// 年份
                Obx(() => _buildPicker(
                      controller.years,
                      controller.selectedYear.value,
                      (val) {
                        controller.selectedYear.value = val;
                        controller.updateDayOnMonthYearChange();
                      },
                    )),

                /// 月份
                Obx(() => _buildPicker(
                      controller.months,
                      controller.selectedMonth.value,
                      (val) {
                        controller.selectedMonth.value = val;
                        controller.updateDayOnMonthYearChange();
                      },
                    )),

                /// 日期
                Obx(() => _buildPicker(
                      controller.days,
                      controller.selectedDay.value,
                      (val) => controller.selectedDay.value = val,
                    )),
              ],
            ),
          ),

          SizedBox(height: 20.h),
          CustomElevatedButton(
            text: "lbl51".tr, // 確定
            margin: EdgeInsets.symmetric(horizontal: 16.h),
            buttonStyle: CustomButtonStyles.fillPrimary,
            onPressed: () {
              final selected = controller.getFormattedDate();
              Get.back(result: selected);
            },
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Text(
              "lbl50".tr, // 取消
              style: CustomTextStyles.titleMediumGray500,
            ),
          ),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }

  Widget _buildPicker(
      List<int> items, int selectedValue, ValueChanged<int> onSelected) {
    final initialIndex = items.indexOf(selectedValue);
    return SizedBox(
      width: 100.h,
      child: CupertinoPicker(
        scrollController:
            FixedExtentScrollController(initialItem: initialIndex),
        itemExtent: 32.h,
        onSelectedItemChanged: (index) => onSelected(items[index]),
        children: items.map((e) => Center(child: Text(e.toString()))).toList(),
      ),
    );
  }
}
