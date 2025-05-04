import 'package:pulsedevice/core/utils/DeviceStorage.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';
import 'package:yc_product_plugin/yc_product_plugin_data_type.dart';

import '../../../core/app_export.dart';
import '../models/k42_model.dart';

/// A controller class for the K42Dialog.
///
/// This class manages the state of the K42Dialog, including the
/// current k42ModelObj
class K42Controller extends GetxController {
  Rx<K42Model> k42ModelObj = K42Model().obs;

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      final result = await YcProductPlugin().connectDevice(device);

      if (result == true) {
        Get.snackbar('連線成功', '已連線到 ${device.name}');
        DeviceStorage.saveDevice(device);
      } else {
        Get.snackbar('連線失敗', '無法連接到 ${device.name}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
