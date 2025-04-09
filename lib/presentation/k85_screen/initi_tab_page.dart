import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_text_form_field.dart';
import './models/chart_one_chart_model.dart';
import 'controller/k85_controller.dart';
import 'models/chipview_item_model.dart';
import 'models/initi_tab_model.dart';
import 'widgets/chipview_item_widget.dart';

// ignore_for_file: must_be_immutable
class InitiTabPage extends StatelessWidget {
  InitiTabPage({Key? key})
      : super(
          key: key,
        );

  K85Controller controller = Get.put(K85Controller());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6.h,
        vertical: 16.h,
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: 8.h),
                child: Column(
                  spacing: 8,
                  children: [_buildColumnzipcode(), _buildColumnone()],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnzipcode() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 8.h),
      padding: EdgeInsets.all(14.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 4.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "lbl_1280".tr,
                    style: theme.textTheme.headlineLarge,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 4.h,
                    bottom: 6.h,
                  ),
                  child: Text(
                    "lbl191".tr,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: Text(
                    "lbl_12".tr,
                    style: theme.textTheme.bodySmall,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: Obx(
              () => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  direction: Axis.horizontal,
                  runSpacing: 8.h,
                  spacing: 8.h,
                  children: List<Widget>.generate(
                    controller
                        .initiTabModelObj.value.chipviewItemList.value.length,
                    (index) {
                      ChipviewItemModel model = controller
                          .initiTabModelObj.value.chipviewItemList.value[index];
                      return ChipviewItemWidget(
                        model,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 124.h,
            width: 310.h,
            child: Obx(
              () => BarChart(
                BarChartData(
                  minY: 0,
                  maxY: 4,
                  barTouchData: BarTouchData(enabled: true),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(
                    controller.initiTabModelObj.value.chartOneChartModelObj
                        .value.length,
                    (index) {
                      var model = controller.initiTabModelObj.value
                          .chartOneChartModelObj.value[index];
                      return BarChartGroupData(
                        x: model.x,
                        barRods: model.barRods,
                      );
                    },
                  ),
                  gridData: FlGridData(
                    verticalInterval: 1,
                    horizontalInterval: 1,
                    drawHorizontalLine: false,
                    drawVerticalLine: false,
                  ),
                  titlesData: FlTitlesData(
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          var title = '';
                          switch (value) {
                            case 0:
                              title = "1";
                            case 1:
                              title = "2";
                            case 2:
                              title = "3";
                            case 3:
                              title = "4";
                          }
                          return Text(
                            title,
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          var title = '';
                          switch (value) {
                            case 1:
                              title = "1";
                            case 2:
                              title = "2";
                            case 3:
                              title = "3";
                            case 4:
                              title = "4";
                          }
                          return Text(
                            title,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                duration: const Duration(
                  milliseconds: 500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnone() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 8.h),
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFormField(
            controller: controller.oneController,
            hintText: "lbl239".tr,
            hintStyle: CustomTextStyles.titleSmallErrorContainer,
            textInputAction: TextInputAction.done,
            contentPadding: EdgeInsets.fromLTRB(18.h, 12.h, 18.h, 8.h),
            borderDecoration: TextFormFieldStyleHelper.underLine,
            filled: false,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(6.h, 12.h, 6.h, 10.h),
            decoration: AppDecoration.outlineGray,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.h),
                  child: Text(
                    "lbl_12802".tr,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "msg_2025_03_29_11_23".tr,
                    style: theme.textTheme.bodySmall,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(6.h, 12.h, 6.h, 10.h),
            decoration: AppDecoration.outlineGray,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.h),
                  child: Text(
                    "lbl_12802".tr,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "msg_2025_03_29_11_23".tr,
                    style: theme.textTheme.bodySmall,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(6.h, 12.h, 6.h, 10.h),
            decoration: AppDecoration.outlineGray,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.h),
                  child: Text(
                    "lbl_12802".tr,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "msg_2025_03_29_11_23".tr,
                    style: theme.textTheme.bodySmall,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(6.h, 12.h, 6.h, 10.h),
            decoration: AppDecoration.outlineGray,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.h),
                  child: Text(
                    "lbl_12802".tr,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "msg_2025_03_29_11_23".tr,
                    style: theme.textTheme.bodySmall,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(
              left: 18.h,
              right: 6.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "lbl_12802".tr,
                  style: theme.textTheme.bodyMedium,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "msg_2025_03_29_11_23".tr,
                    style: theme.textTheme.bodySmall,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 12.h)
        ],
      ),
    );
  }
}
