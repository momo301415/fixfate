import 'package:flutter/material.dart';
import 'package:pp_bluetooth_kit_flutter/enums/pp_scale_enums.dart';
import 'package:pp_bluetooth_kit_flutter/model/pp_device_model.dart';
import 'package:pp_bluetooth_kit_flutter/ble/pp_bluetooth_kit_manager.dart';
import 'package:pulsedevice/presentation/k36_screen/widgets/k34_dialog.dart';
import 'package:pulsedevice/core/hiveDb/pp_device_storage.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/service/pp_scale_service.dart';
import '../../../core/app_export.dart';
import '../models/k36_model.dart';

/// A controller class for the K36Screen.
///
/// This class manages the state of the K36Screen, including the
/// current k36ModelObj
class K36Controller extends GetxController {
  final gc = Get.find<GlobalController>();
  final ppScaleService = Get.find<PPScaleService>();

  Rx<K36Model> k36ModelObj = K36Model().obs;
  var isAutoComfirn = false.obs;
  var isComfirnNot = false.obs;

  /// 體脂秤相關（保留原有結構，但移除未使用的欄位）

  /// 連線狀態（委託給 Service）
  RxBool isConnecting = false.obs;

  @override
  void onInit() {
    super.onInit();
    _autoConnectToDevice(); // 自動連線到已儲存的設備
  }

  /// 自動連線到已儲存的磅秤設備
  Future<void> _autoConnectToDevice() async {
    try {
      final userId = gc.userId.value;
      final devices = PPDeviceStorage.getUserPPDeviceModels(userId);

      if (devices.isNotEmpty) {
        // 選擇第一個設備進行連線
        final device = devices.first;
        print('找到已儲存的磅秤設備: ${device.deviceName} (${device.deviceMac})');
        await _connectToDevice(device);
      } else {
        print('沒有找到已儲存的磅秤設備');
      }
    } catch (e) {
      print('自動連線失敗: $e');
    }
  }

  /// 連線到指定設備（使用 Service）
  Future<void> _connectToDevice(PPDeviceModel device) async {
    try {
      isConnecting.value = true;
      print('開始連線設備: ${device.deviceName}');

      // 使用 PPScaleService 進行連線
      final success = await ppScaleService.connectToDevice(device);

      if (success) {
        // 監聽連線狀態變化
        ppScaleService.connectionStateStream.listen((state) {
          _handleConnectionStateChange(state);
        });
      } else {
        isConnecting.value = false;
        print('連線設備失敗');
      }
    } catch (e) {
      print('連線設備失敗: $e');
      isConnecting.value = false;
    }
  }

  /// 處理連線狀態變化
  void _handleConnectionStateChange(PPDeviceConnectionState state) {
    switch (state) {
      case PPDeviceConnectionState.connected:
        _onConnectionSuccess();
        break;
      case PPDeviceConnectionState.disconnected:
        _onConnectionDisconnected();
        break;
      default:
        print('設備連線狀態: $state');
        break;
    }
  }

  /// 連線成功處理
  void _onConnectionSuccess() {
    isConnecting.value = false;

    // 跳轉到 K76 第8分頁進行測量
    // Get.toNamed(AppRoutes.k76Screen, arguments: 8);

    print('✅ 磅秤設備連線成功');
  }

  /// 連線斷開處理
  void _onConnectionDisconnected() {
    isConnecting.value = false;
    print('磅秤設備已斷線');
  }

  /// 取得已連線的設備（委託給 Service）
  PPDeviceModel? get connectedDevice => ppScaleService.connectedDevice;

  /// 檢查是否有設備已連線（委託給 Service）
  bool get hasConnectedDevice => ppScaleService.hasConnectedDevice;

  /// 手動連線到指定設備（如果需要）
  Future<void> connectToSpecificDevice(String macAddress) async {
    final device = PPDeviceStorage.convertToPPDeviceModel(macAddress);
    if (device != null) {
      await _connectToDevice(device);
    } else {
      print('找不到指定的設備: $macAddress');
    }
  }

  /// 斷開當前連線（委託給 Service）
  Future<void> disconnectDevice() async {
    await ppScaleService.disconnectDevice();
  }

  void showDeteleialog() {
    showDialog(
        context: Get.context!,
        builder: (builder) {
          return K34DeleteDialog();
        });
  }
}
