import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k88_controller.dart';

// ignore_for_file: must_be_immutable
class K88Bottomsheet extends StatelessWidget {
  K88Bottomsheet(this.controller, {Key? key})
      : super(
          key: key,
        );

  K88Controller controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(32.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL12,
      ),
      child: Column(
        spacing: 22,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Obx(
              () => SizedBox(
                height: 312.h,
                width: 306.h,
                child: CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    calendarType: CalendarDatePicker2Type.multi,
                    firstDate: DateTime(DateTime.now().year - 5),
                    lastDate: DateTime(DateTime.now().year + 5),
                    selectedDayHighlightColor: Color(0XFF26A5BB),
                    firstDayOfWeek: 0,
                    selectedDayTextStyle: TextStyle(
                      color: appTheme.whiteA700,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                    dayTextStyle: TextStyle(
                      color: appTheme.gray500,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                    ),
                    dayBorderRadius: BorderRadius.circular(
                      20.h,
                    ),
                  ),
                  value: controller.selectedDatesFromCalendar.value,
                  onValueChanged: (dates) {
                    controller.selectedDatesFromCalendar.value = dates;
                  },
                ),
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(right: 2.h),
            child: Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    height: 56.h,
                    text: "lbl50".tr,
                    buttonStyle: CustomButtonStyles.fillGrayTL8,
                    buttonTextStyle: CustomTextStyles.bodyLargeGray500_1,
                  ),
                ),
                Expanded(
                  child: CustomElevatedButton(
                    height: 56.h,
                    text: "lbl51".tr,
                    buttonStyle: CustomButtonStyles.fillPrimary,
                    buttonTextStyle: CustomTextStyles.bodyLargeWhiteA700_1,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 16.h)
        ],
      ),
    );
  }
}
