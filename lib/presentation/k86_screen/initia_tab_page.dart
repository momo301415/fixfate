import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_text_form_field.dart';
import './models/chart_one_chart_model.dart';
import 'controller/k86_controller.dart';
import 'models/initia_tab_model.dart';

// ignore_for_file: must_be_immutable
class InitiaTabPage extends StatelessWidget {
  InitiaTabPage({Key? key})
      : super(
          key: key,
        );

  K86Controller controller = Get.put(K86Controller());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 12.h,
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  spacing: 24,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 124.h,
                      width: 310.h,
                      margin: EdgeInsets.only(right: 16.h),
                      child: Obx(
                        () => BarChart(
                          BarChartData(
                            minY: 0,
                            maxY: 4,
                            barTouchData: BarTouchData(enabled: true),
                            borderData: FlBorderData(show: false),
                            barGroups: List.generate(
                              controller.initiaTabModelObj.value
                                  .chartOneChartModelObj.value.length,
                              (index) {
                                var model = controller.initiaTabModelObj.value
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
                    Container(
                      width: 344.h,
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
                                  padding: EdgeInsets.only(left: 8.h),
                                  child: Text(
                                    "lbl_2380".tr,
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
                                  padding: EdgeInsets.only(left: 8.h),
                                  child: Text(
                                    "lbl_2380".tr,
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
                                  padding: EdgeInsets.only(left: 8.h),
                                  child: Text(
                                    "lbl_2380".tr,
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
                                  padding: EdgeInsets.only(left: 8.h),
                                  child: Text(
                                    "lbl_2380".tr,
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
                              left: 16.h,
                              right: 8.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "lbl_2380".tr,
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
