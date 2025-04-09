import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_text_form_field.dart';
import './models/chart_one_chart_model.dart';
import 'controller/k82_controller.dart';
import 'models/initial_tab3_model.dart';

// ignore_for_file: must_be_immutable
class InitialTab3Page extends StatelessWidget {
  InitialTab3Page({Key? key})
      : super(
          key: key,
        );

  K82Controller controller = Get.put(K82Controller());

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
                              controller.initialTab3ModelObj.value
                                  .chartOneChartModelObj.value.length,
                              (index) {
                                var model = controller.initialTab3ModelObj.value
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
                        borderRadius: BorderRadiusStyle.circleBorder2,
                      ),
                      child: Column(
                        spacing: 10,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.only(right: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
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
                                                    "lbl_242".tr,
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
                                  alignment: Alignment.bottomCenter,
                                  child: VerticalDivider(
                                    width: 1.h,
                                    thickness: 1.h,
                                    color: appTheme.gray500,
                                    endIndent: 4.h,
                                  ),
                                ),
                                _buildStacktwentyfour(
                                  twentyfourTwo: "lbl_22".tr,
                                  two: "lbl161".tr,
                                  one: "lbl244".tr,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: VerticalDivider(
                                    width: 1.h,
                                    thickness: 1.h,
                                    color: appTheme.gray500,
                                    endIndent: 4.h,
                                  ),
                                ),
                                _buildStacktwentyfour(
                                  twentyfourTwo: "lbl_22".tr,
                                  two: "lbl161".tr,
                                  one: "lbl245".tr,
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(horizontal: 6.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildColumntwentyfou(
                                  twentyfourFour: "lbl_562".tr,
                                  one: "lbl235".tr,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: VerticalDivider(
                                    width: 1.h,
                                    thickness: 1.h,
                                    color: appTheme.gray500,
                                    endIndent: 4.h,
                                  ),
                                ),
                                _buildColumntwentyfou(
                                  twentyfourFour: "lbl_892".tr,
                                  one: "lbl236".tr,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: VerticalDivider(
                                    width: 1.h,
                                    thickness: 1.h,
                                    color: appTheme.gray500,
                                    endIndent: 4.h,
                                  ),
                                ),
                                SizedBox(
                                  height: 44.h,
                                  width: 26.h,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "lbl_83".tr,
                                          style: theme.textTheme.titleLarge,
                                        ),
                                      ),
                                      Text(
                                        "lbl237".tr,
                                        style: theme.textTheme.bodySmall,
                                      )
                                    ],
                                  ),
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
                            hintStyle:
                                CustomTextStyles.titleSmallErrorContainer,
                            textInputAction: TextInputAction.done,
                            contentPadding:
                                EdgeInsets.fromLTRB(18.h, 12.h, 18.h, 8.h),
                            borderDecoration:
                                TextFormFieldStyleHelper.underLine,
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
                                  padding: EdgeInsets.only(left: 30.h),
                                  child: Text(
                                    "lbl_582".tr,
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
                                  padding: EdgeInsets.only(left: 30.h),
                                  child: Text(
                                    "lbl_582".tr,
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
                                  padding: EdgeInsets.only(left: 30.h),
                                  child: Text(
                                    "lbl_582".tr,
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
                                  padding: EdgeInsets.only(left: 30.h),
                                  child: Text(
                                    "lbl_582".tr,
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
                                  padding: EdgeInsets.only(left: 30.h),
                                  child: Text(
                                    "lbl_582".tr,
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
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildColumntwentyfou({
    required String twentyfourFour,
    required String one,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          twentyfourFour,
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        Text(
          one,
          style: theme.textTheme.bodySmall!.copyWith(
            color: theme.colorScheme.errorContainer,
          ),
        )
      ],
    );
  }

  /// Common widget
  Widget _buildStacktwentyfour({
    required String twentyfourTwo,
    required String two,
    required String one,
  }) {
    return SizedBox(
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
                            two,
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
          Text(
            one,
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.errorContainer,
            ),
          )
        ],
      ),
    );
  }
}
