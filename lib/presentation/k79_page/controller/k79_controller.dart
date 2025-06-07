import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/alert_record.dart';
import 'package:pulsedevice/core/hiveDb/alert_record_list_storage.dart';
import 'package:pulsedevice/core/hiveDb/body_temperature_setting_storage.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/presentation/k79_page/models/list_item_model.dart';
import 'package:pulsedevice/presentation/k87_bottomsheet/controller/k87_controller.dart';
import 'package:pulsedevice/presentation/k87_bottomsheet/k87_bottomsheet.dart';
import 'package:pulsedevice/presentation/k88_bottomsheet/controller/k88_controller.dart';
import 'package:pulsedevice/presentation/k88_bottomsheet/k88_bottomsheet.dart';
import 'package:pulsedevice/presentation/one7_bottomsheet/controller/one7_controller.dart';
import 'package:pulsedevice/presentation/one7_bottomsheet/one7_bottomsheet.dart';
import '../../../core/app_export.dart';
import '../models/k79_model.dart';

/// A controller class for the K79Page.
///
/// This class manages the state of the K79Page, including the
/// current k79ModelObj
class K79Controller extends GetxController {
  final k79ModelObj = K79Model().obs;
  final gc = Get.find<GlobalController>();
  final userId = ''.obs;
  RxInt currentIndex = 0.obs; // 預設日
  RxInt recordIndex = 0.obs; // 預設報警記錄
  RxString formattedRange = ''.obs;
  List<String> timeTabs = ['lbl229'.tr, 'lbl230'.tr, 'lbl231'.tr];
  List<String> recordTabs = ['lbl238'.tr, 'lbl239'.tr];
  Rx<DateTime> currentDate = DateTime.now().obs;
  final tempratureVal = ''.obs;
  final loadDataTime = ''.obs;
  final isAlert = false.obs;
  final normalCount = 0.obs;
  final highCount = 0.obs;
  final lowCount = 0.obs;
  final normalMinCount = ''.obs;
  final hightMinCount = ''.obs;
  final lowMinCount = ''.obs;
  final alertRecords = <AlertRecord>[].obs;
  final tempratureData = <CombinedDataData>[].obs;

  // 模擬資料
  final List<FlSpot> weeklyData = [
    FlSpot(0, 0),
  ].obs;

