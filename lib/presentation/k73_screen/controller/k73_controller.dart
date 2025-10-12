import 'package:flutter/material.dart';
import 'package:pulsedevice/core/chat_screen_controller.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/service/firebase_analytics_service.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/presentation/k19_screen/controller/k19_controller.dart';
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
  K19Controller get k19Controller => Get.find<K19Controller>();
  ApiService apiService = ApiService();

  Rx<K73Model> k73ModelObj = K73Model().obs;

  final loadDataTime = "".obs;
  final familySelectedIndex = 0.obs;
  final hasFamily = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    // 📊 記錄健康數據頁面瀏覽事件
    FirebaseAnalyticsService.instance.logViewHealthHeartrateDataPage(
      dataType: 'health_overview',
    );

    /// 測試用帳號，有要測試數據就打開
    // gc.apiId.value = 'aa6b8da8c6324c6f92bf876ca5b84e5a';
  }

  @override
  void onReady() {
    super.onReady();
    print("k73 controller onInit");
    getFamilyData();
    getHealthData();
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

  /// 路由到飲食記錄頁面
  void goK13Screen() {
    Get.toNamed(AppRoutes.k13Screen);
  }

  /// 路由到填寫身體資料頁面
  void goK27Screen() {
    Get.toNamed(AppRoutes.k27Screen);
  }

  /// 展開諮詢頁面
  void onSendPressed() {
    final str = searchController.value.text.trim();
    if (str.isEmpty) return;

    // 🔥 直接保證：立即設置K19顯示狀態
    chatScreenController.isK19Visible.value = true;

    // 設置預設內容
    gc.chatInput.value = str;
    searchController.clear();

    // 調用現有邏輯（保持不變）
    k19Controller.handleIncomingChatFromK73(gc.chatInput.value);
  }

  Future<void> getData(Map<String, dynamic> res) async {
    print("k73 controller getData");
    if (res.isEmpty) return;

    // 使用常量定義索引，避免魔術數字
    const int HEART_INDEX = 0;
    const int OXYGEN_INDEX = 1;
    const int TEMP_INDEX = 2;
    const int PRESSURE_INDEX = 3;
    const int STEP_INDEX = 4;
    const int SLEEP_INDEX = 5;
    const int CALORIES_INDEX = 6;
    const int DISTANCE_INDEX = 7;

    // 安全更新心率數據
    _updateHealthItem(HEART_INDEX, {
      "loadTime": res["heartDuration"]?.toString() ?? "無數據",
      "value": res["heartRate"]?.toString() ?? "0",
      "isAlert": res["heartAlert"] ?? false,
    });

    // 安全更新血氧數據
    _updateHealthItem(OXYGEN_INDEX, {
      "loadTime": res["heartDuration"]?.toString() ?? "無數據",
      "value": res["bloodOxygen"]?.toString() ?? "0",
      "isAlert": res["bloodAlert"] ?? false,
    });

    // 安全更新體溫數據
    _updateHealthItem(TEMP_INDEX, {
      "loadTime": res["combinedDuration"]?.toString() ?? "無數據",
      "value": res["temperature"]?.toString() ?? "0.0",
      "isAlert": res["tempAlert"] ?? false,
    });

    // 安全更新壓力數據
    _updateHealthItem(PRESSURE_INDEX, {
      "loadTime": res["pressureDuration"]?.toString() ?? "無數據",
      "value": res["pressure"]?.toString() ?? "0",
      "isAlert": res["pressureAlert"] ?? false,
    });

    // 安全更新步數數據
    _updateHealthItem(STEP_INDEX, {
      "loadTime": res["stepDuration"]?.toString() ?? "無數據",
      "value": res["stepCount"]?.toString() ?? "0",
      "isAlert": false, // 步數通常沒有警報
    });

    // 安全更新睡眠數據
    _updateHealthItem(SLEEP_INDEX, {
      "loadTime": res["sleepDuration"]?.toString() ?? "無數據",
      "value": res["sleepTime"]?.toString() ?? "0.0",
      "isAlert": false, // 睡眠通常沒有警報
    });

    // 安全更新卡路里數據
    _updateHealthItem(CALORIES_INDEX, {
      "loadTime": res["stepDuration"]?.toString() ?? "無數據",
      "value": res["calories"]?.toString() ?? "0",
      "isAlert": false, // 卡路里通常沒有警報
    });

    // 安全更新距離數據
    _updateHealthItem(DISTANCE_INDEX, {
      "loadTime": res["stepDuration"]?.toString() ?? "無數據",
      "value": res["stepDistance"]?.toString() ?? "0",
      "isAlert": false, // 距離通常沒有警報
    });

    k73ModelObj.value.listviewItemList.refresh();
    loadDataTime.value = res["loadDataTime"]?.toString() ?? "";
  }

  /// 安全更新健康項目數據
  void _updateHealthItem(int index, Map<String, dynamic> data) {
    if (index >= k73ModelObj.value.listviewItemList.value.length) {
      print("警告: 索引 $index 超出範圍");
      return;
    }

    final item = k73ModelObj.value.listviewItemList.value[index];
    item.loadTime?.value = data["loadTime"] ?? "";
    item.value?.value = data["value"] ?? "";
    item.isAlert?.value = data["isAlert"] ?? false;
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
    final pressureList = healthData.pressureData;

    // Sort - 只在列表不為空時排序
    if (stepList.isNotEmpty)
      stepList.sort((a, b) => a.startTimestamp.compareTo(b.startTimestamp));
    if (heartList.isNotEmpty)
      heartList.sort((a, b) => a.startTimestamp.compareTo(b.startTimestamp));
    if (oxygenList.isNotEmpty)
      oxygenList.sort((a, b) => a.startTimestamp.compareTo(b.startTimestamp));
    if (tempList.isNotEmpty)
      tempList.sort((a, b) => a.startTimestamp.compareTo(b.startTimestamp));
    if (caloriesList.isNotEmpty)
      caloriesList.sort((a, b) => a.startTimestamp.compareTo(b.startTimestamp));
    if (distanceList.isNotEmpty)
      distanceList.sort((a, b) => a.startTimestamp.compareTo(b.startTimestamp));
    if (pressureList.isNotEmpty)
      pressureList.sort((a, b) => a.startTimestamp.compareTo(b.startTimestamp));

    // 安全獲取最後一筆數據
    final stepLast = stepList.isNotEmpty ? stepList.last : null;
    final heartLast = heartList.isNotEmpty ? heartList.last : null;
    final oxygenLast = oxygenList.isNotEmpty ? oxygenList.last : null;
    final tempLast = tempList.isNotEmpty ? tempList.last : null;

    // 處理壓力數據
    List<PressureData> presLast = [];
    if (pressureList.isEmpty) {
      // 如果沒有壓力數據，使用心率數據的時間戳作為備用
      final fallbackTimestamp = heartLast?.startTimestamp ??
          DateTime.now().millisecondsSinceEpoch ~/ 1000;
      PressureData data = PressureData(
          startTimestamp: fallbackTimestamp, totalStressScore: 0, type: "0");
      presLast.add(data);
    } else {
      presLast = pressureList;
    }

    // 統計 - 使用安全的方法
    int stepCount = stepList.isNotEmpty
        ? sumLastDayValues<StepData>(
            list: stepList,
            startTimeGetter: (e) => e.startTimestamp,
            valueGetter: (e) => int.parse(e.step),
          )
        : 0;

    int stepDistance = distanceList.isNotEmpty
        ? sumLastDayValues<DistanceData>(
            list: distanceList,
            startTimeGetter: (e) => e.startTimestamp,
            valueGetter: (e) => int.parse(e.distance),
          )
        : 0;

    int calories = caloriesList.isNotEmpty
        ? sumLastDayValues<CaloriesData>(
            list: caloriesList,
            startTimeGetter: (e) => e.startTimestamp,
            valueGetter: (e) => int.parse(e.calories),
          )
        : 0;

    // 顯示用文字 - 安全處理
    String stepDuration = stepLast != null
        ? DateTimeUtils.getTimeDifferenceString(stepLast.startTimestamp)
        : "無數據";

    int heartRate = heartLast != null ? int.parse(heartLast.heartrate) : 0;
    String heartDuration = heartLast != null
        ? DateTimeUtils.getTimeDifferenceString(heartLast.startTimestamp)
        : "無數據";

    double temperature =
        tempLast != null ? double.parse(tempLast.temperature) : 0.0;
    String combinedDuration = tempLast != null
        ? DateTimeUtils.getTimeDifferenceString(tempLast.startTimestamp)
        : "無數據";

    int bloodOxygen =
        oxygenLast != null ? int.parse(oxygenLast.bloodoxygen) : 0;
    int pressure =
        presLast.isNotEmpty ? presLast.last.totalStressScore.toInt() : 0;

    // 安全處理時間戳
    final loadDataTime = DateTimeUtils.formatMaxTimestamp(
      stepLast?.startTimestamp ?? 0,
      heartLast?.startTimestamp ?? 0,
      tempLast?.startTimestamp ?? 0,
    );

    // 安全處理警報狀態
    var heartAlert = heartLast != null
        ? (heartLast.type == "1" || heartLast.type == "2")
        : false;
    var bloodAlert = oxygenLast != null ? oxygenLast.type == "2" : false;
    var tempAlert = tempLast != null
        ? (tempLast.type == "1" || tempLast.type == "2")
        : false;
    var presAlert = presLast.isNotEmpty
        ? (presLast.last.type == "1" || presLast.last.type == "2")
        : false;

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
      "loadDataTime": loadDataTime,
      "pressure": pressure,
      "pressureDuration": heartDuration,
      "pressureAlert": presAlert,
    };

    // 安全處理睡眠數據
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
    } else {
      // 如果沒有睡眠數據，提供預設值
      analysis.addAll({
        "sleepTime": "0.0",
        "sleepDuration": "無數據",
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

  ///刷新按鈕事件
  Future<void> onRefresh() async {
    LoadingHelper.show();
    await gc.syncDataService.runBackgroundSync();
    await gc.getBlueToothDeviceInfo();
    await getHealthData(
        familyId: gc.familyId.value, familyName: gc.familyName.value);
    await getFamilyData();
    LoadingHelper.hide();
    LoadingHelper.hide();
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
        if (data == null || data.length == 0) {
          print("家族數據為空");
          return;
        }
        if (data is List) {
          final modelList = data.map<FamilyItemModel>((e) {
            final map = e as Map<String, dynamic>; // 安全轉型
            gc.familyName.value = map["abbreviation"] ?? '';
            return FamilyItemModel(
              two: RxString(map["abbreviation"] ?? ''),
              tf: RxString("更新時間：${map["create_at"] ?? ''}"),
              path: RxString(map["family_avatar_url"] ?? ''),
              isAlert: RxBool(map["notify"] ?? false),
              familyId: RxString(map["family_id"] ?? ''),
            );
          }).toList(); // <- 轉成 List<FamilyItemModel>
          if (modelList.isEmpty) {
            print("家族模型列表為空");
            return;
          }
          final my = FamilyItemModel(
            two: RxString('我自己'),
            path: RxString(gc.avatarUrl.value),
          );
          modelList.insert(0, my);
          k73ModelObj.value.familyItemList.value = modelList;
          k73ModelObj.value.familyItemList.refresh();
        } else {
          print("家族數據格式錯誤，預期為 List 但收到 ${data.runtimeType}");
        }
      } else {
        print("家族 API 返回錯誤: ${res["message"] ?? "未知錯誤"}");
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
        if (data == null) {
          print("健康數據為空");
          return;
        }
        final healthData = HealthDataSet.fromJson(data);
        final healthMap = await getAnalysisHealthDataFromApi(healthData);
        await getData(healthMap);
      } else {
        print("API 返回錯誤: ${res["message"] ?? "未知錯誤"}");
      }
    } catch (e) {
      LoadingHelper.hide();
      print("getHealthData Error: $e");
    }
  }
}
