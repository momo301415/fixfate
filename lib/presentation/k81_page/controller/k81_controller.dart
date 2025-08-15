import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/app_export.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/presentation/k73_screen/models/k73_model.dart';
import 'package:pulsedevice/presentation/k81_page/mdoel/k81_model.dart';
import 'package:pulsedevice/presentation/k81_page/mdoel/list_item_model.dart';
import 'package:pulsedevice/presentation/k87_bottomsheet/controller/k87_controller.dart';
import 'package:pulsedevice/presentation/k87_bottomsheet/k87_bottomsheet.dart';
import 'package:pulsedevice/presentation/k88_bottomsheet/controller/k88_controller.dart';
import 'package:pulsedevice/presentation/k88_bottomsheet/k88_bottomsheet.dart';
import 'package:pulsedevice/presentation/one7_bottomsheet/controller/one7_controller.dart';
import 'package:pulsedevice/presentation/one7_bottomsheet/one7_bottomsheet.dart';

class K81Controller extends GetxController with WidgetsBindingObserver {
  final gc = Get.find<GlobalController>();
  final k81ModelObj = K81Model().obs;
  ApiService apiService = ApiService();
  final userId = ''.obs;
  RxInt currentIndex = 0.obs; // 預設日
  RxInt recordIndex = 0.obs; // 預設報警記錄
  RxString formattedRange = ''.obs;
  List<String> timeTabs = ['lbl229'.tr, 'lbl230'.tr, 'lbl231'.tr];
  List<String> recordTabs = ['lbl238'.tr, 'lbl239'.tr];
  Rx<DateTime> currentDate = DateTime.now().obs;
  final stepVal = ''.obs;
  final loadDataTime = ''.obs;
  final stepData = <StepDataData>[].obs;
  final stepApiData = <StepData>[].obs;
  final _maxY = 0.obs;
  final _interval = 0.obs;

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
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LoadingHelper.show();

      // 修正：預設顯示當前日期所在週的週一
      if (currentIndex.value == 1) {
        final today = DateTime.now();
        final weekStart = today.subtract(Duration(days: today.weekday - 1));
        currentDate.value = weekStart;
      }

