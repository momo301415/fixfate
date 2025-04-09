import '../../../core/app_export.dart';
import '../controller/one8_controller.dart';

/// A binding class for the One8Screen.
///
/// This class ensures that the One8Controller is created when the
/// One8Screen is first loaded.
class One8Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => One8Controller());
  }
}
