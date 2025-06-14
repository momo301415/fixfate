import 'package:get/get.dart';
import 'package:pulsedevice/presentation/log_screen/controller/log_controller.dart';

class LogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LogController());
  }
}
