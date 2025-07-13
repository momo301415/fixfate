import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/sport_record.dart';
import 'package:pulsedevice/core/hiveDb/sport_record_list_storage.dart';
import 'package:pulsedevice/core/utils/snackbar_helper.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';
import '../../../core/app_export.dart';
import '../models/initial_tab_model.dart';
import '../models/k5_model.dart';

/// A controller class for the K5Screen.
///
/// This class manages the state of the K5Screen, including the
/// current k5ModelObj
class K5Controller extends GetxController
    with GetSingleTickerProviderStateMixin, WidgetsBindingObserver {
  Rx<K5Model> k5ModelObj = K5Model().obs;
  final gc = Get.find<GlobalController>();
  late TabController tabviewController;

  /// 0 = 有氧, 1 = 重訓
  Rx<int> tabIndex = 0.obs;

  Rx<InitialTabModel> initialTabModelObj = InitialTabModel().obs;

  /// 旗標：是否「正在運動」，只有這個為 true 時才處理運動資料
  bool _isListening = false;

  /// ✅ 運動事件處理器
  late Function(Map) _sportEventHandler;

  /// 上次運動時長
  RxInt lastHours = 0.obs;
  RxInt lastMinutes = 0.obs;
  RxInt lastSeconds = 0.obs;

  /// 心率、距離、步數的值
  RxInt bpm = 0.obs;
  RxInt distance = 0.obs;
  RxInt steps = 0.obs;
  RxInt calories = 0.obs;

  /// 是否開始運動
  RxBool isStart = false.obs;

  List<SportRecord> records = <SportRecord>[].obs;
  RxInt maxBpm = 0.obs;
  RxInt minBpm = 0.obs;

  /// 快取最後一次 onListening 的即時資料，方便 Resume 時刷新
  Map<String, int> _lastSportCache = {};

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    tabviewController = TabController(vsync: this, length: 2);
    print("初始化監聽藍牙狀態：${gc.blueToolStatus.value}");

    // ✅ 初始化運動事件處理器
    _sportEventHandler = _handleSportEvent;

    // ✅ 註冊全局運動事件監聽
    _registerGlobalSportListener();
  }

  @override
  void onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);

    // ✅ 清理事件處理器
    _unregisterGlobalSportListener();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // ✅ App 回前景，只刷新資料，監聽器由全局事件系統管理
      /// 若正在運動，把「快取的最後數值」再寫回一次，
      ///    觸發 Rx <=> UI 重新 build
      if (isStart.value && _lastSportCache.isNotEmpty) {
        bpm.value = _lastSportCache['bpm'] ?? bpm.value;
        distance.value = _lastSportCache['distance'] ?? distance.value;
        steps.value = _lastSportCache['steps'] ?? steps.value;
        calories.value = _lastSportCache['cal'] ?? calories.value;

        _updateTimeFields(_lastSportCache['sec'] ?? 0);
      }
    }
  }

  void syncData() async {
    initialTabModelObj.value.listeightysixItemList.value[0].eightysix!.value =
        bpm.value.toString();
    initialTabModelObj.value.listeightysixItemList.value[1].eightysix!.value =
        distance.value.toString();
    initialTabModelObj.value.listeightysixItemList.value[2].eightysix!.value =
        steps.value.toString();

    /// 取得運動資料
    final allRecords = await SportRecordListStorage.getRecords(gc.userId.value);

    // 根據 tabIndex 過濾出對應類型的清單
    List<SportRecord> filtered;
    clearData();
    if (tabIndex.value == 0) {
      filtered = allRecords.where((e) => e.sportType == 'aerobic').toList();
    } else {
      filtered =
          allRecords.where((e) => e.sportType == 'weightTraining').toList();
    }
    if (filtered.isNotEmpty) {
      steps.value = filtered.first.step!;
      bpm.value = filtered.first.bpm!;
      distance.value = filtered.first.distance!;
      lastHours.value = filtered.first.hours!;
      lastMinutes.value = filtered.first.minutes!;
      lastSeconds.value = filtered.first.seconds!;
    }
  }

  /// 註冊全局運動事件監聽
  void _registerGlobalSportListener() {
    print("✅ K5Controller 註冊全局運動事件監聽");
    gc.registerEventHandler(
        NativeEventType.deviceRealSport, _sportEventHandler);
  }

  /// 取消註冊全局運動事件監聽
  void _unregisterGlobalSportListener() {
    print("❌ K5Controller 取消全局運動事件監聽");
    gc.unregisterEventHandler(
        NativeEventType.deviceRealSport, _sportEventHandler);
  }

  /// 處理運動事件
  void _handleSportEvent(Map event) {
    print("=== K5Controller 接收運動事件: $event");

    // ✅ 只有在運動中才處理
    if (!isStart.value) {
      print("⚠️ 運動未開始，忽略運動數據");
      return;
    }

    // 取出運動數據
    final Map? sportInfo = event[NativeEventType.deviceRealSport];
    if (sportInfo == null) {
      print("⚠️ 運動數據為空");
      return;
    }

    // 原有的運動數據處理邏輯
    final int totalSec = int.tryParse(sportInfo["time"].toString()) ?? 0;
    bpm.value = int.tryParse(sportInfo["heartRate"].toString()) ?? 0;
    distance.value = int.tryParse(sportInfo["distance"].toString()) ?? 0;
    steps.value = int.tryParse(sportInfo["step"].toString()) ?? 0;
    calories.value = int.tryParse(sportInfo["calories"].toString()) ?? 0;

    _lastSportCache = {
      'sec': totalSec,
      'bpm': bpm.value,
      'distance': distance.value,
      'steps': steps.value,
      'cal': calories.value,
    };

    final model =
        SportRecord(sportType: '', time: DateTime.now(), bpm: bpm.value);
    records.add(model);

    _updateTimeFields(totalSec);
  }

  /// 將 SDK 的 onListening(callback) 包成一個方法
  void _registerSdkListener() {
    if (_isListening) return;
    _isListening = true;

    // ✅ 現在不需要直接註冊 SDK 監聽器，改為狀態管理
    print("✅ 運動監聽器已通過全局事件系統準備就緒");
  }

  /// 運動頁首次開啟時，主動呼叫 startPage()
  void startPage() {
    syncData();
    // ✅ 監聽器已在 onInit 時通過全局事件系統註冊，不需要重複註冊
    print("✅ 運動頁面載入完成，全局監聽器已就緒");
  }

  void switchMode(int idx) {
    tabIndex.value = idx;
    syncData();
  }

  /// 收到 SDK 給的 totalSeconds 之後，把它拆成時/分/秒並更新 Rx
  void _updateTimeFields(int totalSeconds) {
    // 算出小時、分鐘與秒
    final h = totalSeconds ~/ 3600; // 整除 3600，拿到小時
    final m = (totalSeconds % 3600) ~/ 60; // 先對 3600 取餘再整除 60，拿到分鐘
    final s = totalSeconds % 60; // 取 60 的餘數，拿到秒

    // 更新 Rx
    lastHours.value = h;
    lastMinutes.value = m;
    lastSeconds.value = s;
  }

  void clearData() {
    bpm.value = 0;
    distance.value = 0;
    steps.value = 0;
    lastHours.value = 0;
    lastMinutes.value = 0;
    lastSeconds.value = 0;
  }

  /// 把最後一次「運動資料」寫到 Hive
  void _saveExerciseRecordToHive() async {
    final b = bpm.value;
    final d = distance.value;
    final s = steps.value;
    final c = calories.value;
    final h = lastHours.value;
    final m = lastMinutes.value;
    final se = lastSeconds.value;
    var avgBpm = 0;
    var maxBpm = 0;
    var minBpm = 0;
    var sportType = 'aerobic';
    if (tabIndex.value == 0) {
      sportType = 'aerobic';
    } else {
      sportType = 'weightTraining';
    }
    final validBpmRecords = records.where((r) => (r.bpm ?? 0) > 0).toList();
    if (validBpmRecords.isNotEmpty) {
      final bpmValues = validBpmRecords.map((r) => r.bpm!).toList();

      avgBpm = (bpmValues.reduce((a, b) => a + b) / bpmValues.length).toInt();
      maxBpm = bpmValues.reduce((a, b) => a > b ? a : b);
      minBpm = bpmValues.reduce((a, b) => a < b ? a : b);

      print("平均心率: $avgBpm");
      print("最高心率: $maxBpm");
      print("最低心率: $minBpm");
    }

    var record = SportRecord(
      sportType: sportType,
      time: DateTime.now(),
      bpm: b,
      distance: d,
      step: s,
      calories: c,
      hours: h,
      minutes: m,
      seconds: se,
      avgBpm: avgBpm,
      maxBpm: maxBpm,
      minBpm: minBpm,
    );

    print("新增運動紀錄 =>  步數 $s ;心率 $b ;距離 $d ;卡路里 $c ;時 $h ;分 $m ;秒 $se");
    records.clear();
    await SportRecordListStorage.addRecords(gc.userId.value, [record]);
    print("新增運動紀錄成功");
    SnackbarHelper.showBlueSnackbar(message: "結束運動，已儲存本次記錄");

    /// 結束運動後，重新打開同步定時器
    gc.resumeBackgroundSync();
  }

  void goK6Screen(int index) {
    // stopSport();
    Get.toNamed(AppRoutes.k6Screen, arguments: index);
  }

  Future<void> startSport() async {
    if (gc.blueToolStatus.value != 2) {
      SnackbarHelper.showBlueSnackbar(message: "請先連接藍牙裝置");
      return;
    }
    gc.isSporting.value = true;

    /// 啟動運動時暫停背景五分鐘執行同步資料，不然會打架
    gc.pauseBackgroundSync();

    if (isStart.value) return;
    _isListening = true;
    isStart.value = true;
    clearData(); // 先把畫面上的上次資料歸零

    final res = await YcProductPlugin()
        .appControlSport(DeviceSportState.start, DeviceSportType.fitness);
    if (res == null || res.statusCode != PluginState.succeed) {
      // 啟動失敗就把 flag 關回去
      isStart.value = false;
      SnackbarHelper.showBlueSnackbar(message: "無法啟動運動，請稍後再試");
      return;
    }

    // ✅ 運動開始，全局監聽器已準備接收運動數據
    print("✅ 運動開始，等待接收運動數據...");
  }

  Future<void> stopSport() async {
    try {
      if (!isStart.value) return;
      gc.isSporting.value = false;
      isStart.value = false;
      YcProductPlugin()
          .appControlSport(DeviceSportState.stop, DeviceSportType.fitness)
          .timeout(const Duration(seconds: 5), onTimeout: () {
        // 如果等超過 5 秒還沒返回，就先顯示通知、但不取消整個 callback
        print("[TIMEOUT] stopSport() 超時，繼續往下執行");
        return;
      });
    } catch (e) {
      print("[ERROR] stopSport() 發生例外：$e");
    }

    _saveExerciseRecordToHive();
  }
}
