import 'package:flutter/material.dart';
import 'package:pulsedevice/core/chat_screen_controller.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/sqliteDb/health_data_sync_service.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/presentation/k19_screen/controller/k19_controller.dart';
import 'package:pulsedevice/presentation/k67_screen/models/k67_model.dart';
import 'package:pulsedevice/presentation/k73_screen/models/family_item_model.dart';
import '../../../core/app_export.dart';
import '../models/k73_model.dart';

/// A controller class for the K73Screen.
///
/// This class manages the state of the K73Screen, including the
/// current k73ModelObj
class K73Controller extends GetxController with WidgetsBindingObserver {
  TextEditingController searchController = TextEditingController();
  final gc = Get.find<GlobalController>();
  final chatScreenController = Get.find<ChatScreenController>();
  final k19Controller = Get.find<K19Controller>();
  ApiService apiService = ApiService();

  Rx<K73Model> k73ModelObj = K73Model().obs;

  final loadDataTime = "".obs;
  final familySelectedIndex = 0.obs;
  final hasFamily = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onReady() {
    super.onReady();
    print("k73 controller onInit");
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // getData();
      getFamilyData();
      getHealthData();
    }
  }

  /// 路由到個人頁面
  void goK29Screen() {
    Get.toNamed(AppRoutes.k29Page);
  }

  /// 路由到健康-心率頁面
  void gok77Screen() {
    Get.toNamed(AppRoutes.k77Page);
  }

  /// 路由到健康-控制主頁面
  void gok76Screen(int index) async {
    final res = await Get.toNamed(AppRoutes.k76Screen, arguments: index);
    if (res != null) {
      // getData();
      await getFamilyData();
      await getHealthData(
          familyId: gc.familyId.value, familyName: gc.familyName.value);
    }
  }

  /// 路由到開始運動頁面
  void gok5Screen() {
    Get.toNamed(AppRoutes.k5Screen);
  }

  /// 路由到我的設備頁面
  void goK40Screen() {
    Get.toNamed(AppRoutes.k40Screen);
  }

  /// 路由到諮詢頁面
  void goK19Screen() {
    Get.toNamed(AppRoutes.k19Screen);
  }

  /// 展開諮詢頁面
  void onSendPressed() {
    final str = searchController.value.text.trim();
    gc.chatInput.value = str;
    searchController.clear();
    k19Controller.handleIncomingChatFromK73(gc.chatInput.value);
  }

  Future<void> getData(Map<String, dynamic> res) async {
    print("k73 controller getData");
    // var res = await gc.healthDataSyncService.getAnalysisHealthData();
    if (res.isEmpty) return;
    k73ModelObj.value.listviewItemList.value[0].loadTime?.value =
        res["heartDuration"].toString();
    k73ModelObj.value.listviewItemList.value[0].value?.value =
        res["heartRate"].toString();
    k73ModelObj.value.listviewItemList.value[0].isAlert?.value =
        res["heartAlert"];
    k73ModelObj.value.listviewItemList.value[1].loadTime?.value =
        res["combinedDuration"].toString();
    k73ModelObj.value.listviewItemList.value[1].value?.value =
        res["bloodOxygen"].toString();
    k73ModelObj.value.listviewItemList.value[1].isAlert?.value =
        res["bloodAlert"];
    k73ModelObj.value.listviewItemList.value[2].loadTime?.value =
        res["combinedDuration"].toString();
    k73ModelObj.value.listviewItemList.value[2].value?.value =
        res["temperature"].toString();
    k73ModelObj.value.listviewItemList.value[2].isAlert?.value =
        res["tempAlert"];
    k73ModelObj.value.listviewItemList.value[3].loadTime?.value =
        res["combinedDuration"].toString();
    k73ModelObj.value.listviewItemList.value[3].value?.value = "0";
    k73ModelObj.value.listviewItemList.value[4].loadTime?.value =
        res["stepDuration"].toString();
    k73ModelObj.value.listviewItemList.value[4].value?.value =
        res["stepCount"].toString();
    k73ModelObj.value.listviewItemList.value[5].loadTime?.value =
        res["sleepDuration"]?.toString() ?? '';
    k73ModelObj.value.listviewItemList.value[5].value?.value =
        res["sleepTime"]?.toString() ?? '';
    k73ModelObj.value.listviewItemList.value[6].loadTime?.value =
        res["stepDuration"].toString();
    k73ModelObj.value.listviewItemList.value[6].value?.value =
        res["calories"].toString();
    k73ModelObj.value.listviewItemList.value[7].loadTime?.value =
        res["stepDuration"].toString();
    k73ModelObj.value.listviewItemList.value[7].value?.value =
        res["stepDistance"].toString();
    k73ModelObj.value.listviewItemList.refresh();
    loadDataTime.value = res["loadDataTime"].toString();
  }

  Future<Map<String, dynamic>> getAnalysisHealthDataFromApi(
      HealthDataSet healthData) async {
    final stepList = healthData.stepData;
    final sleepList = healthData.sleepData;
    final heartList = healthData.rateData;
    final oxygenList = healthData.oxygenData;
    final tempList = healthData.temperatureData;
    final caloriesList = healthData.caloriesData;
    final distanceList = healthData.distanceData;

    // Sort
    stepList.sort((a, b) => a.startTimestamp.compareTo(b.startTimestamp));
    heartList.sort((a, b) => a.startTimestamp.compareTo(b.startTimestamp));
    oxygenList.sort((a, b) => a.startTimestamp.compareTo(b.startTimestamp));
    tempList.sort((a, b) => a.startTimestamp.compareTo(b.startTimestamp));
    caloriesList.sort((a, b) => a.startTimestamp.compareTo(b.startTimestamp));
    distanceList.sort((a, b) => a.startTimestamp.compareTo(b.startTimestamp));

    // 最後一筆時間點
    final stepLast = stepList.last;
    final heartLast = heartList.last;
    final oxygenLast = oxygenList.last;
    final tempLast = tempList.last;

    // 統計
    int stepCount = sumLastDayValues<StepData>(
      list: stepList,
      startTimeGetter: (e) => e.startTimestamp,
      valueGetter: (e) => int.parse(e.step),
    );
    int stepDistance = sumLastDayValues<DistanceData>(
      list: distanceList,
      startTimeGetter: (e) => e.startTimestamp,
      valueGetter: (e) => int.parse(e.distance),
    );
    int calories = sumLastDayValues<CaloriesData>(
      list: caloriesList,
      startTimeGetter: (e) => e.startTimestamp,
      valueGetter: (e) => int.parse(e.calories),
    );

    // 顯示用文字
    String stepDuration =
        DateTimeUtils.getTimeDifferenceString(stepLast.startTimestamp);
    int heartRate = int.parse(heartLast.heartrate);
    String heartDuration =
        DateTimeUtils.getTimeDifferenceString(heartLast.startTimestamp);
    double temperature = double.parse(tempLast.temperature);
    String combinedDuration =
        DateTimeUtils.getTimeDifferenceString(tempLast.startTimestamp);
    int bloodOxygen = int.parse(oxygenLast.bloodoxygen);

    final loadDataTime = DateTimeUtils.formatMaxTimestamp(
      stepLast.startTimestamp,
      heartLast.startTimestamp,
      tempLast.startTimestamp,
    );

    var heartAlert = heartLast.type == "1" || heartLast.type == "2";
    var bloodAlert = oxygenLast.type == "2";
    var tempAlert = tempLast.type == "1" || tempLast.type == "2";

    var analysis = {
      "stepCount": stepCount,
      "stepDistance": stepDistance,
      "stepDuration": stepDuration,
      "calories": calories,
      "heartRate": heartRate,
      "heartDuration": heartDuration,
      "heartAlert": heartAlert,
      "bloodOxygen": bloodOxygen,
      "bloodAlert": bloodAlert,
      "combinedDuration": combinedDuration,
      "temperature": temperature,
      "tempAlert": tempAlert,
      "loadDataTime": loadDataTime
    };

    if (sleepList.isNotEmpty) {
      sleepList.sort((a, b) => a.startTimestamp.compareTo(b.startTimestamp));
      final sleepLast = sleepList.last;
      final sleepTotalSecond = calculateLastDayTotalSeconds<SleepData>(
        list: sleepList,
        startTimeGetter: (e) => e.startTimestamp,
        endTimeGetter: (e) => e.endTimestamp,
      );
      final sleepTime = (sleepTotalSecond / 3600).toStringAsFixed(1);
      String sleepDuration =
          DateTimeUtils.getTimeDifferenceString(sleepLast.endTimestamp);

      analysis.addAll({
        "sleepTime": sleepTime,
        "sleepDuration": sleepDuration,
      });
    }

    return analysis;
  }

  int calculateLastDayTotalSeconds<T>({
    required List<T> list,
    required int Function(T item) startTimeGetter,
    required int Function(T item) endTimeGetter,
  }) {
    if (list.isEmpty) return 0;

    // 1. 排序
    list.sort((a, b) => startTimeGetter(a).compareTo(startTimeGetter(b)));

    // 2. 取得最後一筆的 yyyy-MM-dd 字串
    final lastDate =
        DateTime.fromMillisecondsSinceEpoch(startTimeGetter(list.last) * 1000)
            .toIso8601String()
            .substring(0, 10); // yyyy-MM-dd

    // 3. 過濾出當日資料
    final sameDayList = list.where((e) {
      final date =
          DateTime.fromMillisecondsSinceEpoch(startTimeGetter(e) * 1000)
              .toIso8601String()
              .substring(0, 10);
      return date == lastDate;
    });

    // 4. 加總秒數
    final totalSeconds = sameDayList.fold<int>(
      0,
      (sum, item) => sum + (endTimeGetter(item) - startTimeGetter(item)),
    );

    return totalSeconds;
  }

  int sumLastDayValues<T>({
    required List<T> list,
    required int Function(T item) startTimeGetter,
    required int Function(T item) valueGetter,
  }) {
    if (list.isEmpty) return 0;

    // 1. 排序
    list.sort((a, b) => startTimeGetter(a).compareTo(startTimeGetter(b)));

    // 2. 取得最後一天日期（yyyy-MM-dd）
    final lastDate =
        DateTime.fromMillisecondsSinceEpoch(startTimeGetter(list.last) * 1000)
            .toIso8601String()
            .substring(0, 10);

    // 3. 過濾出同一天資料
    final sameDayList = list.where((e) {
      final dateStr =
          DateTime.fromMillisecondsSinceEpoch(startTimeGetter(e) * 1000)
              .toIso8601String()
              .substring(0, 10);
      return dateStr == lastDate;
    });

    // 4. 加總該欄位
    return sameDayList.fold<int>(0, (sum, item) => sum + valueGetter(item));
  }

  /// 取得家族清單-api
  Future<void> getFamilyData() async {
    try {
      // LoadingHelper.show();
      final payload = {"userID": gc.apiId.value};
      final res = await apiService.postJson(Api.familyList, payload);
      // LoadingHelper.hide();
      if (res.isNotEmpty && res["message"] == "SUCCESS") {
        final data = res["data"];
        if (data == null) return;
        if (data is List) {
          final modelList = data.map<FamilyItemModel>((e) {
            final map = e as Map<String, dynamic>; // 安全轉型
            gc.familyName.value = map["abbreviation"] ?? '';
            return FamilyItemModel(
              two: RxString(map["abbreviation"] ?? ''),
              tf: RxString("更新時間：${map["create_at"] ?? ''}"),
              path: RxString(map["family_avatar_url"] ?? ''),
              isAlert: RxBool(map["notify"]),
              familyId: RxString(map["family_id"] ?? ''),
            );
          }).toList(); // <- 轉成 List<FamilyItemModel>
          if (modelList.isEmpty) return;
          final my = FamilyItemModel(
            two: RxString('我自己'),
            path: RxString(gc.avatarUrl.value),
          );
          modelList.insert(0, my);
          k73ModelObj.value.familyItemList.value = modelList;
          k73ModelObj.value.familyItemList.refresh();
        }
      }
    } catch (e) {
      print("getFamilyData Error: $e");
    }
  }

  ///取得健康資料-api
  Future<void> getHealthData({String? familyId, String? familyName}) async {
    try {
      var fId = "";
      if (familyId != null) {
        fId = familyId;
        gc.familyId.value = fId;
        gc.familyName.value = familyName!;
      } else {
        gc.familyId.value = "";
        gc.familyName.value = "";
      }

      // LoadingHelper.show();
      final nowStr = DateTime.now().format(pattern: 'yyyy-MM-dd');
      final payload = {
        "startTime": nowStr,
        "endTime": nowStr,
        "userID": fId.isEmpty ? gc.apiId.value : fId,
        "type": "ALL"
      };
      final res = await apiService.postJson(Api.healthRecordList, payload);
      // LoadingHelper.hide();
      if (res.isNotEmpty && res["message"] == "SUCCESS") {
        final data = res["data"];
        if (data == null) return;
        final healthData = HealthDataSet.fromJson(data);
        final healthMap = await getAnalysisHealthDataFromApi(healthData);
        getData(healthMap);
      }
    } catch (e) {
      LoadingHelper.hide();
      print("getFamilyData Error: $e");
    }
  }
}
