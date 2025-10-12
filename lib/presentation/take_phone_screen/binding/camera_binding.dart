import 'package:get/get.dart';
import '../controller/camera_controller.dart';

class CameraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraScreenController>(
      () => CameraScreenController(),
    );
  }
}