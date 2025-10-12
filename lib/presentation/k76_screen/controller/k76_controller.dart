import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/service/firebase_analytics_service.dart';
import 'package:pulsedevice/presentation/k76_screen/model/k76_model.dart';
import 'package:pulsedevice/presentation/k77_page/controller/k77_controller.dart';
import 'package:pulsedevice/presentation/k78_page/controller/k78_controller.dart';
import 'package:pulsedevice/presentation/k79_page/controller/k79_controller.dart';
import 'package:pulsedevice/presentation/k80_page/controller/k80_controller.dart';
import 'package:pulsedevice/presentation/k81_page/controller/k81_controller.dart';
import 'package:pulsedevice/presentation/k83_page/controller/k83_controller.dart';
import 'package:pulsedevice/presentation/k84_page/controller/k84_controller.dart';
import 'package:pulsedevice/presentation/k8_screen/controller/k8_controller.dart';

import '../../k82_page/controller/k82_controller.dart';

class K76Controller extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<K76Model> K76ModelObj = K76Model().obs;
  final gc = Get.find<GlobalController>();
  RxInt selectedIndex = 0.obs;
  late TabController tabController;
  late ScrollController iconScrollController;
  late List<GlobalKey> iconKeys;
  @override
  void onInit() {
    super.onInit();
    final length = K76ModelObj.value.listIconBarModelObj.value.length;
    final initialIndex = (Get.arguments ?? 0) as int;

    tabController = TabController(length: length, vsync: this);
    iconScrollController = ScrollController();
    iconKeys = List.generate(length, (_) => GlobalKey());

    // 📊 監聽 Tab 切換，記錄 GA4 事件
    tabController.addListener(() {
      selectedIndex.value = tabController.index;
      _scrollToIcon(tabController.index);

      // 只在切換完成時記錄事件（避免滑動過程中重複記錄）
      if (!tabController.indexIsChanging) {
        _logTabViewEvent(tabController.index);
      }
    });

    initController();

    // 延遲跳轉初始 index 並記錄 GA4 事件
    Future.delayed(Duration.zero, () {
      tabController.index = initialIndex;
      selectedIndex.value = initialIndex;
      _scrollToIcon(initialIndex);

      // 📊 記錄從 K73 跳轉過來時顯示的 Tab 頁面
      _logTabViewEvent(initialIndex);
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    iconScrollController.dispose();
    super.onClose();
  }

  void initController() {
    Get.put(K77Controller());
    Get.put(K78Controller());
    Get.put(K79Controller());
    Get.put(K80Controller());
    Get.put(K81Controller());
    Get.put(K82Controller());
    Get.put(K83Controller());
    Get.put(K84Controller());
    Get.put(K8Controller());
  }

  void onIconTap(int index) {
    selectedIndex.value = index;
    tabController.animateTo(index);
    _scrollToIcon(index);
  }

  void _scrollToIcon(int index) {
    final key = iconKeys[index];
    final itemContext = key.currentContext;
    if (itemContext != null) {
      Scrollable.ensureVisible(itemContext,
          duration: Duration(milliseconds: 300),
          alignment: 0.5,
          curve: Curves.easeInOut);
    }
  }

  /// 📊 統一記錄 Tab 頁面瀏覽事件
  void _logTabViewEvent(int index) {
    final analytics = FirebaseAnalyticsService.instance;

    try {
      switch (index) {
        case 0: // K77 心率
          final controller = Get.find<K77Controller>();
          analytics.logViewHeartRatePage(
            heartRateValue: controller.heartRateVal.value.isNotEmpty
                ? controller.heartRateVal.value
                : null,
            hasAlert: controller.isAlert.value,
            parameters: {
              'load_time': controller.loadDataTime.value,
              'time_range_index': controller.currentIndex.value,
              'record_mode_index': controller.recordIndex.value,
            },
          );
          break;

        case 1: // K78 血氧
          final controller = Get.find<K78Controller>();
          analytics.logViewBloodOxygenPage(
            oxygenValue: controller.bloodOxVal.value.isNotEmpty
                ? controller.bloodOxVal.value
                : null,
            hasAlert: controller.isAlert.value,
            parameters: {
              'load_time': controller.loadDataTime.value,
              'time_range_index': controller.currentIndex.value,
              'record_mode_index': controller.recordIndex.value,
            },
          );
          break;

        case 2: // K79 體溫
          final controller = Get.find<K79Controller>();
          analytics.logViewTemperaturePage(
            temperatureValue: controller.tempratureVal.value.isNotEmpty
                ? controller.tempratureVal.value
                : null,
            hasAlert: controller.isAlert.value,
            parameters: {
              'load_time': controller.loadDataTime.value,
              'time_range_index': controller.currentIndex.value,
              'record_mode_index': controller.recordIndex.value,
            },
          );
          break;

        case 3: // K80 壓力
          final controller = Get.find<K80Controller>();
          analytics.logViewStressPage(
            stressValue: controller.pressureVal.value.isNotEmpty
                ? controller.pressureVal.value
                : null,
            hasAlert: controller.isAlert.value,
            parameters: {
              'load_time': controller.loadDataTime.value,
              'time_range_index': controller.currentIndex.value,
              'record_mode_index': controller.recordIndex.value,
            },
          );
          break;

        case 4: // K81 步數
          final controller = Get.find<K81Controller>();
          analytics.logViewStepsPage(
            stepsValue: controller.stepVal.value.isNotEmpty
                ? controller.stepVal.value
                : null,
            parameters: {
              'load_time': controller.loadDataTime.value,
              'time_range_index': controller.currentIndex.value,
            },
          );
          break;

        case 5: // K82 睡眠
          final controller = Get.find<K82Controller>();
          analytics.logViewSleepPage(
            sleepValue: controller.sleepVal.value.isNotEmpty
                ? controller.sleepVal.value
                : null,
            parameters: {
              'load_time': controller.loadDataTime.value,
              'time_range_index': controller.currentIndex.value,
              'deep_sleep': controller.deep.value,
              'light_sleep': controller.light.value,
              'rem_sleep': controller.rem.value,
              'awake_time': controller.awake.value,
            },
          );
          break;

        case 6: // K83 卡路里
          final controller = Get.find<K83Controller>();
          analytics.logViewCaloriesPage(
            caloriesValue: controller.caloriesVal.value.isNotEmpty
                ? controller.caloriesVal.value
                : null,
            parameters: {
              'load_time': controller.loadDataTime.value,
              'time_range_index': controller.currentIndex.value,
            },
          );
          break;

        case 7: // K84 移動距離
          final controller = Get.find<K84Controller>();
          analytics.logViewDistancePage(
            distanceValue: controller.distanceVal.value.isNotEmpty
                ? controller.distanceVal.value
                : null,
            parameters: {
              'load_time': controller.loadDataTime.value,
              'time_range_index': controller.currentIndex.value,
            },
          );
          break;
      }
    } catch (e) {
      print('📊 記錄 Tab 頁面瀏覽事件失敗: $e');
    }
  }
}