  final List<FlSpot> monthlyData = [
    FlSpot(0, 0),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LoadingHelper.show();
      updateDateRange(currentIndex.value);
      LoadingHelper.hide();
    });
  }

  /// 輸入日期讀取數據
  Future<void> loadDataByDate(DateTime date) async {
    userId.value = gc.userId.value;

    List<CombinedDataData> res = [];

    if (currentIndex.value == 0) {
      res = await gc.combinedDataService.getDaily(userId.value, date);
    } else if (currentIndex.value == 1) {
      res = await gc.combinedDataService.getWeekly(userId.value, date);
    } else if (currentIndex.value == 2) {
      res = await gc.combinedDataService.getMonthly(userId.value, date);
    }

    if (res.isEmpty) {
      clearData();
      return;
    }

    res.sort((a, b) => a.startTimeStamp.compareTo(b.startTimeStamp));

    final lastData = res.last;
    loadDataTime.value =
        DateTimeUtils.getTimeDifferenceString(lastData.startTimeStamp);
    tempratureVal.value = lastData.temperature.toStringAsFixed(1);

    final tempSettings =
        BodyTemperatureSettingStorage.getUserProfile(userId.value);
    final tempList = res.map((e) => e.temperature).toList();

    final min = tempList.reduce((a, b) => a < b ? a : b);
    final max = tempList.reduce((a, b) => a > b ? a : b);
    final avg = tempList.reduce((a, b) => a + b) / tempList.length;

    normalMinCount.value = avg.toStringAsFixed(1);
    hightMinCount.value = max.toStringAsFixed(1);
    lowMinCount.value = min.toStringAsFixed(1);

    if (tempSettings != null && tempSettings.alertEnabled) {
      final setLow = double.parse(tempSettings.lowThreshold);
      final setHigh = double.parse(tempSettings.highThreshold);
      final minCount = tempList.where((e) => e <= setLow).length;
      final maxCount = tempList.where((e) => e >= setHigh).length;
      lowCount.value = minCount;
      highCount.value = maxCount;
      normalCount.value = res.length - minCount - maxCount;
    } else {
      normalCount.value = res.length;
    }

    /// 歷史紀錄
    final list = res.map((m) {
      final date = DateTime.fromMillisecondsSinceEpoch(m.startTimeStamp * 1000);
      return ListHistoryItemModel(
        unit: Rx('lbl_c'.tr),
        value: Rx(m.temperature.toStringAsFixed(1)),
        time: Rx(date),
      );
    }).toList();
    k79ModelObj.value.listItemList2.value = list;

    /// 圖表
    tempratureData.assignAll(res);

    // 警報紀錄（根據模式切換）
    final records = await AlertRecordListStorage.getRecords(userId.value);

    // 根據 currentIndex 判斷範圍
    DateTime startRange;
    DateTime endRange;

    if (currentIndex.value == 0) {
      // 日
      startRange = DateTime(date.year, date.month, date.day);
      endRange = startRange
          .add(const Duration(days: 1))
          .subtract(const Duration(milliseconds: 1));
    } else if (currentIndex.value == 1) {
      // 週
      startRange = date.subtract(Duration(days: date.weekday - 1));
      endRange = startRange
          .add(const Duration(days: 7))
          .subtract(const Duration(milliseconds: 1));
    } else {
      // 月
      startRange = DateTime(date.year, date.month, 1);
      endRange = DateTime(date.year, date.month + 1, 1)
          .subtract(const Duration(milliseconds: 1));
    }

    final selectRecords = records
        .where((r) =>
            r.type.contains('temperature') &&
            r.time.isAfter(
                startRange.subtract(const Duration(milliseconds: 1))) &&
            r.time.isBefore(endRange.add(const Duration(milliseconds: 1))))
        .toList();

    alertRecords.assignAll(selectRecords);

    final alertList = selectRecords.map((m) {
      return ListRecordItemModel(
        label: Rx(m.label),
        value: Rx(m.value ?? ''),
        time: Rx(m.time),
        unit: Rx('lbl_c'.tr),
      );
    }).toList();

    k79ModelObj.value.listItemList.value = alertList;
  }

  /// 繪製圖表--日
  List<FlSpot> buildDaySpots(List<CombinedDataData> data) {
    if (data.isEmpty) return [];

    final base =
        DateTime.fromMillisecondsSinceEpoch(data.first.startTimeStamp * 1000);
    return data.map((e) {
      final current =
          DateTime.fromMillisecondsSinceEpoch(e.startTimeStamp * 1000);
      final diffMinutes = current.difference(base).inMinutes.toDouble();
      return FlSpot(diffMinutes, e.temperature.toDouble());
    }).toList();
  }

  /// 繪製圖表--週
  List<FlSpot> buildWeeklySpots(
      List<CombinedDataData> data, DateTime startDate) {
    List<FlSpot> spots = [];
    for (int i = 0; i < 7; i++) {
      final day = startDate.add(Duration(days: i));
      final dayStart = DateTime(day.year, day.month, day.day);
      final dayEnd =
          dayStart.add(Duration(days: 1)).subtract(Duration(milliseconds: 1));
      final dayData = data.where((e) {
        final timestamp =
            DateTime.fromMillisecondsSinceEpoch(e.startTimeStamp * 1000);
        return timestamp
                .isAfter(dayStart.subtract(Duration(milliseconds: 1))) &&
            timestamp.isBefore(dayEnd.add(Duration(milliseconds: 1)));
      }).toList();

      if (dayData.isNotEmpty) {
        final avg = dayData.map((e) => e.temperature).reduce((a, b) => a + b) /
            dayData.length;
        spots.add(FlSpot(i.toDouble(), avg));
      } else {
        spots.add(FlSpot(i.toDouble(), 0));
      }
    }
    return spots;
  }

  /// 繪製圖表--月
  List<FlSpot> buildMonthlySpots(
      List<CombinedDataData> data, DateTime startDate) {
    List<FlSpot> spots = [];
    final daysInMonth =
        DateUtils.getDaysInMonth(startDate.year, startDate.month);
    for (int i = 0; i < daysInMonth; i++) {
      final day = DateTime(startDate.year, startDate.month, i + 1);
      final dayStart = DateTime(day.year, day.month, day.day);
      final dayEnd =
          dayStart.add(Duration(days: 1)).subtract(Duration(milliseconds: 1));
      final dayData = data.where((e) {
        final timestamp =
            DateTime.fromMillisecondsSinceEpoch(e.startTimeStamp * 1000);
        return timestamp
                .isAfter(dayStart.subtract(Duration(milliseconds: 1))) &&
            timestamp.isBefore(dayEnd.add(Duration(milliseconds: 1)));
      }).toList();

      if (dayData.isNotEmpty) {
        final avg = dayData.map((e) => e.temperature).reduce((a, b) => a + b) /
            dayData.length;
        spots.add(FlSpot((i + 1).toDouble(), avg));
      } else {
        spots.add(FlSpot((i + 1).toDouble(), 0));
      }
    }
    return spots;
  }

  SideTitles getDailyTitles(DateTime baseTime) {
    return SideTitles(
      showTitles: true,
      interval: 240, // 每 4 小時 = 240 分鐘
      getTitlesWidget: (value, meta) {
        final time = baseTime.add(Duration(minutes: value.toInt()));
        return Text(
          time.format(pattern: 'HH:mm'),
          style: const TextStyle(fontSize: 10),
        );
      },
    );
  }

  SideTitles getWeeklyTitles() {
    const weekLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return SideTitles(
      showTitles: true,
      interval: 1,
      getTitlesWidget: (value, meta) {
        final index = value.toInt();
        if (index >= 0 && index < weekLabels.length) {
          return Text(weekLabels[index], style: TextStyle(fontSize: 10));
        }
        return Text('');
      },
    );
  }

  SideTitles getMonthlyTitles() {
    return SideTitles(
      showTitles: true,
      interval: 5,
      getTitlesWidget: (value, meta) {
        final day = value.toInt();
        if (day % 5 == 0 || day == 1) {
          return Text('$day', style: TextStyle(fontSize: 10));
        }
        return Text('');
      },
    );
  }

  Future<void> updateDateRange(int index) async {
    if (index == 0) {
      formattedRange.value =
          "${currentDate.value.format(pattern: 'M月d日, EEEE', locale: 'zh_CN')}";
      loadDataByDate(currentDate.value);
    } else if (index == 1) {
      final start = currentDate.value
          .subtract(Duration(days: currentDate.value.weekday - 1));
      final end = start.add(Duration(days: 6));
      formattedRange.value =
          '${start.format(pattern: 'M月d日')} ～ ${end.format(pattern: 'M月d日')}';
      loadDataByDate(currentDate.value);
    } else {
      formattedRange.value =
          "${currentDate.value.year}年 ${currentDate.value.month}月";
      loadDataByDate(currentDate.value);
    }
  }

  void prevDateRange(int index) {
    if (index == 0) {
      currentDate.value = currentDate.value.subtract(const Duration(days: 1));
    } else if (index == 1) {
      currentDate.value = currentDate.value.subtract(const Duration(days: 7));
    } else {
      currentDate.value = DateTime(
        currentDate.value.year,
        currentDate.value.month - 1,
        currentDate.value.day,
      );
    }
    updateDateRange(index);
  }

  void nextDateRange(int index) {
    if (index == 0) {
      currentDate.value = currentDate.value.add(const Duration(days: 1));
    } else if (index == 1) {
      currentDate.value = currentDate.value.add(const Duration(days: 7));
    } else {
      currentDate.value = DateTime(
        currentDate.value.year,
        currentDate.value.month + 1,
        currentDate.value.day,
      );
    }
    updateDateRange(index);
  }

  LineChartData getChartData(int index) {
    List<FlSpot> data;
    SideTitles titles;

    if (index == 0) {
      // 日：時間顯示
      if (tempratureData.isEmpty) {
        data = [];
        titles = SideTitles(showTitles: false);
      } else {
        final base = DateTime.fromMillisecondsSinceEpoch(
            tempratureData.first.startTimeStamp * 1000);

        data = tempratureData.map((e) {
          final current =
              DateTime.fromMillisecondsSinceEpoch(e.startTimeStamp * 1000);
          final diffMinutes = current.difference(base).inMinutes.toDouble();
          return FlSpot(diffMinutes, e.temperature.toDouble());
        }).toList();

        titles = SideTitles(
          showTitles: true,
          interval: 240, // 每 240 分鐘（即 4 小時）
          getTitlesWidget: (value, meta) {
            final timestamp = base.add(Duration(minutes: value.toInt()));
            return Text(
              timestamp.format(pattern: 'HH:mm'),
              style: const TextStyle(fontSize: 10),
            );
          },
        );
      }
    } else if (index == 1) {
      // 週：星期
      if (tempratureData.isEmpty) {
        data = [];
        titles = SideTitles(showTitles: false);
      } else {
        final startOfWeek = currentDate.value
            .subtract(Duration(days: currentDate.value.weekday - 1));
        final Map<int, List<int>> dayData = {};

        for (var e in tempratureData) {
          final date =
              DateTime.fromMillisecondsSinceEpoch(e.startTimeStamp * 1000);
          final diffDays = date.difference(startOfWeek).inDays;
          if (diffDays >= 0 && diffDays < 7) {
            dayData.putIfAbsent(diffDays, () => []).add(e.temperature.toInt());
          }
        }

        data = dayData.entries.map((entry) {
          final avg = entry.value.reduce((a, b) => a + b) / entry.value.length;
          return FlSpot(entry.key.toDouble(), avg);
        }).toList();

        final weekLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        titles = SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: (value, meta) {
            if (value.toInt() >= 0 && value.toInt() < weekLabels.length) {
              return Text(weekLabels[value.toInt()],
                  style: TextStyle(fontSize: 10));
            }
            return Text('');
          },
        );
      }
    } else {
      // 月：日期
      if (tempratureData.isEmpty) {
        data = [];
        titles = SideTitles(showTitles: false);
      } else {
        final startOfMonth =
            DateTime(currentDate.value.year, currentDate.value.month, 1);
        final Map<int, List<int>> dayData = {};

        for (var e in tempratureData) {
          final date =
              DateTime.fromMillisecondsSinceEpoch(e.startTimeStamp * 1000);
          final diffDays = date.difference(startOfMonth).inDays;
          if (diffDays >= 0 && diffDays < 31) {
            dayData.putIfAbsent(diffDays, () => []).add(e.temperature.toInt());
          }
        }

        data = dayData.entries.map((entry) {
          final avg = entry.value.reduce((a, b) => a + b) / entry.value.length;
          return FlSpot(entry.key.toDouble() + 1, avg);
        }).toList();

        titles = SideTitles(
          showTitles: true,
          interval: 5,
          getTitlesWidget: (value, meta) {
            if (value.toInt() % 5 == 0) {
              return Text('${value.toInt()}', style: TextStyle(fontSize: 10));
            }
            return Text('');
          },
        );
      }
    }

    if (data.isEmpty) {
      return LineChartData(
        lineBarsData: [],
        titlesData: FlTitlesData(show: false),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
      );
    }

    return LineChartData(
      minY: 35.0,
      maxY: 40.0,
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.grey,
          strokeWidth: 1,
        ),
      ),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(sideTitles: titles),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1.0,
            getTitlesWidget: (value, meta) =>
                Text('${value.toInt()}', style: TextStyle(fontSize: 10)),
          ),
        ),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: data,
          isCurved: true,
          curveSmoothness: 0.2,
          color: Colors.teal,
          barWidth: 2,
          dotData: FlDotData(show: false),
        )
      ],
      borderData: FlBorderData(show: false),
    );
  }

  //----- 日期選擇器
  Future<void> datePicker(int index) async {
    switch (index) {
      case 0:
        await selectDayDate();
        break;
      case 1:
        await selectWeekDate();
        break;
      case 2:
        await selectMothDate();
        break;
    }
  }

  Future<void> selectDayDate() async {
    final controller = Get.put(K87Controller());
    controller.setInitialDate(currentDate.value);
    await showModalBottomSheet(
      context: Get.context!,
      builder: (_) => K87Bottomsheet(
        onConfirm: (int year, int month, int day) {
          final selected = DateTime(year, month, day);
          currentDate.value = selected;
          updateDateRange(0);
        },
      ),
    );
  }

  Future<void> selectWeekDate() async {
    final controller = Get.put(K88Controller());
    controller.setInitialDate(currentDate.value);
    await showModalBottomSheet(
      context: Get.context!,
      builder: (_) => K88Bottomsheet(
        onConfirm: (int year, int month, int day) {
          final selected = DateTime(year, month, day);
          currentDate.value = selected;
          updateDateRange(1);
        },
      ),
    );
  }

  Future<void> selectMothDate() async {
    final controller = Get.put(One7Controller());
    // 設定初始值（同步顯示）
    controller.year.value = currentDate.value.year;
    controller.month.value = currentDate.value.month;
    await showModalBottomSheet(
      context: Get.context!,
      builder: (_) => One7Bottomsheet(
        onConfirm: (int year, int month) {
          final selected = DateTime(year, month, 1);
          currentDate.value = selected;
          updateDateRange(2);
        },
      ),
    );
  }

  void clearData() {
    tempratureData.clear();
    tempratureVal.value = '';
    loadDataTime.value = '';
    isAlert.value = false;

    normalCount.value = 0;
    highCount.value = 0;
    lowCount.value = 0;
    normalMinCount.value = '';
    hightMinCount.value = '';
    lowMinCount.value = '';

    k79ModelObj.value.listItemList.value.clear(); // 報警紀錄
    k79ModelObj.value.listItemList2.value.clear(); // 歷史紀錄
  }
}
