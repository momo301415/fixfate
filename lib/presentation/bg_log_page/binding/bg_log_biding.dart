import 'package:get/get.dart';
import 'package:pulsedevice/presentation/bg_log_page/controller/bg_log_controller.dart';

class BgLogBiding extends Bindings {
  @override
  void dependencies() {
    Get.put(BgLogController());
  }
}
