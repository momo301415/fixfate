import 'package:flutter/material.dart';
import 'package:pp_bluetooth_kit_flutter/enums/pp_scale_enums.dart';
import 'package:pp_bluetooth_kit_flutter/model/pp_body_base_model.dart';
import 'package:pp_bluetooth_kit_flutter/model/pp_device_model.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/pp_device_storage.dart';
import 'package:pulsedevice/core/service/pp_scale_service.dart';
import '../../../core/app_export.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import '../models/k8_model.dart';

/// A controller class for the K8Screen.
///
/// This class manages the state of the K8Screen, including the
/// current k8ModelObj
class K8Controller extends GetxController {
  final gc = Get.find<GlobalController>();
  final ppScaleService = Get.find<PPScaleService>();
  Rx<K8Model> k8ModelObj = K8Model().obs;

  // 日期切换相关属性
  RxInt currentIndex = 0.obs; // 预设日
  RxString formattedRange = ''.obs;
  List<String> timeTabs = ['lbl229'.tr, 'lbl230'.tr, 'lbl231'.tr]; // 日、周、月
  Rx<DateTime> currentDate = DateTime.now().obs;

  /// 體脂秤相關（保留原有結構）
  PPDeviceConnectionState _connectionStatus = PPDeviceConnectionState.disconnected;
  PPDeviceModel? _device;

  /// 磅秤測量相關（委託給 Service）
  RxBool isMeasuring = false.obs;
  RxString measurementStatus = '準備測量'.obs;
  RxDouble currentWeight = 0.0.obs;
  Rx<PPMeasurementDataState> currentMeasurementState = PPMeasurementDataState.processData.obs;

  @override
  void onInit() {
    super.onInit();
    updateDateRange(currentIndex.value);
    
    // 設定 Service 監聽器
    _setupServiceListeners();
    
    // 檢查是否有磅秤設備連線
    if (ppScaleService.hasConnectedDevice) {
      measurementStatus.value = '設備已連線，請站上磅秤';
    } else {
      measurementStatus.value = '設備未連線';
    }
  }

  @override
  void onClose() {
    // 清理監聽器
    _cleanupServiceListeners();
    super.onClose();
  }

  void getDevice() async {
    var device = PPDeviceStorage.getUserPPDevices(gc.userId.value);
  }

  /// 更新日期范围显示
  void updateDateRange(int index) {
    if (index == 0) {
      // 日
      formattedRange.value =
          "${currentDate.value.format(pattern: 'M月d日, EEEE', locale: 'zh_CN')}";
    } else if (index == 1) {
      // 周
      final startOfWeek = currentDate.value
          .subtract(Duration(days: currentDate.value.weekday - 1));
      final endOfWeek = startOfWeek.add(Duration(days: 6));
      formattedRange.value =
          '${startOfWeek.format(pattern: 'M月d日')} ～ ${endOfWeek.format(pattern: 'M月d日')}';
    } else {
      // 月
      formattedRange.value =
          "${currentDate.value.year}年 ${currentDate.value.month}月";
    }
  }

  /// 上一个日期范围
  void prevDateRange() {
    final index = currentIndex.value;
    if (index == 0) {
      currentDate.value = currentDate.value.subtract(const Duration(days: 1));
    } else if (index == 1) {
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

  /// 下一个日期范围
  void nextDateRange() {
    final index = currentIndex.value;
    if (index == 0) {
      currentDate.value = currentDate.value.add(const Duration(days: 1));
    } else if (index == 1) {
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

  /// 日期选择器（简化版本，可以根据需要扩展）
  void datePicker() {
    // 这里可以添加日期选择器的逻辑
    // 暂时保持空实现，可以根据需要添加具体的日期选择功能
  }

  // ======================================================
  // 🎯 磅秤測量功能（使用 Service）
  // ======================================================

  /// 設定 Service 監聽器
  void _setupServiceListeners() {
    print('🎯 K8Controller: 設定 Service 監聽器');
    
    // 監聽測量數據
    ppScaleService.measurementStream.listen((dataModel) {
      _handleMeasurementData(dataModel);
    });
    
    // 監聽連線狀態
    ppScaleService.connectionStateStream.listen((state) {
      _handleConnectionStateChange(state);
    });
    
    // 監聽狀態訊息
    ppScaleService.statusMessageStream.listen((message) {
      measurementStatus.value = message;
    });
    
    // 監聽體重變化
    ppScaleService.weightStream.listen((weight) {
      currentWeight.value = weight;
    });
    
    // 監聽測量狀態
    ppScaleService.measurementState.listen((state) {
      currentMeasurementState.value = state;
      isMeasuring.value = ppScaleService.isMeasuring.value;
    });
  }

  /// 清理 Service 監聽器
  void _cleanupServiceListeners() {
    print('🧹 K8Controller: 清理 Service 監聽器');
    // Stream 監聽器會在 Controller 銷毀時自動清理
  }

  /// 處理測量數據
  void _handleMeasurementData(PPBodyBaseModel dataModel) {
    print('📊 K8Controller: 收到測量數據');
    
    // 顯示測量結果
    _showMeasurementResult(dataModel);
  }

  /// 處理連線狀態變化
  void _handleConnectionStateChange(PPDeviceConnectionState state) {
    switch (state) {
      case PPDeviceConnectionState.connected:
        measurementStatus.value = '設備已連線，請站上磅秤';
        break;
      case PPDeviceConnectionState.disconnected:
        measurementStatus.value = '設備已斷線';
        break;
      default:
        break;
    }
  }

  /// 顯示測量結果
  void _showMeasurementResult(PPBodyBaseModel dataModel) {
    final weight = dataModel.weight / 100.0;
    
    // 顯示成功訊息
    Get.snackbar(
      '測量完成',
      '體重: ${weight.toStringAsFixed(1)} kg',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
      duration: Duration(seconds: 3),
    );
  }

  /// 手動開始測量（委託給 Service）
  void startMeasurement() {
    ppScaleService.startMeasurement();
  }

  /// 停止測量（委託給 Service）
  void stopMeasurement() {
    ppScaleService.stopMeasurement();
  }

  /// 取得當前測量數據（委託給 Service）
  PPBodyBaseModel? get currentMeasurementData => ppScaleService.lastMeasurementData;

  /// 檢查是否正在測量（委託給 Service）
  bool get isCurrentlyMeasuring => ppScaleService.isMeasuring.value;

  /// 同步時間（委託給 Service）
  Future<bool> syncTime() async {
    return await ppScaleService.syncTime();
  }

  /// 切換單位（委託給 Service）
  Future<void> changeUnit(PPUnitType unit) async {
    await ppScaleService.changeUnit(unit);
  }

  /// 取得歷史數據（委託給 Service）
  Future<void> fetchHistory() async {
    await ppScaleService.fetchHistory();
  }

  /// 取得電池資訊（委託給 Service）
  Future<int?> getBatteryInfo() async {
    return await ppScaleService.getBatteryInfo();
  }

  /// 重置設備（委託給 Service）
  Future<void> resetDevice() async {
    await ppScaleService.resetDevice();
  }
}
