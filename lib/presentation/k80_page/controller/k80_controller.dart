import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/alert_record.dart';
import 'package:pulsedevice/core/hiveDb/alert_record_list_storage.dart';
import 'package:pulsedevice/core/hiveDb/heart_rate_setting_storage.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/presentation/k80_page/model/k80_model.dart';
import 'package:pulsedevice/presentation/k80_page/model/list_item_model.dart';

import 'package:pulsedevice/presentation/k87_bottomsheet/controller/k87_controller.dart';
import 'package:pulsedevice/presentation/k87_bottomsheet/k87_bottomsheet.dart';
import 'package:pulsedevice/presentation/k88_bottomsheet/controller/k88_controller.dart';
import 'package:pulsedevice/presentation/k88_bottomsheet/k88_bottomsheet.dart';
import 'package:pulsedevice/presentation/one7_bottomsheet/controller/one7_controller.dart';
import 'package:pulsedevice/presentation/one7_bottomsheet/one7_bottomsheet.dart';

class K80Controller extends GetxController {
  final gc = Get.find<GlobalController>();
  final k80ModelObj = K80Model().obs;
  final userId = ''.obs;
  RxInt currentIndex = 0.obs; // 預設日
  RxInt recordIndex = 0.obs; // 預設報警記錄
  RxString formattedRange = ''.obs;
  List<String> timeTabs = ['lbl229'.tr, 'lbl230'.tr, 'lbl231'.tr];
  List<String> recordTabs = ['lbl238'.tr, 'lbl239'.tr];
  Rx<DateTime> currentDate = DateTime.now().obs;
  final pressureVal = '0'.obs;
  final loadDataTime = ''.obs;
  final isAlert = false.obs;
  final normalCount = 0.obs;
  final highCount = 0.obs;
  final lowCount = 0.obs;
  final normalMinCount = 0.obs;
  final hightMinCount = 0.obs;
  final lowMinCount = 0.obs;
  final alertRecords = <AlertRecord>[].obs;
  final pressureData = [].obs;

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

    // List<pressureDataData> res = [];

    // if (currentIndex.value == 0) {
    //   res = await gc.pressureDataService.getDaily(userId.value, date);
    // } else if (currentIndex.value == 1) {
    //   res = await gc.pressureDataService.getWeekly(userId.value, date);
    // } else if (currentIndex.value == 2) {
    //   res = await gc.pressureDataService.getMonthly(userId.value, date);
    // }

    // if (res.isEmpty) {
    //   clearData();
    //   return;
    // }

    // res.sort((a, b) => a.startTimeStamp.compareTo(b.startTimeStamp));

    // final lastData = res.last;
    // loadDataTime.value =
    //     DateTimeUtils.getTimeDifferenceString(lastData.startTimeStamp);
    // heartRateVal.value = lastData.heartRate.toString();

    // final heartSettings = HeartRateSettingStorage.getUserProfile(userId.value);
    // final heartRateList = res.map((e) => e.heartRate).toList();

    // final min = heartRateList.reduce((a, b) => a < b ? a : b);
    // final max = heartRateList.reduce((a, b) => a > b ? a : b);
    // final avg = heartRateList.reduce((a, b) => a + b) / heartRateList.length;

    // normalMinCount.value = avg.toInt();
    // hightMinCount.value = max;
    // lowMinCount.value = min;

    // if (heartSettings != null && heartSettings.alertEnabled) {
    //   final setLow = heartSettings.lowThreshold;
    //   final setHigh = heartSettings.highThreshold;
    //   final minCount = heartRateList.where((e) => e <= setLow).length;
    //   final maxCount = heartRateList.where((e) => e >= setHigh).length;
    //   lowCount.value = minCount;
    //   highCount.value = maxCount;
    //   normalCount.value = res.length - minCount - maxCount;
    // } else {
    //   normalCount.value = res.length;
    // }

    /// 歷史紀錄
    // final list = res.map((m) {
    //   final date = DateTime.fromMillisecondsSinceEpoch(m.startTimeStamp * 1000);
    //   return ListHistoryItemModel(
    //     unit: Rx('lbl180'.tr),
    //     value: Rx(m.heartRate.toString()),
    //     time: Rx(date),
    //   );
    // }).toList();
    // k80ModelObj.value.listItemList2.value = list;

