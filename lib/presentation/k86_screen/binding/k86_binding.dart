import '../../../core/app_export.dart';
import '../controller/k86_controller.dart';

/// A binding class for the K86Screen.
///
/// This class ensures that the K86Controller is created when the
/// K86Screen is first loaded.
class K86Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K86Controller());
  }
}
