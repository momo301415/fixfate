import '../../../core/app_export.dart';
import '../controller/k36_controller.dart';

/// A binding class for the K36Screen.
///
/// This class ensures that the K36Controller is created when the
/// K36Screen is first loaded.
class K36DeviceDetailesBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => K36Controller());
  }
}
