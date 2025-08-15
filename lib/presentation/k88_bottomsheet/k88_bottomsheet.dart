import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k88_controller.dart';

/// 日期選擇器 - 選擇周次
// ignore_for_file: must_be_immutable
class K88Bottomsheet extends StatelessWidget {
  K88Bottomsheet({Key? key, required this.onConfirm})
      : super(
          key: key,
        );
  final void Function(int year, int month, int day) onConfirm;
  K88Controller controller = Get.put(K88Controller());

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
                  padding: EdgeInsets.all(32.h),
                  decoration: AppDecoration.fillWhiteA.copyWith(
                    borderRadius: BorderRadiusStyle.customBorderTL12,
                  ),
                  child: Column(
                    // spacing: 22,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: Obx(
                          () => SizedBox(
                            height: 312.h,
                            width: 306.h,
                            child: Localizations.override(
                                context: context,
                                locale: const Locale('zh', 'TW'),
                                child: CalendarDatePicker2(
                                  config: CalendarDatePicker2Config(
                                    calendarType: CalendarDatePicker2Type.range,
                                    firstDate:
                                        DateTime(DateTime.now().year - 5),
                                    lastDate: DateTime(DateTime.now().year + 5),
                                    selectedDayHighlightColor:
                                        Color(0XFF26A5BB),
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
                                  value: controller
                                      .selectedDatesFromCalendar.value,
                                  onValueChanged: (dates) async {
                                    if (dates.isNotEmpty) {
                                      final selectedDate = dates.first;
                                      // 修正：計算該日期所在週的週一到週日
                                      final weekStart = selectedDate.subtract(
                                          Duration(
                                              days: selectedDate.weekday - 1));
                                      final weekEnd = weekStart
                                          .add(const Duration(days: 6));

                                      await Future.delayed(
                                          Duration(milliseconds: 10));
                                      controller.selectedDatesFromCalendar
                                          .value = [weekStart, weekEnd];
                                    }
                                  },
                                )),
                          ),
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
                                  final dates = controller
                                      .selectedDatesFromCalendar.value;
                                  if (dates.isNotEmpty && dates.first != null) {
                                    // 修正：傳遞週的開始日期（週一）
                                    final weekStart = dates.first!;
                                    onConfirm(weekStart.year, weekStart.month,
                                        weekStart.day);
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
