import 'dart:async';
import 'package:get/get.dart';
import 'package:pp_bluetooth_kit_flutter/ble/pp_bluetooth_kit_manager.dart';
import 'package:pp_bluetooth_kit_flutter/ble/pp_peripheral_ice.dart';
import 'package:pp_bluetooth_kit_flutter/channel/pp_bluetooth_kit_flutter_platform_interface.dart';
import 'package:pp_bluetooth_kit_flutter/enums/pp_scale_enums.dart';
import 'package:pp_bluetooth_kit_flutter/model/pp_body_base_model.dart';
import 'package:pp_bluetooth_kit_flutter/model/pp_device_model.dart';
import 'package:pp_bluetooth_kit_flutter/model/pp_device_user.dart';
import 'package:pulsedevice/core/hiveDb/pp_device_storage.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';

/// 磅秤設備統一管理服務
class PPScaleService extends GetxService {
  static PPScaleService get instance => Get.find<PPScaleService>();

  // === 內部狀態管理 ===
  PPDeviceModel? _connectedDevice;
  Timer? _keepAliveTimer;
  PPBodyBaseModel? _lastMeasurementData;

  // === 對外暴露的 Stream ===
  final _connectionStateController =
      StreamController<PPDeviceConnectionState>.broadcast();
  final _measurementController = StreamController<PPBodyBaseModel>.broadcast();
  final _statusController = StreamController<String>.broadcast();
  final _weightController = StreamController<double>.broadcast();

  // === 對外暴露的 Observable ===
  final RxBool isConnected = false.obs;
  final RxBool isMeasuring = false.obs;
  final RxString statusMessage = '準備連線'.obs;
  final RxDouble currentWeight = 0.0.obs;
  final Rx<PPMeasurementDataState> measurementState =
      PPMeasurementDataState.processData.obs;

  @override
  void onInit() {
    super.onInit();
    print('🎯 PPScaleService 初始化');
    _setupSDKListeners();
  }

  @override
  void onClose() {
    print('🧹 PPScaleService 清理資源');
    _cleanup();
    super.onClose();
  }

  // ======================================================
  // 🎯 對外公開接口
  // ======================================================

  /// 連線到磅秤設備
  Future<bool> connectToDevice(PPDeviceModel device) async {
    try {
      print('🔗 PPScaleService: 開始連線設備 ${device.deviceName}');
      statusMessage.value = '正在連線...';

      PPBluetoothKitManager.connectDevice(device, callBack: (state) {
        _handleConnectionStateChange(state, device);
      });

      return true;
    } catch (e) {
      print('❌ PPScaleService: 連線失敗 $e');
      statusMessage.value = '連線失敗';
      return false;
    }
  }

  /// 斷開設備連線
  Future<void> disconnectDevice() async {
    try {
      print('🔌 PPScaleService: 斷開設備連線');
      PPBluetoothKitManager.disconnect();
      _cleanup();
    } catch (e) {
      print('❌ PPScaleService: 斷線失敗 $e');
    }
  }

  /// 測量之前先設定基本數據
  Future<void> syncUnit() async {
    final gc = Get.find<GlobalController>();
    final sex =
        gc.gender.value == "male" ? PPUserGender.male : PPUserGender.female;
    final deviceUser = PPDeviceUser(
        userHeight: int.parse(gc.bodyHeight.value),
        age: DateTimeUtils.getAge(gc.birth.value),
        sex: sex,
        unitType: PPUnitType.Unit_KG);

    await PPBluetoothKitFlutterPlatform.instance
        .syncUnit(PPDevicePeripheralType.ice.value, deviceUser);
  }

  /// 開始測量
  void startMeasurement() {
    if (!isConnected.value) {
      statusMessage.value = '設備未連線';
      return;
    }

    isMeasuring.value = true;
    statusMessage.value = '請站上磅秤開始測量';
    print('🎯 PPScaleService: 開始測量');
  }

  /// 停止測量
  void stopMeasurement() {
    isMeasuring.value = false;
    statusMessage.value = '測量已停止';
    print('🛑 PPScaleService: 停止測量');
  }

