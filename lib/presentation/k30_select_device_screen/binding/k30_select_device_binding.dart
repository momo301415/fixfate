import 'package:pulsedevice/presentation/k30_select_device_screen/controller/k30_select_device_controller.dart';

import '../../../core/app_export.dart';


/// A binding class for the K30Screen.
///
/// This class ensures that the K30Controller is created when the
/// K30Screen is first loaded.
class K30SelectDeviceBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => K30SelectDeviceController());

  }
}
