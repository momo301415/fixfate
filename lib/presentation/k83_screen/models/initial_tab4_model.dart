import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/app_export.dart';
import 'chart_one_chart_model.dart';
import 'list_item_model.dart';
import 'listtwentyfour_item_model.dart';

/// This class is used in the [initial_tab4_page] screen.

// ignore_for_file: must_be_immutable
class InitialTab4Model {
  Rx<List<ChartOneChartModel>> chartOneChartModelObj = Rx([
    ChartOneChartModel(
      x: 0,
      barRods: [
        BarChartRodData(
          toY: 1.23,
        ),
        BarChartRodData(
          toY: 2.45,
        )
      ],
    ),
    ChartOneChartModel(
      x: 1,
      barRods: [
        BarChartRodData(
          toY: 1.12,
        ),
        BarChartRodData(
          toY: 2.34,
        )
      ],
    ),
    ChartOneChartModel(
      x: 2,
      barRods: [
        BarChartRodData(
          toY: 2.13,
        ),
        BarChartRodData(
          toY: 3.25,
        )
      ],
    ),
    ChartOneChartModel(
      x: 3,
      barRods: [
        BarChartRodData(
          toY: 1.47,
        ),
        BarChartRodData(
          toY: 2.89,
        )
      ],
    )
  ]);

  Rx<List<ListtwentyfourItemModel>> listtwentyfourItemList = Rx([
    ListtwentyfourItemModel(
        twentyfour: "lbl_52".tr.obs, tf: "lbl161".tr.obs, tf1: "lbl246".tr.obs),
    ListtwentyfourItemModel(
        twentyfour: "lbl_32".tr.obs, tf: "lbl161".tr.obs, tf1: "lbl247".tr.obs),
    ListtwentyfourItemModel(
        twentyfour: "lbl_32".tr.obs, tf: "lbl161".tr.obs, tf1: "lbl248".tr.obs)
  ]);

  Rx<List<ListItemModel>> listItemList = Rx([
    ListItemModel(tf: "lbl239".tr.obs),
    ListItemModel(),
    ListItemModel(),
    ListItemModel(),
    ListItemModel(),
    ListItemModel()
  ]);
}