  /// 同步時間
  Future<bool> syncTime() async {
    if (!isConnected.value) return false;

    try {
      print('⏰ PPScaleService: 同步時間');
      await PPPeripheralIce.syncTime();
      statusMessage.value = '時間同步完成';
      return true;
    } catch (e) {
      print('❌ PPScaleService: 時間同步失敗 $e');
      statusMessage.value = '時間同步失敗';
      return false;
    }
  }

  /// 切換單位
  Future<void> changeUnit(PPUnitType unit) async {
    if (!isConnected.value) return;

    try {
      print('📏 PPScaleService: 切換單位到 $unit');
      await PPPeripheralIce.syncUnit(unit);
      statusMessage.value = '單位已切換';
    } catch (e) {
      print('❌ PPScaleService: 單位切換失敗 $e');
      statusMessage.value = '單位切換失敗';
    }
  }

  /// 取得歷史數據
  Future<void> fetchHistory() async {
    if (!isConnected.value) return;

    try {
      print('📊 PPScaleService: 取得歷史數據');
      statusMessage.value = '正在取得歷史數據...';

      PPPeripheralIce.fetchHistoryData(callBack: (dataList, isSuccess) {
        print('📊 PPScaleService: 歷史數據數量 ${dataList.length}');
        statusMessage.value = '歷史數據取得完成';

        if (isSuccess && dataList.isNotEmpty) {
          // 處理歷史數據
          for (PPBodyBaseModel model in dataList) {
            print('📊 歷史體重: ${model.weight / 100.0} kg');
          }

          // 刪除歷史數據
          PPPeripheralIce.deleteHistoryData();
        }
      });
    } catch (e) {
      print('❌ PPScaleService: 取得歷史數據失敗 $e');
      statusMessage.value = '取得歷史數據失敗';
    }
  }

  /// 取得電池資訊
  Future<int?> getBatteryInfo() async {
    if (!isConnected.value) return null;

    try {
      print('🔋 PPScaleService: 取得電池資訊');
      int? batteryLevel;

      PPPeripheralIce.fetchBatteryInfo(
          continuity: true,
          callBack: (power) {
            batteryLevel = power;
            print('🔋 PPScaleService: 電池電量 $power%');
          });

      return batteryLevel;
    } catch (e) {
      print('❌ PPScaleService: 取得電池資訊失敗 $e');
      return null;
    }
  }

  /// 重置設備
  Future<void> resetDevice() async {
    if (!isConnected.value) return;

    try {
      print('🔄 PPScaleService: 重置設備');
      PPPeripheralIce.resetDevice();
      statusMessage.value = '設備已重置';
    } catch (e) {
      print('❌ PPScaleService: 重置設備失敗 $e');
      statusMessage.value = '重置設備失敗';
    }
  }

  // ======================================================
  // 🎯 Stream 接口
  // ======================================================

  /// 連線狀態 Stream
  Stream<PPDeviceConnectionState> get connectionStateStream =>
      _connectionStateController.stream;

  /// 測量數據 Stream
  Stream<PPBodyBaseModel> get measurementStream =>
      _measurementController.stream;

  /// 狀態訊息 Stream
  Stream<String> get statusMessageStream => _statusController.stream;

  /// 體重數據 Stream
  Stream<double> get weightStream => _weightController.stream;

  // ======================================================
  // 🎯 Getter 接口
  // ======================================================

  /// 取得當前連線的設備
  PPDeviceModel? get connectedDevice => _connectedDevice;

  /// 取得最後測量數據
  PPBodyBaseModel? get lastMeasurementData => _lastMeasurementData;

  /// 檢查是否已連線
  bool get hasConnectedDevice => isConnected.value;

  // ======================================================
  // 🎯 內部實現
  // ======================================================

  /// 設定 SDK 監聽器
  void _setupSDKListeners() {
    print('🎧 PPScaleService: 設定 SDK 監聽器');

    // 設定測量數據監聽器
    PPBluetoothKitManager.addMeasurementListener(
        callBack: (measurementState, dataModel, device) {
      _handleMeasurementData(measurementState, dataModel, device);
    });
  }

  /// 處理連線狀態變化
  void _handleConnectionStateChange(
      PPDeviceConnectionState state, PPDeviceModel device) {
    print('🔄 PPScaleService: 連線狀態變化 $state');

    _connectionStateController.add(state);

    switch (state) {
      case PPDeviceConnectionState.connected:
        _onConnectionSuccess(device);
        break;
      case PPDeviceConnectionState.disconnected:
        _onConnectionDisconnected();
        break;
      default:
        statusMessage.value = '連線中...';
        break;
    }
  }

