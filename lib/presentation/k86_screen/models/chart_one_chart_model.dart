import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// ignore_for_file: must_be_immutable
class ChartOneChartModel {
  ChartOneChartModel({this.x = 1, this.barRods = const <BarChartRodData>[]});

  int x = 2;

  List<BarChartRodData> barRods;
}
