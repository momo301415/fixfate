import 'package:get/get.dart';
import 'package:pulsedevice/presentation/k79_page/controller/k79_controller.dart';

class K79Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K79Controller());
  }
}
