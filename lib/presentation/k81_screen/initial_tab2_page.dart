import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import './models/chart_one_chart_model.dart';
import 'controller/k81_controller.dart';
import 'models/initial_tab2_model.dart';

// ignore_for_file: must_be_immutable
class InitialTab2Page extends StatelessWidget {
  InitialTab2Page({Key? key})
      : super(
          key: key,
        );

  K81Controller controller = Get.put(K81Controller());

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
                      width: 306.h,
                      margin: EdgeInsets.only(
                        left: 18.h,
                        right: 16.h,
                      ),
                      child: Obx(
                        () => BarChart(
                          BarChartData(
                            minY: 0,
                            maxY: 4,
                            barTouchData: BarTouchData(enabled: true),
                            borderData: FlBorderData(show: false),
                            barGroups: List.generate(
                              controller.initialTab2ModelObj.value
                                  .chartOneChartModelObj.value.length,
                              (index) {
                                var model = controller.initialTab2ModelObj.value
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
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(
                        horizontal: 36.h,
                        vertical: 8.h,
                      ),
                      decoration: AppDecoration.fillWhiteA.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: Column(
                        spacing: 10,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.only(
                              left: 28.h,
                              right: 34.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildStacktwentyfour(
                                  twentyfourTwo: "lbl_242".tr,
                                  three: "lbl161".tr,
                                  one: "lbl232".tr,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: VerticalDivider(
                                    width: 1.h,
                                    thickness: 1.h,
                                    color: appTheme.blueGray10001,
                                    endIndent: 4.h,
                                  ),
                                ),
                                SizedBox(
                                  height: 44.h,
                                  width: 28.h,
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
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "lbl_22".tr,
                                                    style: theme
                                                        .textTheme.titleLarge,
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
                                                            .bodySmall10,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "lbl242".tr,
                                        style: theme.textTheme.bodySmall,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildStacktwentyfour(
                                  twentyfourTwo: "lbl_862".tr,
                                  three: "lbl182".tr,
                                  one: "lbl235".tr,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: VerticalDivider(
                                    width: 1.h,
                                    thickness: 1.h,
                                    color: appTheme.blueGray10001,
                                    endIndent: 4.h,
                                  ),
                                ),
                                SizedBox(
                                  height: 44.h,
                                  width: 54.h,
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
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "lbl_1202".tr,
                                                    style: theme
                                                        .textTheme.titleLarge,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 6.h),
                                                      child: Text(
                                                        "lbl182".tr,
                                                        style: CustomTextStyles
                                                            .bodySmall10,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "lbl236".tr,
                                        style: theme.textTheme.bodySmall,
                                      )
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: VerticalDivider(
                                    width: 1.h,
                                    thickness: 1.h,
                                    color: appTheme.blueGray10001,
                                    endIndent: 4.h,
                                  ),
                                ),
                                _buildStacktwentyfour(
                                  twentyfourTwo: "lbl_80".tr,
                                  three: "lbl182".tr,
                                  one: "lbl237".tr,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 6.h)
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
                          SizedBox(height: 4.h),
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
                                          "lbl_373".tr,
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
                                          "lbl_373".tr,
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
                                          "lbl_373".tr,
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
                                          "lbl_373".tr,
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
                                          "lbl_373".tr,
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
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(8.h, 12.h, 8.h, 10.h),
                            decoration: AppDecoration.outlineGray,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "lbl_373".tr,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyMedium,
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    "msg_2023_03_23_14_32".tr,
                                    textAlign: TextAlign.right,
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
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildStacktwentyfour({
    required String twentyfourTwo,
    required String three,
    required String one,
  }) {
    return SizedBox(
      height: 44.h,
      width: 42.h,
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
                        twentyfourTwo,
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: Text(
                            three,
                            style: CustomTextStyles.bodySmall10.copyWith(
                              color: theme.colorScheme.errorContainer,
                            ),
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
              one,
              style: theme.textTheme.bodySmall!.copyWith(
                color: theme.colorScheme.errorContainer,
              ),
            ),
          )
        ],
      ),
    );
  }
}
