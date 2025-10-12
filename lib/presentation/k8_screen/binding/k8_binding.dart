import '../../../core/app_export.dart';
import '../controller/k8_controller.dart';

/// A binding class for the K8Screen.
///
/// This class ensures that the K8Controller is created when the
/// K8Screen is first loaded.
class K8Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K8Controller());
  }
}
