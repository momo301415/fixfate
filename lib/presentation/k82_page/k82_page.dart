import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/widgets/sleep_bar_chart.dart';
import '../../core/app_export.dart';
import 'controller/k82_controller.dart';

/// 健康-睡眠頁面
class K82Page extends GetWidget<K82Controller> {
  K82Page({Key? key}) : super(key: key);

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
                            text: controller.sleepVal.value,
                            style: theme.textTheme.headlineMedium, // 數值部分，較大字體
                          ),
                          TextSpan(
                            text: 'lbl189'.tr,
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

            _buildBar(),
            Divider(height: 1, color: Colors.grey.shade300),
            Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        controller.segmentStartText.value,
                        style: CustomTextStyles.bodyMediumGray50001,
                      ),
                      Spacer(),
                      Text(controller.segmentEndText.value,
                          style: CustomTextStyles.bodyMediumGray50001),
                    ])),
            SizedBox(height: 12.h),
            Obx(() => Wrap(
                  runSpacing: 8,
                  spacing: 32,
                  children: [
                    _SleepItem(
                        label: "深睡",
                        value: controller.deep.value,
                        color: Color(0xFF123E48)),
                    _SleepItem(
                        label: "淺睡",
                        value: controller.light.value,
                        color: Color(0xFF219EBC)),
                    _SleepItem(
                        label: "快速動眼",
                        value: controller.rem.value,
                        color: Color(0xFF3DDCFF)),
                    _SleepItem(
                        label: "清醒",
                        value: controller.awake.value,
                        color: Color(0xFF90E0EF)),
                  ],
                )),
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

  Widget _buildBar() {
    return Obx(() => Container(
          padding: EdgeInsets.all(16),
          // 寬度填滿父容器，高度固定例如 100 像素（可調整）
          width: double.infinity,
          height: 100,
          color: Colors.white, // 背景色（可選）
          child: controller.sleepSegments.isEmpty
              ? Container()
              : GestureDetector(
                  onHorizontalDragStart: (_) {},
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: ClampingScrollPhysics(),
                    child: SleepTimelineBarChartWidget(
                      segments: controller.sleepSegments,
                      barHeight: 20.0,
                      pixelsPerMinute: 3.0,
                    ),
                  ),
                ),
        ));
  }

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
                      child: buildStat('${controller.deepCount.value}',
                          'lbl161'.tr, 'lbl246'.tr)),
                  verticalDivider(),
                  Expanded(
                      child: buildStat('${controller.lightCount.value}',
                          'lbl161'.tr, 'lbl247'.tr)),
                  verticalDivider(),
                  Expanded(
                      child: buildStat('${controller.awakeCount.value}',
                          'lbl161'.tr, 'lbl248'.tr)),
                ],
              ),
            ],
          ),
        ));
  }

  Widget buildAnalysis() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.v),
      child: Obx(() {
        final list = controller.k82ModelObj.value.listItemList2.value;

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

class _SleepItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SleepItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Row(
        children: [
          Container(
            width: 4,
            height: 28,
            color: color,
            margin: const EdgeInsets.only(right: 8),
          ),
          Expanded(
            child: Text(
              "$label：$value",
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
