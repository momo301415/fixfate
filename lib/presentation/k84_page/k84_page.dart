import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import '../../core/app_export.dart';
import 'controller/k84_controller.dart';

/// 健康-移動距離頁面
class K84Page extends GetWidget<K84Controller> {
  const K84Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 24.h), // 避免底部裁切
        child: Column(
          children: [
            buildTrendBlock(),
            SizedBox(height: 4.h),
            buildAnalysis(),
          ],
        ));
  }

  Widget buildTrendBlock() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: controller.distanceVal.value,
                            style: theme.textTheme.headlineMedium, // 數值部分，較大字體
                          ),
                          TextSpan(
                            text: 'lbl193'.tr,
                            style: theme.textTheme.bodySmall, // 單位部分，較小字體
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(controller.loadDataTime.value,
                            style: theme.textTheme.bodySmall),
                        SizedBox(width: 8.h),
                      ],
                    ),
                  ],
                )),
            SizedBox(height: 12.h),

            /// 切換：日／週／月
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.h), // 整體圓角
              ),
              clipBehavior: Clip.antiAlias, // 確保子項目裁切不溢出圓角
              child: Row(
                children: List.generate(controller.timeTabs.length, (index) {
                  final isSelected = controller.currentIndex.value == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.currentIndex.value = index;
                        controller.updateDateRange(index);
                      },
                      child: Container(
                        color:
                            isSelected ? Color(0xFF5BB5C4) : Colors.transparent,
                        padding: EdgeInsets.symmetric(vertical: 4.v),
                        alignment: Alignment.center,
                        child: Text(
                          controller.timeTabs[index],
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
              ),
            ),
            SizedBox(height: 12.h),

            /// 日期區間 + 上下切換箭頭
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// 左箭頭
                GestureDetector(
                  onTap: () =>
                      controller.prevDateRange(controller.currentIndex.value),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgArrowDownPrimarycontainer,
                    height: 18.h,
                    width: 18.h,
                  ),
                ),

                /// 日期顯示與下拉圖示
                GestureDetector(
                  onTap: () {
                    controller.datePicker(controller.currentIndex.value);
                  },
                  child: Row(
                    children: [
                      Text(
                        controller.formattedRange.value,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.fSize,
                        ),
                      ),
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
                  onTap: () =>
                      controller.nextDateRange(controller.currentIndex.value),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgArrowRightPrimarycontainer,
                    height: 18.h,
                    width: 18.h,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            /// 切換內容 (圖表)
            SizedBox(
              height: 110.h,
              child: IndexedStack(
                index: controller.currentIndex.value,
                children: List.generate(3, (index) {
                  return Obx(() => LineChart(controller.getChartData(index)));
                }),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget buildStat(String value, String unit, String label) {
    return Column(
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: value,
                style: TextStyle(
                  fontSize: 20,
                  color: appTheme.cyan700,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: unit,
                style: TextStyle(
                  fontSize: 14,
                  color: appTheme.blueGray400,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget verticalDivider() => Container(
      height: 36.h,
      child: const VerticalDivider(
        color: Color(0xFFD8D8D8),
        width: 1,
        thickness: 1,
        indent: 8,
        endIndent: 8,
      ));

  Widget buildAnalysis() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.v),
      child: Obx(() {
        final list = controller.k84ModelObj.value.listItemList2.value;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.h),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(12.h),
                child: Text('lbl239'.tr,
                    style: CustomTextStyles.labelLargeBlack900),
              ),
              Divider(height: 1, color: Colors.grey.shade300),
              if (list.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Center(child: Text('無資料')),
                )
              else
                ...List.generate(list.length, (index) {
                  final item = list[index];
                  final itemTime =
                      item.time?.value.format(pattern: 'yyyy/MM/dd HH:mm') ??
                          '';
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                '${item.value?.value ?? ''}${item.unit?.value ?? ''}',
                                style: CustomTextStyles.bodyMediumBluegray900),
                            Text(itemTime,
                                style: CustomTextStyles.bodyMediumBluegray900),
                          ],
                        ),
                      ),
                      Divider(height: 1, color: Colors.grey.shade300),
                    ],
                  );
                }),
            ],
          ),
        );
      }),
    );
  }
}
