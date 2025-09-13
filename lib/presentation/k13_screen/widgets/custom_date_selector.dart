import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import '../../../core/app_export.dart';

/// 自定義日期選擇組件
class CustomDateSelector extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;
  final String dateFormat; // 日期格式

  const CustomDateSelector({
    Key? key,
    required this.selectedDate,
    required this.onDateChanged,
    this.dateFormat = 'M月d日, EEEE',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 左箭頭 - 前一天
          GestureDetector(
            onTap: () {
              DateTime previousDay = selectedDate.subtract(Duration(days: 1));
              onDateChanged(previousDay);
            },
            child: CustomImageView(
              imagePath: ImageConstant.imgArrowDownPrimarycontainer1,
              height: 18.h,
              width: 18.h,
            ),
          ),
          Spacer(flex: 46),
          // 日期顯示和選擇
          GestureDetector(
            onTap: () {
              _showDatePicker(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatDate(selectedDate),
                  style: CustomTextStyles.bodyMediumPrimaryContainer15_1,
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgForward,
                  height: 6.h,
                  width: 12.h,
                  radius: BorderRadius.circular(1.h),
                  margin: EdgeInsets.only(left: 10.h),
                ),
              ],
            ),
          ),
          Spacer(flex: 53),
          // 右箭頭 - 後一天
          GestureDetector(
            onTap: () {
              DateTime nextDay = selectedDate.add(Duration(days: 1));
              onDateChanged(nextDay);
            },
            child: CustomImageView(
              imagePath: ImageConstant.imgArrowRightPrimarycontainer1,
              height: 18.h,
              width: 18.h,
            ),
          ),
        ],
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    picker.DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2020, 1, 1),
      maxTime: DateTime.now().add(Duration(days: 365)),
      currentTime: selectedDate,
      locale: picker.LocaleType.zh,
      theme: picker.DatePickerTheme(
        headerColor: appTheme.cyan70001,
        backgroundColor: Colors.white,
        itemStyle: CustomTextStyles.bodyMediumPrimaryContainer15_1,
        doneStyle: CustomTextStyles.titleSmallErrorContainer14_1.copyWith(
          color: Colors.white,
        ),
        cancelStyle: CustomTextStyles.bodyMediumPrimaryContainer15_1,
      ),
      onConfirm: (date) {
        onDateChanged(date);
      },
    );
  }

  String _formatDate(DateTime date) {
    // 格式化日期顯示
    List<String> weekdays = ['', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日'];
    String weekday = weekdays[date.weekday];
    return '${date.month}月${date.day}日, $weekday';
  }
}