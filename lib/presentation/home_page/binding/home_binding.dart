import 'package:get/get.dart';
import 'package:pulsedevice/presentation/bg_log_page/controller/bg_log_controller.dart';
import 'package:pulsedevice/presentation/home_page/controller/home_controller.dart';
import 'package:pulsedevice/presentation/k13_screen/controller/k13_controller.dart';
import 'package:pulsedevice/presentation/k19_screen/controller/k19_controller.dart';
import 'package:pulsedevice/presentation/k29_page/controller/k29_controller.dart';
import 'package:pulsedevice/presentation/k73_screen/controller/k73_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut<K29Controller>(() => K29Controller());
    Get.lazyPut<K73Controller>(() => K73Controller());
    Get.lazyPut<BgLogController>(() => BgLogController());
    Get.lazyPut<K19Controller>(() => K19Controller());
    Get.lazyPut<K13Controller>(() => K13Controller());
  }
}
