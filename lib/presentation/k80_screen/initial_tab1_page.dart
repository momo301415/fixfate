import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import './models/chart_one_chart_model.dart';
import 'controller/k80_controller.dart';
import 'models/initial_tab1_model.dart';

// ignore_for_file: must_be_immutable
class InitialTab1Page extends StatelessWidget {
  InitialTab1Page({Key? key})
      : super(
          key: key,
        );

  K80Controller controller = Get.put(K80Controller());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: 342.h,
                margin: EdgeInsets.only(top: 12.h),
                child: Column(
                  children: [
                    Container(
                      height: 124.h,
                      width: 310.h,
                      margin: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Obx(
                        () => BarChart(
                          BarChartData(
                            minY: 0,
                            maxY: 4,
                            barTouchData: BarTouchData(enabled: true),
                            borderData: FlBorderData(show: false),
                            barGroups: List.generate(
                              controller.initialTab1ModelObj.value
                                  .chartOneChartModelObj.value.length,
                              (index) {
                                var model = controller.initialTab1ModelObj.value
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
                                  getTitlesWidget:
                                      (double value, TitleMeta meta) {
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
                                  getTitlesWidget:
                                      (double value, TitleMeta meta) {
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
                    ),
                    SizedBox(height: 24.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 36.h,
                        vertical: 8.h,
                      ),
                      decoration: AppDecoration.fillWhiteA.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 44.h,
                            width: 42.h,
                            margin: EdgeInsets.only(bottom: 6.h),
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "lbl_242".tr,
                                              style: theme.textTheme.titleLarge,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 6.h),
                                                child: Text(
                                                  "lbl161".tr,
                                                  style: CustomTextStyles
                                                      .bodySmallBluegray40010,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 6.h),
                                  child: Text(
                                    "lbl232".tr,
                                    style: theme.textTheme.bodySmall,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: VerticalDivider(
                              width: 1.h,
                              thickness: 1.h,
                              color: appTheme.blueGray10001,
                            ),
                          ),
                          SizedBox(
                            height: 44.h,
                            width: 50.h,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "lbl_22".tr,
                                                style:
                                                    theme.textTheme.titleLarge,
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 6.h),
                                                  child: Text(
                                                    "lbl161".tr,
                                                    style: CustomTextStyles
                                                        .bodySmallBluegray40010,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  "lbl240".tr,
                                  style: theme.textTheme.bodySmall,
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: VerticalDivider(
                              width: 1.h,
                              thickness: 1.h,
                              color: appTheme.blueGray10001,
                            ),
                          ),
                          SizedBox(
                            height: 44.h,
                            width: 38.h,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "lbl_13".tr,
                                                style:
                                                    theme.textTheme.titleLarge,
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 6.h),
                                                  child: Text(
                                                    "lbl161".tr,
                                                    style: CustomTextStyles
                                                        .bodySmallBluegray40010,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  "lbl241".tr,
                                  style: theme.textTheme.bodySmall,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.h,
                        vertical: 14.h,
                      ),
                      decoration: AppDecoration.fillWhiteA.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: Column(
                        spacing: 4,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomElevatedButton(
                                    height: 24.h,
                                    text: "lbl238".tr,
                                    buttonStyle: CustomButtonStyles.fillGrayTL4,
                                    buttonTextStyle: theme.textTheme.bodySmall!,
                                  ),
                                ),
                                Expanded(
                                  child: CustomElevatedButton(
                                    height: 24.h,
                                    text: "lbl239".tr,
                                    buttonStyle:
                                        CustomButtonStyles.fillPrimaryLR4,
                                    buttonTextStyle:
                                        CustomTextStyles.bodySmallWhiteA700,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.fromLTRB(6.h, 12.h, 6.h, 10.h),
                                  decoration: AppDecoration.outlineGray,
                                  width: double.maxFinite,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 24.h),
                                        child: Text(
                                          "lbl_992".tr,
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
                                  padding:
                                      EdgeInsets.fromLTRB(6.h, 12.h, 6.h, 10.h),
                                  decoration: AppDecoration.outlineGray,
                                  width: double.maxFinite,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 24.h),
                                        child: Text(
                                          "lbl_992".tr,
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
                                  padding:
                                      EdgeInsets.fromLTRB(6.h, 12.h, 6.h, 10.h),
                                  decoration: AppDecoration.outlineGray,
                                  width: double.maxFinite,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 24.h),
                                        child: Text(
                                          "lbl_992".tr,
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
                                  padding:
                                      EdgeInsets.fromLTRB(6.h, 12.h, 6.h, 10.h),
                                  decoration: AppDecoration.outlineGray,
                                  width: double.maxFinite,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 24.h),
                                        child: Text(
                                          "lbl_992".tr,
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
                                  padding:
                                      EdgeInsets.fromLTRB(6.h, 12.h, 6.h, 10.h),
                                  decoration: AppDecoration.outlineGray,
                                  width: double.maxFinite,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 24.h),
                                        child: Text(
                                          "lbl_992".tr,
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
                                  padding:
                                      EdgeInsets.fromLTRB(6.h, 12.h, 6.h, 10.h),
                                  decoration: AppDecoration.outlineGray,
                                  width: double.maxFinite,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 24.h),
                                        child: Text(
                                          "lbl_992".tr,
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
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
