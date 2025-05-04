import 'dart:io';
import 'package:get/get.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/presentation/k42_dialog/controller/k42_controller.dart';
import 'package:pulsedevice/presentation/k42_dialog/k42_dialog.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class K10Controller extends GetxController {
  RxList<BluetoothDevice> devices = <BluetoothDevice>[].obs;
  Rx<BluetoothDevice?> selectedDevice = Rx<BluetoothDevice?>(null);

  @override
  void onInit() {
    super.onInit();
    checkBluetoothPermission();
  }

  Future<void> checkBluetoothPermission() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        final sdkInt = androidInfo.version.sdkInt;
        bool granted = false;

        if (sdkInt >= 31) {
          final statusScan = await Permission.bluetoothScan.request();
          final statusConnect = await Permission.bluetoothConnect.request();
          granted = statusScan.isGranted && statusConnect.isGranted;
        } else {
          final statusLocation = await Permission.locationWhenInUse.request();
          granted = statusLocation.isGranted;
        }

        if (granted) {
          await scanDevices();
        } else {
          Get.snackbar('權限錯誤', '請開啟藍牙相關權限');
        }
      } else {
        await scanDevices();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> scanDevices() async {
    try {
      // ⚡不要自己 show loading，讓 plugin 自己管
      final state = await YcProductPlugin().getBluetoothState();
      if (state != BluetoothState.disconnected) {
        await YcProductPlugin().disconnectDevice();
      }

      await YcProductPlugin().setReconnectEnabled(isReconnectEnable: false);
      await YcProductPlugin().resetBond();

      final scannedDevices = await YcProductPlugin().scanDevice(time: 3);

      if (scannedDevices != null) {
        final uniqueDevices = <String, BluetoothDevice>{};

        for (final device in scannedDevices) {
          if (device.macAddress.isNotEmpty) {
            uniqueDevices[device.macAddress] = device;
          }
        }

        final sortedList = uniqueDevices.values.toList()
          ..sort((a, b) => (b.rssiValue.toInt()) - (a.rssiValue.toInt()));

        devices.assignAll(sortedList);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      final result = await YcProductPlugin().connectDevice(device);

      if (result == true) {
        selectedDevice.value = device;
        Get.snackbar('連線成功', '已連線到 ${device.name}');
      } else {
        Get.snackbar('連線失敗', '無法連接到 ${device.name}');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// 連接裝置dialog
  Future<void> showConnectDevice(BluetoothDevice device) async {
    final result = await DialogHelper.showCustomDialog(
        Get.context!,
        K42Dialog(
          Get.put(K42Controller()),
          bluetoothDevice: device,
        ));
    if (result != null && result.isNotEmpty) {}
  }
}
