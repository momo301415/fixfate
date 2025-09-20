import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../widgets/custom_image_view.dart';

/// 可复用的日期切换组件
/// 包含日/周/月切换按钮和日期区间显示
class DateSwitchWidget extends StatelessWidget {
  final List<String> timeTabs;
  final RxInt currentIndex;
  final RxString formattedRange;
  final Function(int) onTabChanged;
  final VoidCallback onPrevDate;
  final VoidCallback onNextDate;
  final VoidCallback onDatePicker;

  const DateSwitchWidget({
    Key? key,
    required this.timeTabs,
    required this.currentIndex,
    required this.formattedRange,
    required this.onTabChanged,
    required this.onPrevDate,
    required this.onNextDate,
    required this.onDatePicker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 切換：日／週／月
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.h), // 整體圓角
          ),
          clipBehavior: Clip.antiAlias, // 確保子項目裁切不溢出圓角
          child: Obx(() => Row(
            children: List.generate(timeTabs.length, (index) {
              final isSelected = currentIndex.value == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    currentIndex.value = index;
                    onTabChanged(index);
                  },
                  child: Container(
                    color: isSelected ? Color(0xFF5BB5C4) : Colors.transparent,
                    padding: EdgeInsets.symmetric(vertical: 4.v),
                    alignment: Alignment.center,
                    child: Text(
                      timeTabs[index],
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : appTheme.blueGray90001,
                      ),
                    ),
                  ),
                ),
              );
            }),
          )),
        ),
        SizedBox(height: 12.h),

        /// 日期區間 + 上下切換箭頭
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// 左箭頭
            GestureDetector(
              onTap: onPrevDate,
              child: CustomImageView(
                imagePath: ImageConstant.imgArrowDownPrimarycontainer,
                height: 18.h,
                width: 18.h,
              ),
            ),

            /// 日期顯示與下拉圖示
            GestureDetector(
              onTap: onDatePicker,
              child: Row(
                children: [
                  Obx(() => Text(
                    formattedRange.value,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.fSize,
                    ),
                  )),
                  SizedBox(width: 4.h),
                  CustomImageView(
                    imagePath: ImageConstant.imgForward,
                    height: 10.h,
                    width: 10.h,
                  ),
                ],
              ),
            ),

            /// 右箭頭
            GestureDetector(
              onTap: onNextDate,
              child: CustomImageView(
                imagePath: ImageConstant.imgArrowRightPrimarycontainer,
                height: 18.h,
                width: 18.h,
              ),
            ),
          ],
        ),
      ],
    );
  }
}