  /// 連線成功處理
  void _onConnectionSuccess(PPDeviceModel device) {
    print('✅ PPScaleService: 設備連線成功 ${device.deviceName}');

    _connectedDevice = device;
    isConnected.value = true;
    statusMessage.value = '設備已連線，請站上磅秤';

    // 啟動 keepAlive
    _startKeepAlive();

    // 更新 Hive 中的連線狀態
    PPDeviceStorage.updateConnectionStatus(device.deviceMac!, true);

    // 通知 GlobalController
    final gc = Get.find<GlobalController>();
    gc.updatePPDeviceConnectionStatus(true);
  }

  /// 連線斷開處理
  void _onConnectionDisconnected() {
    print('🔌 PPScaleService: 設備連線斷開');

    _connectedDevice = null;
    isConnected.value = false;
    statusMessage.value = '設備已斷線';

    // 停止 keepAlive
    _stopKeepAlive();

    // 通知 GlobalController
    final gc = Get.find<GlobalController>();
    gc.updatePPDeviceConnectionStatus(false);
  }

  /// 處理測量數據
  void _handleMeasurementData(PPMeasurementDataState measurementState,
      PPBodyBaseModel dataModel, PPDeviceModel device) {
    print('📊 PPScaleService: 收到測量數據 - 狀態: $measurementState');

    this.measurementState.value = measurementState;
    _lastMeasurementData = dataModel;

    // 更新體重（需要除以100.0）
    final weight = dataModel.weight / 100.0;
    currentWeight.value = weight;
    _weightController.add(weight);

    switch (measurementState) {
      case PPMeasurementDataState.completed:
        _onMeasurementCompleted(dataModel);
        break;
      case PPMeasurementDataState.measuringHeartRate:
        statusMessage.value = '正在測量心率...';
        isMeasuring.value = true;
        break;
      case PPMeasurementDataState.measuringBodyFat:
        statusMessage.value = '正在測量體脂...';
        isMeasuring.value = true;
        break;
      default:
        statusMessage.value = '測量中...';
        isMeasuring.value = true;
        break;
    }
  }

  /// 測量完成處理
  void _onMeasurementCompleted(PPBodyBaseModel dataModel) {
    print('✅ PPScaleService: 測量完成');
    print('📊 測量數據: ${dataModel.toJson()}');

    isMeasuring.value = false;
    statusMessage.value = '測量完成';

    // 發送到 Stream
    _measurementController.add(dataModel);

    // 儲存測量數據
    _saveMeasurementData(dataModel);
  }

  /// 儲存測量數據
  void _saveMeasurementData(PPBodyBaseModel dataModel) {
    try {
      print('💾 PPScaleService: 儲存測量數據');
      print('  - 體重: ${dataModel.weight / 100.0} kg');
      print('  - 測量時間: ${DateTime.now()}');

      // TODO: 實現實際的數據儲存邏輯
      // 例如：儲存到 SQLite 的體重數據表
    } catch (e) {
      print('❌ PPScaleService: 儲存測量數據失敗 $e');
    }
  }

  /// 啟動 keepAlive
  void _startKeepAlive() {
    _stopKeepAlive(); // 先停止現有的 timer

    _keepAliveTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (isConnected.value && _connectedDevice != null) {
        try {
          PPPeripheralIce.keepAlive();
          print('🔄 PPScaleService: keepAlive 發送');
        } catch (e) {
          print('❌ PPScaleService: keepAlive 發送失敗 $e');
        }
      } else {
        _stopKeepAlive();
      }
    });

    print('✅ PPScaleService: keepAlive timer 已啟動');
  }

  /// 停止 keepAlive
  void _stopKeepAlive() {
    _keepAliveTimer?.cancel();
    _keepAliveTimer = null;
    print('🛑 PPScaleService: keepAlive timer 已停止');
  }

  /// 清理資源
  void _cleanup() {
    _stopKeepAlive();
    _connectedDevice = null;
    isConnected.value = false;
    isMeasuring.value = false;
    statusMessage.value = '已斷線';
  }
}
