import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k87_controller.dart';

/// 日期選擇器 - 選擇單日
// ignore_for_file: must_be_immutable
class K87Bottomsheet extends StatelessWidget {
  K87Bottomsheet({Key? key, required this.onConfirm})
      : super(
          key: key,
        );
  final void Function(int year, int month, int day) onConfirm;
  K87Controller controller = Get.put(K87Controller());

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
        context: context,
        locale: const Locale('zh', 'TW'),
        delegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        child: Builder(
            builder: (context) => Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 36.h,
                    vertical: 32.h,
                  ),
                  decoration: AppDecoration.fillWhiteA.copyWith(
                    borderRadius: BorderRadiusStyle.customBorderTL12,
                  ),
                  child: Column(
                    // spacing: 11,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: Obx(
                          () => SizedBox(
                              height: 312.h,
                              width: 302.h,
                              child: CalendarDatePicker2(
                                config: CalendarDatePicker2Config(
                                  calendarType: CalendarDatePicker2Type.single,
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
                                value:
                                    controller.selectedDatesFromCalendar.value,
                                onValueChanged: (dates) {
                                  controller.selectedDatesFromCalendar.value =
                                      dates;
                                },
                              )),
                        ),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomElevatedButton(
                                  onPressed: () => Get.back(),
                                  text: "lbl50".tr,
                                  margin: EdgeInsets.symmetric(horizontal: 8.h),
                                  buttonStyle: CustomButtonStyles.fillGray,
                                  buttonTextStyle:
                                      CustomTextStyles.bodyLarge16),
                            ),
                            Expanded(
                              child: CustomElevatedButton(
                                onPressed: () {
                                  final date = controller
                                      .selectedDatesFromCalendar.first;
                                  if (date != null) {
                                    onConfirm(date.year, date.month, date.day);
                                  }

                                  Get.back();
                                },
                                text: "lbl51".tr,
                                margin: EdgeInsets.symmetric(horizontal: 8.h),
                                buttonStyle: CustomButtonStyles.fillPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h)
                    ],
                  ),
                )));
  }
}
