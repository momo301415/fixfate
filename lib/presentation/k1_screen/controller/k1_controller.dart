import '../../../core/app_export.dart';
import '../models/k1_model.dart';

/// A controller class for the K1Screen.
///
/// This class manages the state of the K1Screen, including the
/// current k1ModelObj
class K1Controller extends GetxController {
  Rx<K1Model> k1ModelObj = K1Model().obs;

  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Get.offNamed(
        AppRoutes.k2Screen,
      );
    });
  }
}