    /// 圖表
    // pressureData.assignAll(res);

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
            r.type.contains('pressure') &&
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
        unit: Rx('lbl180'.tr),
      );
    }).toList();

    k80ModelObj.value.listItemList.value = alertList;
  }

  /// 繪製圖表--日
  // List<FlSpot> buildDaySpots(List<pressureDataData> data) {
  //   if (data.isEmpty) return [];

  //   final base =
  //       DateTime.fromMillisecondsSinceEpoch(data.first.startTimeStamp * 1000);
  //   return data.map((e) {
  //     final current =
  //         DateTime.fromMillisecondsSinceEpoch(e.startTimeStamp * 1000);
  //     final diffMinutes = current.difference(base).inMinutes.toDouble();
  //     return FlSpot(diffMinutes, e.heartRate.toDouble());
  //   }).toList();
  // }

  /// 繪製圖表--週
  // List<FlSpot> buildWeeklySpots(
  //     List<pressureDataData> data, DateTime startDate) {
  //   List<FlSpot> spots = [];
  //   for (int i = 0; i < 7; i++) {
  //     final day = startDate.add(Duration(days: i));
  //     final dayStart = DateTime(day.year, day.month, day.day);
  //     final dayEnd =
  //         dayStart.add(Duration(days: 1)).subtract(Duration(milliseconds: 1));
  //     final dayData = data.where((e) {
  //       final timestamp =
  //           DateTime.fromMillisecondsSinceEpoch(e.startTimeStamp * 1000);
  //       return timestamp
  //               .isAfter(dayStart.subtract(Duration(milliseconds: 1))) &&
  //           timestamp.isBefore(dayEnd.add(Duration(milliseconds: 1)));
  //     }).toList();

  //     if (dayData.isNotEmpty) {
  //       final avg = dayData.map((e) => e.heartRate).reduce((a, b) => a + b) /
  //           dayData.length;
  //       spots.add(FlSpot(i.toDouble(), avg));
  //     } else {
  //       spots.add(FlSpot(i.toDouble(), 0));
  //     }
  //   }
  //   return spots;
  // }

  /// 繪製圖表--月
  // List<FlSpot> buildMonthlySpots(
  //     List<pressureDataData> data, DateTime startDate) {
  //   List<FlSpot> spots = [];
  //   final daysInMonth =
  //       DateUtils.getDaysInMonth(startDate.year, startDate.month);
  //   for (int i = 0; i < daysInMonth; i++) {
  //     final day = DateTime(startDate.year, startDate.month, i + 1);
  //     final dayStart = DateTime(day.year, day.month, day.day);
  //     final dayEnd =
  //         dayStart.add(Duration(days: 1)).subtract(Duration(milliseconds: 1));
  //     final dayData = data.where((e) {
  //       final timestamp =
  //           DateTime.fromMillisecondsSinceEpoch(e.startTimeStamp * 1000);
  //       return timestamp
  //               .isAfter(dayStart.subtract(Duration(milliseconds: 1))) &&
  //           timestamp.isBefore(dayEnd.add(Duration(milliseconds: 1)));
  //     }).toList();

  //     if (dayData.isNotEmpty) {
  //       final avg = dayData.map((e) => e.heartRate).reduce((a, b) => a + b) /
  //           dayData.length;
  //       spots.add(FlSpot((i + 1).toDouble(), avg));
  //     } else {
  //       spots.add(FlSpot((i + 1).toDouble(), 0));
  //     }
  //   }
  //   return spots;
  // }

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
      if (pressureData.isEmpty) {
        data = [];
        titles = SideTitles(showTitles: false);
      } else {
        final base = DateTime.fromMillisecondsSinceEpoch(
            pressureData.first.startTimeStamp * 1000);

        data = pressureData.map((e) {
          final current =
              DateTime.fromMillisecondsSinceEpoch(e.startTimeStamp * 1000);
          final diffMinutes = current.difference(base).inMinutes.toDouble();
          return FlSpot(diffMinutes, e.heartRate.toDouble());
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
      if (pressureData.isEmpty) {
        data = [];
        titles = SideTitles(showTitles: false);
      } else {
        final startOfWeek = currentDate.value
            .subtract(Duration(days: currentDate.value.weekday - 1));
        final Map<int, List<int>> dayData = {};

        for (var e in pressureData) {
          final date =
              DateTime.fromMillisecondsSinceEpoch(e.startTimeStamp * 1000);
          final diffDays = date.difference(startOfWeek).inDays;
          if (diffDays >= 0 && diffDays < 7) {
            dayData.putIfAbsent(diffDays, () => []).add(e.heartRate);
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
      if (pressureData.isEmpty) {
        data = [];
        titles = SideTitles(showTitles: false);
      } else {
        final startOfMonth =
            DateTime(currentDate.value.year, currentDate.value.month, 1);
        final Map<int, List<int>> dayData = {};

        for (var e in pressureData) {
          final date =
              DateTime.fromMillisecondsSinceEpoch(e.startTimeStamp * 1000);
          final diffDays = date.difference(startOfMonth).inDays;
          if (diffDays >= 0 && diffDays < 31) {
            dayData.putIfAbsent(diffDays, () => []).add(e.heartRate);
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
      minY: 40,
      maxY: 140,
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
        horizontalInterval: 20,
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
            interval: 20,
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
    pressureData.clear();
    pressureVal.value = '';
    loadDataTime.value = '';
    isAlert.value = false;

    normalCount.value = 0;
    highCount.value = 0;
    lowCount.value = 0;
    normalMinCount.value = 0;
    hightMinCount.value = 0;
    lowMinCount.value = 0;

    k80ModelObj.value.listItemList.value.clear(); // 報警紀錄
    k80ModelObj.value.listItemList2.value.clear(); // 歷史紀錄
  }
}
