import '../../../core/app_export.dart';
import '../controller/k84_controller.dart';

/// A binding class for the K84Screen.
///
/// This class ensures that the K84Controller is created when the
/// K84Screen is first loaded.
class K84Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K84Controller());
  }
}
