import '../../../core/app_export.dart';

/// This class defines the variables used in the [k10_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class K10Model {
  RxList<BluetoothDeviceModel> scannedDevices = <BluetoothDeviceModel>[].obs;
}

class BluetoothDeviceModel {
  final String name;
  final String id;

  BluetoothDeviceModel({required this.name, required this.id});
}
