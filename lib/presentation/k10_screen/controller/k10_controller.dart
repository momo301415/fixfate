import 'dart:io';
import 'package:get/get.dart';
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
        scanDevices();
      } else {
        Get.snackbar('權限錯誤', '請開啟藍牙相關權限');
      }
    } else {
      scanDevices();
    }
  }

  void scanDevices() async {
    final state = await YcProductPlugin().getBluetoothState();
    if (state != BluetoothState.disconnected) {
      await YcProductPlugin().disconnectDevice();
    }
    await YcProductPlugin().setReconnectEnabled(isReconnectEnable: false);
    await YcProductPlugin().resetBond();

    final scannedDevices = await YcProductPlugin().scanDevice(time: 3);
    if (scannedDevices != null) {
      scannedDevices
          .sort((a, b) => (b.rssiValue.toInt()) - (a.rssiValue.toInt()));
      devices.assignAll(scannedDevices.whereType<BluetoothDevice>());
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    final result = await YcProductPlugin().connectDevice(device);
    if (result!) {
      selectedDevice.value = device;
      Get.snackbar('連線成功', '已連線到 ${device.name}');
    } else {
      Get.snackbar('連線失敗', '無法連接到 ${device.name}');
    }
  }
}
