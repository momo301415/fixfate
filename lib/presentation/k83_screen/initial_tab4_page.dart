import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/app_export.dart';
import './models/chart_one_chart_model.dart';
import 'controller/k83_controller.dart';
import 'models/initial_tab4_model.dart';
import 'models/list_item_model.dart';
import 'models/listtwentyfour_item_model.dart';
import 'widgets/list_item_widget.dart';
import 'widgets/listtwentyfour_item_widget.dart';

// ignore_for_file: must_be_immutable
class InitialTab4Page extends StatelessWidget {
  InitialTab4Page({Key? key})
      : super(
          key: key,
        );

  K83Controller controller = Get.put(K83Controller());

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
                  children: [
                    Container(
                      height: 124.h,
                      width: 310.h,
                      margin: EdgeInsets.only(
                        left: 16.h,
                        right: 14.h,
                      ),
                      child: Obx(
                        () => BarChart(
                          BarChartData(
                            minY: 0,
                            maxY: 4,
                            barTouchData: BarTouchData(enabled: true),
                            borderData: FlBorderData(show: false),
                            barGroups: List.generate(
                              controller.initialTab4ModelObj.value
                                  .chartOneChartModelObj.value.length,
                              (index) {
                                var model = controller.initialTab4ModelObj.value
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
                    _buildListtwentyfour(),
                    SizedBox(height: 8.h),
                    _buildColumn()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildListtwentyfour() {
    return Container(
      height: 72.h,
      padding: EdgeInsets.symmetric(
        horizontal: 42.h,
        vertical: 8.h,
      ),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      width: double.maxFinite,
      child: Obx(
        () => ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: 42.h,
            vertical: 8.h,
          ),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 21.0.h),
              child: VerticalDivider(
                width: 1.h,
                thickness: 1.h,
                color: appTheme.blueGray10001,
              ),
            );
          },
          itemCount: controller
              .initialTab4ModelObj.value.listtwentyfourItemList.value.length,
          itemBuilder: (context, index) {
            ListtwentyfourItemModel model = controller
                .initialTab4ModelObj.value.listtwentyfourItemList.value[index];
            return ListtwentyfourItemWidget(
              model,
            );
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumn() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller
                  .initialTab4ModelObj.value.listItemList.value.length,
              itemBuilder: (context, index) {
                ListItemModel model = controller
                    .initialTab4ModelObj.value.listItemList.value[index];
                return ListItemWidget(
                  model,
                );
              },
            ),
          ),
          SizedBox(height: 12.h)
        ],
      ),
    );
  }
}