      updateDateRange(currentIndex.value);
      LoadingHelper.hide();
    });
  }

  @override
  void onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      updateDateRange(currentIndex.value);
    }
  }

  /// 輸入日期讀取數據
  Future<void> loadDataByDate(DateTime date, {bool isLoading = true}) async {
    userId.value = gc.userId.value;
    final range = DateTimeUtils.getRangeByIndex(date, currentIndex.value);
    final start = range['start']!;
    final end = range['end']!;

    try {
      if (isLoading) {
        LoadingHelper.show();
      }
      final payload = {
        "startTime": start.format(pattern: 'yyyy-MM-dd'),
        "endTime": end.format(pattern: 'yyyy-MM-dd'),
        "userID":
            gc.familyId.value.isEmpty ? gc.apiId.value : gc.familyId.value,
        "type": "step"
      };
      final res = await apiService.postJson(Api.healthRecordList, payload);
      if (isLoading) {
        LoadingHelper.hide();
      }
      if (res.isNotEmpty && res["message"] == "SUCCESS") {
        final data = res["data"];
        if (data == null || data["rateData"] is! List) {
          return;
        }
        clearData();
        final rateData = data["rateData"];
        List<StepData> parsed = [];
        if (rateData is List) {
          parsed = rateData.map((e) => StepData.fromJson(e)).toList();
        }

        parsed.sort((a, b) => a.startTimestamp.compareTo(b.startTimestamp));
        final lastData = parsed.last;
        loadDataTime.value =
            DateTimeUtils.getTimeDifferenceString(lastData.startTimestamp);
        final stepList = parsed.map((e) => int.parse(e.step)).toList();

        stepVal.value = stepList.fold<int>(0, (sum, e) => sum + e).toString();

        final rawMax =
            stepList.isEmpty ? 0 : stepList.reduce((a, b) => a > b ? a : b);
        final interval = rawMax == 0 ? 200 : (rawMax / 5).ceil();
        _interval.value = interval;
        _maxY.value = interval * 5;

        /// 圖表
        stepApiData.assignAll(parsed);
        parsed.sort((a, b) => b.startTimestamp.compareTo(a.startTimestamp));

        /// 歷史紀錄
        final list = parsed.map((m) {
          final date =
              DateTime.fromMillisecondsSinceEpoch(m.startTimestamp * 1000);
          return ListHistoryItemModel(
            unit: Rx('lbl187'.tr),
            value: Rx(m.step.toString()),
            time: Rx(date),
          );
        }).toList();
        k81ModelObj.value.listItemList2.value = list;
      }
    } catch (e) {
      print("getFamilyData Error: $e");
    }
  }

  // Future<void> loadDataByDate(DateTime date, {bool isLoading = true}) async {
  //   userId.value = gc.userId.value;

  //   List<StepDataData> res = [];

  //   if (currentIndex.value == 0) {
  //     res = await gc.stepDataService.getDaily(userId.value, date);
  //   } else if (currentIndex.value == 1) {
  //     res = await gc.stepDataService.getWeekly(userId.value, date);
  //   } else if (currentIndex.value == 2) {
  //     res = await gc.stepDataService.getMonthly(userId.value, date);
  //   }

  //   if (res.isEmpty) {
  //     clearData();
  //     return;
  //   }

  //   res.sort((a, b) => a.startTimeStamp.compareTo(b.startTimeStamp));

  //   final lastData = res.last;
  //   loadDataTime.value =
  //       DateTimeUtils.getTimeDifferenceString(lastData.startTimeStamp);
  //   final stepList = res.map((e) => e.step).toList();

  //   stepVal.value = stepList.fold<int>(0, (sum, e) => sum + e).toString();

  //   final rawMax =
  //       stepList.isEmpty ? 0 : stepList.reduce((a, b) => a > b ? a : b);
  //   final interval = rawMax == 0 ? 200 : (rawMax / 5).ceil();
  //   _interval.value = interval;
  //   _maxY.value = interval * 5;

  //   /// 歷史紀錄
  //   final list = res.map((m) {
  //     final date = DateTime.fromMillisecondsSinceEpoch(m.startTimeStamp * 1000);
  //     return ListHistoryItemModel(
  //       unit: Rx('lbl187'.tr),
  //       value: Rx(m.step.toString()),
  //       time: Rx(date),
  //     );
  //   }).toList();
  //   k81ModelObj.value.listItemList2.value = list;

  //   /// 圖表
  //   stepData.assignAll(res);
  // }

  Future<void> updateDateRange(int index, {bool isLoading = true}) async {
    if (index == 0) {
      formattedRange.value =
          "${currentDate.value.format(pattern: 'M月d日, EEEE', locale: 'zh_CN')}";
      loadDataByDate(currentDate.value, isLoading: isLoading);
    } else if (index == 1) {
      // 修正：計算週一到週日的範圍
      final startOfWeek = currentDate.value
          .subtract(Duration(days: currentDate.value.weekday - 1));
      final endOfWeek = startOfWeek.add(Duration(days: 6));
      formattedRange.value =
          '${startOfWeek.format(pattern: 'M月d日')} ～ ${endOfWeek.format(pattern: 'M月d日')}';
      loadDataByDate(currentDate.value, isLoading: isLoading);
    } else {
      formattedRange.value =
          "${currentDate.value.year}年 ${currentDate.value.month}月";
      loadDataByDate(currentDate.value, isLoading: isLoading);
    }
  }

  void prevDateRange(int index) {
    if (index == 0) {
      currentDate.value = currentDate.value.subtract(const Duration(days: 1));
    } else if (index == 1) {
      // 修正：移動到上一週的週一
      final currentWeekStart = currentDate.value
          .subtract(Duration(days: currentDate.value.weekday - 1));
      final prevWeekStart = currentWeekStart.subtract(Duration(days: 7));
      currentDate.value = prevWeekStart;
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
      // 修正：移動到下一週的週一
      final currentWeekStart = currentDate.value
          .subtract(Duration(days: currentDate.value.weekday - 1));
      final nextWeekStart = currentWeekStart.add(Duration(days: 7));
      currentDate.value = nextWeekStart;
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
      if (stepApiData.isEmpty) {
        data = [];
        titles = SideTitles(showTitles: false);
      } else {
        final base = DateTime(
          currentDate.value.year,
          currentDate.value.month,
          currentDate.value.day,
        );

        data = stepApiData.map((e) {
          final current =
              DateTime.fromMillisecondsSinceEpoch(e.startTimestamp * 1000);
          final diffMinutes = current.difference(base).inMinutes.toDouble();
          return FlSpot(diffMinutes, double.parse(e.step));
        }).toList();

        titles = SideTitles(
          showTitles: true,
          interval: 240, // 每 240 分鐘（即 4 小時）
          getTitlesWidget: (value, meta) {
            // 固定顯示整點時間
            final hours = (value ~/ 60) % 24;
            return Transform.translate(
              offset: Offset(0, 12.h),
              child: Text(
                '${hours.toString().padLeft(2, '0')}:00',
                style: const TextStyle(fontSize: 10),
              ),
            );
          },
        );
      }
    } else if (index == 1) {
      // 週：星期
      if (stepApiData.isEmpty) {
        data = [];
        titles = SideTitles(showTitles: false);
      } else {
        // 修正：計算週一開始的日期
        final startOfWeek = currentDate.value
            .subtract(Duration(days: currentDate.value.weekday - 1));
        final Map<int, List<int>> dayData = {};

        for (var e in stepApiData) {
          final date =
              DateTime.fromMillisecondsSinceEpoch(e.startTimestamp * 1000);
          final diffDays = date.difference(startOfWeek).inDays;
          if (diffDays >= 0 && diffDays < 7) {
            dayData.putIfAbsent(diffDays, () => []).add(int.parse(e.step));
          }
        }

        data = dayData.entries.map((entry) {
          final avg = entry.value.reduce((a, b) => a + b) / entry.value.length;
          return FlSpot(entry.key.toDouble(), avg);
        }).toList();

        // 修正：生成標準的週標籤（週一到週日）
        final weekLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

        titles = SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: (value, meta) {
            final dayIndex = value.toInt();
            if (dayIndex >= 0 && dayIndex < weekLabels.length) {
              return Transform.translate(
                  offset: Offset(0, 12.h),
                  child: Text(weekLabels[dayIndex],
                      style: TextStyle(fontSize: 10)));
            }
            return Text('');
          },
        );
      }
    } else {
      // 月：日期
      if (stepApiData.isEmpty) {
        data = [];
        titles = SideTitles(showTitles: false);
      } else {
        final startOfMonth =
            DateTime(currentDate.value.year, currentDate.value.month, 1);
        final Map<int, List<int>> dayData = {};

        for (var e in stepApiData) {
          final date =
              DateTime.fromMillisecondsSinceEpoch(e.startTimestamp * 1000);
          final diffDays = date.difference(startOfMonth).inDays;
          if (diffDays >= 0 && diffDays < 31) {
            dayData.putIfAbsent(diffDays, () => []).add(int.parse(e.step));
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
            final day = value.toInt();

            if (day == 1 || day % 5 == 0) {
              return Transform.translate(
                  offset: Offset(0, 12.h),
                  child:
                      Text('${value.toInt()}', style: TextStyle(fontSize: 10)));
            }
            return const SizedBox.shrink();
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

    double? minX;
    double? maxX;

    if (index == 0) {
      // 日：時間（單位分鐘，最多1440分鐘）
      minX = 0;
      maxX = 1440;
    } else if (index == 1) {
      // 週：7天
      minX = 0;
      maxX = 6;
    } else if (index == 2) {
      // 月：天數取決於當月天數
      final daysInMonth = DateUtils.getDaysInMonth(
        currentDate.value.year,
        currentDate.value.month,
      );
      minX = 1;
      maxX = daysInMonth.toDouble();
    }

    return LineChartData(
      clipData: FlClipData.all(),
      maxX: maxX,
      minX: minX,
      minY: 0,
      maxY: _maxY.value.toDouble(),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
        horizontalInterval: _interval.value.toDouble(),
        getDrawingHorizontalLine: (value) {
          if (value == 0 || value == _maxY.value.toDouble()) {
            return FlLine(color: Colors.grey, strokeWidth: 1);
          }
          return FlLine(color: Colors.grey, strokeWidth: 1);
        },
      ),
      extraLinesData: ExtraLinesData(
        horizontalLines: [
          HorizontalLine(
            y: 0,
            color: Colors.grey,
            strokeWidth: 1,
          ),
          HorizontalLine(
            y: _maxY.value.toDouble(),
            color: Colors.grey,
            strokeWidth: 1,
          ),
        ],
      ),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(sideTitles: titles),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: _interval.value.toDouble(),
            reservedSize: 36,
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
          isCurved: false,
          color: Colors.teal,
          barWidth: 2,
          dotData: FlDotData(show: false),
        )
      ],
      borderData: FlBorderData(show: false),
    );
  }
  // LineChartData getChartData(int index) {
  //   List<FlSpot> data;
  //   SideTitles titles;

  //   if (index == 0) {
  //     // 日：時間顯示
  //     if (stepData.isEmpty) {
  //       data = [];
  //       titles = SideTitles(showTitles: false);
  //     } else {
  //       final base = DateTime.fromMillisecondsSinceEpoch(
  //           stepData.first.startTimeStamp * 1000);

  //       data = stepData.map((e) {
  //         final current =
  //             DateTime.fromMillisecondsSinceEpoch(e.startTimeStamp * 1000);
  //         final diffMinutes = current.difference(base).inMinutes.toDouble();
  //         return FlSpot(diffMinutes, e.step.toDouble());
  //       }).toList();

  //       titles = SideTitles(
  //         showTitles: true,
  //         interval: 240, // 每 240 分鐘（即 4 小時）
  //         getTitlesWidget: (value, meta) {
  //           final timestamp = base.add(Duration(minutes: value.toInt()));
  //           return Transform.translate(
  //               offset: Offset(0, 12.h),
  //               child: Text(
  //                 timestamp.format(pattern: 'HH:mm'),
  //                 style: const TextStyle(fontSize: 10),
  //               ));
  //         },
  //       );
  //     }
  //   } else if (index == 1) {
  //     // 週：星期
  //     if (stepData.isEmpty) {
  //       data = [];
  //       titles = SideTitles(showTitles: false);
  //     } else {
  //       final startOfWeek = DateTime(
  //         currentDate.value.year,
  //         currentDate.value.month,
  //         currentDate.value.day,
  //       ).subtract(Duration(days: currentDate.value.weekday - 1));
  //       final Map<int, List<int>> dayData = {};

  //       for (var e in stepData) {
  //         final date =
  //             DateTime.fromMillisecondsSinceEpoch(e.startTimeStamp * 1000);
  //         final diffDays = date.difference(startOfWeek).inDays;
  //         if (diffDays >= 0 && diffDays < 7) {
  //           dayData.putIfAbsent(diffDays, () => []).add(e.step);
  //         }
  //       }

  //       data = dayData.entries.map((entry) {
  //         final avg = entry.value.reduce((a, b) => a + b) / entry.value.length;
  //         return FlSpot(entry.key.toDouble(), avg);
  //       }).toList();

  //       final weekLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  //       titles = SideTitles(
  //         showTitles: true,
  //         interval: 1,
  //         getTitlesWidget: (value, meta) {
  //           if (value.toInt() >= 0 && value.toInt() < weekLabels.length) {
  //             return Transform.translate(
  //                 offset: Offset(0, 12.h),
  //                 child: Text(weekLabels[value.toInt()],
  //                     style: TextStyle(fontSize: 10)));
  //           }
  //           return Text('');
  //         },
  //       );
  //     }
  //   } else {
  //     // 月：日期
  //     if (stepData.isEmpty) {
  //       data = [];
  //       titles = SideTitles(showTitles: false);
  //     } else {
  //       final startOfMonth =
  //           DateTime(currentDate.value.year, currentDate.value.month, 1);
  //       final Map<int, List<int>> dayData = {};

  //       for (var e in stepData) {
  //         final date =
  //             DateTime.fromMillisecondsSinceEpoch(e.startTimeStamp * 1000);
  //         final diffDays = date.difference(startOfMonth).inDays;
  //         if (diffDays >= 0 && diffDays < 31) {
  //           dayData.putIfAbsent(diffDays, () => []).add(e.step);
  //         }
  //       }

  //       data = dayData.entries.map((entry) {
  //         final avg = entry.value.reduce((a, b) => a + b) / entry.value.length;
  //         return FlSpot(entry.key.toDouble() + 1, avg);
  //       }).toList();

  //       titles = SideTitles(
  //         showTitles: true,
  //         interval: 5,
  //         getTitlesWidget: (value, meta) {
  //           final day = value.toInt();

  //           if (day == 1 || day % 5 == 0) {
  //             return Transform.translate(
  //                 offset: Offset(0, 12.h),
  //                 child:
  //                     Text('${value.toInt()}', style: TextStyle(fontSize: 10)));
  //           }
  //           return const SizedBox.shrink();
  //         },
  //       );
  //     }
  //   }

  //   if (data.isEmpty) {
  //     return LineChartData(
  //       lineBarsData: [],
  //       titlesData: FlTitlesData(show: false),
  //       gridData: FlGridData(show: false),
  //       borderData: FlBorderData(show: false),
  //     );
  //   }

  //   double? minX;
  //   double? maxX;

  //   if (index == 0) {
  //     // 日：時間（單位分鐘，最多1440分鐘）
  //     minX = 0;
  //     maxX = 1440;
  //   } else if (index == 1) {
  //     // 週：7天
  //     minX = 0;
  //     maxX = 6;
  //   } else if (index == 2) {
  //     // 月：天數取決於當月天數
  //     final daysInMonth = DateUtils.getDaysInMonth(
  //       currentDate.value.year,
  //       currentDate.value.month,
  //     );
  //     minX = 1;
  //     maxX = daysInMonth.toDouble();
  //   }

  //   return LineChartData(
  //     clipData: FlClipData.all(),
  //     maxX: maxX,
  //     minX: minX,
  //     minY: 0,
  //     maxY: _maxY.value.toDouble(),
  //     gridData: FlGridData(
  //       show: true,
  //       drawHorizontalLine: true,
  //       drawVerticalLine: false,
  //       horizontalInterval: _interval.value.toDouble(),
  //       getDrawingHorizontalLine: (value) {
  //         if (value == 0 || value == _maxY.value.toDouble()) {
  //           return FlLine(color: Colors.grey, strokeWidth: 1);
  //         }
  //         return FlLine(color: Colors.grey, strokeWidth: 1);
  //       },
  //     ),
  //     extraLinesData: ExtraLinesData(
  //       horizontalLines: [
  //         HorizontalLine(
  //           y: 0,
  //           color: Colors.grey,
  //           strokeWidth: 1,
  //         ),
  //         HorizontalLine(
  //           y: _maxY.value.toDouble(),
  //           color: Colors.grey,
  //           strokeWidth: 1,
  //         ),
  //       ],
  //     ),
  //     titlesData: FlTitlesData(
  //       bottomTitles: AxisTitles(sideTitles: titles),
  //       leftTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           interval: _interval.value.toDouble(),
  //           reservedSize: 36,
  //           getTitlesWidget: (value, meta) =>
  //               Text('${value.toInt()}', style: TextStyle(fontSize: 10)),
  //         ),
  //       ),
  //       topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
  //       rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
  //     ),
  //     lineBarsData: [
  //       LineChartBarData(
  //         spots: data,
  //         isCurved: false,
  //         color: Colors.teal,
  //         barWidth: 2,
  //         dotData: FlDotData(show: false),
  //       )
  //     ],
  //     borderData: FlBorderData(show: false),
  //   );
  // }

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
          updateDateRange(0, isLoading: false);
        },
      ),
    );
  }

  Future<void> selectWeekDate() async {
    final controller = Get.put(K88Controller());

    // 修正：設定初始日期為當前選擇週的週一
    final currentWeekStart = currentDate.value
        .subtract(Duration(days: currentDate.value.weekday - 1));
    controller.setInitialDate(currentWeekStart);

    await showModalBottomSheet(
      context: Get.context!,
      builder: (_) => K88Bottomsheet(
        onConfirm: (int year, int month, int day) {
          final selected = DateTime(year, month, day);
          // 修正：自動調整到該日期所在週的週一
          final weekStart =
              selected.subtract(Duration(days: selected.weekday - 1));
          currentDate.value = weekStart;
          updateDateRange(1, isLoading: false);
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
          updateDateRange(2, isLoading: false);
        },
      ),
    );
  }

  void clearData() {
    stepData.clear();
    stepApiData.clear();
    stepVal.value = '';
    loadDataTime.value = '';

    k81ModelObj.value.listItemList2.value.clear(); // 歷史紀錄
    k81ModelObj.value.listItemList2.refresh();
  }
}
