import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/presentation/k77_page/models/list_item_model.dart';
import '../../core/app_export.dart';
import 'controller/k77_controller.dart';

/// 健康-心率頁面
class K77Page extends GetWidget<K77Controller> {
  const K77Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 24.h), // 避免底部裁切
        child: Column(
          children: [
            buildTrendBlock(),
            SizedBox(height: 4.h),
            buildGrid1(),
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
                            text: controller.heartRateVal.value,
                            style: theme.textTheme.headlineMedium, // 數值部分，較大字體
                          ),
                          TextSpan(
                            text: 'lbl177'.tr,
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
                        controller.isAlert.value
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.h, vertical: 4.v),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12.h),
                                ),
                                child: Text('lbl216'.tr,
                                    style: TextStyle(color: Colors.white)),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.h, vertical: 4.v)),
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
  Widget buildGrid1() {
    return Obx(() => Container(
          // margin: const EdgeInsets.all(12),
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // 上排
              Row(
                children: [
                  Expanded(
                      child: buildStat('${controller.normalCount.value}',
                          'lbl161'.tr, 'lbl232'.tr)),
                  verticalDivider(),
                  Expanded(
                      child: buildStat('${controller.highCount.value}',
                          'lbl161'.tr, 'lbl233'.tr)),
                  verticalDivider(),
                  Expanded(
                      child: buildStat('${controller.lowCount.value}',
                          'lbl161'.tr, 'lbl234'.tr)),
                ],
              ),
              const SizedBox(height: 16),
              // 下排
              Row(
                children: [
                  Expanded(
                      child: buildStat('${controller.normalMinCount.value}',
                          'lbl177'.tr, 'lbl235'.tr)),
                  verticalDivider(),
                  Expanded(
                      child: buildStat('${controller.hightMinCount.value}',
                          'lbl177'.tr, 'lbl236'.tr)),
                  verticalDivider(),
                  Expanded(
                      child: buildStat('${controller.lowMinCount.value}',
                          'lbl177'.tr, 'lbl237'.tr)),
                ],
              ),
            ],
          ),
        ));
  }

  Widget buildAnalysis() {
    return Container(
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.h),
        ),
        child: Obx(() =>
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.h),
                ),
                clipBehavior: Clip.antiAlias,
                child: Row(
                  children:
                      List.generate(controller.recordTabs.length, (index) {
                    final isSelected = controller.recordIndex.value == index;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.recordIndex.value = index;
                        },
                        child: Container(
                          color: isSelected
                              ? const Color(0xFF5BB5C4)
                              : Colors.transparent,
                          padding: EdgeInsets.symmetric(vertical: 4.v),
                          alignment: Alignment.center,
                          child: Text(
                            controller.recordTabs[index],
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
              buildRecordList(),
            ])));
  }

  Widget buildRecordList() {
    return Obx(() {
      final isRecordMode = controller.recordIndex.value == 0;
      final list = isRecordMode
          ? controller.k77ModelObj.value.listItemList.value
          : controller.k77ModelObj.value.listItemList2.value;

      if (list.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Center(child: Text('無資料')),
        );
      }

      return ListView.separated(
        padding: EdgeInsets.only(top: 2.h),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: list.length,
        separatorBuilder: (context, index) =>
            Divider(height: 1, color: Colors.grey.shade300),
        itemBuilder: (context, index) {
          if (isRecordMode) {
            final item = list[index] as ListRecordItemModel;
            final itemTime =
                item.time?.value.format(pattern: 'yyyy/MM/dd HH:mm') ?? '';
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.label?.value ?? '',
                      style: CustomTextStyles.bodyMediumBluegray900),
                  Text('${item.value?.value ?? ''}${item.unit?.value ?? ''}',
                      style: CustomTextStyles.bodyMediumBluegray900),
                  Text(itemTime, style: CustomTextStyles.bodyMediumBluegray900),
                ],
              ),
            );
          } else {
            final item = list[index] as ListHistoryItemModel;
            final itemTime =
                item.time?.value.format(pattern: 'yyyy/MM/dd HH:mm') ?? '';
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${item.value?.value ?? ''}${item.unit?.value ?? ''}',
                      style: CustomTextStyles.bodyMediumBluegray900),
                  Text(itemTime, style: CustomTextStyles.bodyMediumBluegray900),
                ],
              ),
            );
          }
        },
      );
    });
  }
}
