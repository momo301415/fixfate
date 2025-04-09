import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/app_export.dart';
import 'chart_one_chart_model.dart';

/// This class defines the variables used in the [k78_page],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class K78Model {
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
}
