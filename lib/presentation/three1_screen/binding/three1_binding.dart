import '../../../core/app_export.dart';
import '../controller/three1_controller.dart';

/// A binding class for the Three1Screen.
///
/// This class ensures that the Three1Controller is created when the
/// Three1Screen is first loaded.
class Three1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Three1Controller());
  }
}
