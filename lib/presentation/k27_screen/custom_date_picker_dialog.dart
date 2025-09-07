import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDatePickerDialog extends StatefulWidget {
  final String? title;
  final DateTime? initialDate;
  final Function(DateTime)? onDateSelected;
  final DateTime? startDate;
  final DateTime? endDate;

  const CustomDatePickerDialog({
    Key? key,
    this.title = '選擇出生日期',
    this.initialDate,
    this.onDateSelected,
    this.startDate,
    this.endDate,
  }) : super(key: key);

  @override
  State<CustomDatePickerDialog> createState() => _CustomDatePickerDialogState();
}

class _CustomDatePickerDialogState extends State<CustomDatePickerDialog> {
  late DateTime date;
  @override
  void initState() {
    super.initState();
    date = widget.initialDate ?? DateTime.now();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 标题和关闭按钮
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title ?? '選擇出生日期',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.close,
                      color: Colors.grey[600],
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: date,
                mode: CupertinoDatePickerMode.date,
                minimumDate: widget.startDate,
                maximumDate: widget.endDate,
                // use24hFormat: true,
                // This shows day of week alongside day of month
                showDayOfWeek: true,
                // This is called when the user changes the date.
                onDateTimeChanged: (DateTime newDate) {
                  setState(() => date = newDate);
                },
              ),
            ),
            // 日期选择器
            // Container(
            //   height: 200,
            //   child: Row(
            //     children: [
            //       // 年份选择器
            //       Expanded(
            //         child: ListWheelScrollView.useDelegate(
            //           controller: _yearController,
            //           itemExtent: 40,
            //           physics: FixedExtentScrollPhysics(),
            //           onSelectedItemChanged: (index) {
            //             setState(() {
            //               selectedYear = years[index];
            //               _updateDays();
            //               // 更新日期控制器
            //               if (selectedDay > days.length) {
            //                 _dayController.animateToItem(
            //                   days.length - 1,
            //                   duration: Duration(milliseconds: 200),
            //                   curve: Curves.easeInOut,
            //                 );
            //               }
            //             });
            //           },
            //           childDelegate: ListWheelChildBuilderDelegate(
            //             builder: (context, index) {
            //               if (index < 0 || index >= years.length) return null;
            //               return Center(
            //                 child: Text(
            //                   '${years[index]}',
            //                   style: TextStyle(
            //                     fontSize: 18,
            //                     color: Colors.black87,
            //                   ),
            //                 ),
            //               );
            //             },
            //           ),
            //         ),
            //       ),

            //       // 月份选择器
            //       Expanded(
            //         child: ListWheelScrollView.useDelegate(
            //           controller: _monthController,
            //           itemExtent: 40,
            //           physics: FixedExtentScrollPhysics(),
            //           onSelectedItemChanged: (index) {
            //             setState(() {
            //               selectedMonth = months[index];
            //               _updateDays();
            //               // 更新日期控制器
            //               if (selectedDay > days.length) {
            //                 _dayController.animateToItem(
            //                   days.length - 1,
            //                   duration: Duration(milliseconds: 200),
            //                   curve: Curves.easeInOut,
            //                 );
            //               }
            //             });
            //           },
            //           childDelegate: ListWheelChildBuilderDelegate(
            //             builder: (context, index) {
            //               if (index < 0 || index >= months.length) return null;
            //               return Center(
            //                 child: Text(
            //                   '${months[index]}',
            //                   style: TextStyle(
            //                     fontSize: 18,
            //                     color: Colors.black87,
            //                   ),
            //                 ),
            //               );
            //             },
            //           ),
            //         ),
            //       ),

            //       // 日期选择器
            //       Expanded(
            //         child: ListWheelScrollView.useDelegate(
            //           controller: _dayController,
            //           itemExtent: 40,
            //           physics: FixedExtentScrollPhysics(),
            //           onSelectedItemChanged: (index) {
            //             setState(() {
            //               selectedDay = days[index];
            //             });
            //           },
            //           childDelegate: ListWheelChildBuilderDelegate(
            //             builder: (context, index) {
            //               if (index < 0 || index >= days.length) return null;
            //               return Center(
            //                 child: Text(
            //                   '${days[index]}',
            //                   style: TextStyle(
            //                     fontSize: 18,
            //                     color: Colors.black87,
            //                   ),
            //                 ),
            //               );
            //             },
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // 确定按钮
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  // final selectedDate =
                  //     DateTime(selectedYear, selectedMonth, selectedDay);
                  Get.back();
                  widget.onDateSelected?.call(date);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4ECDC4),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '確定',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
