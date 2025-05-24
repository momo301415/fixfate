import 'package:get/get.dart';
import 'package:pulsedevice/presentation/k76_screen/controller/k76_controller.dart';

class K76Biding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K76Controller());
  }
}
