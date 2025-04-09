import '../../../core/app_export.dart';
import '../controller/k67_controller.dart';

/// A binding class for the K67Screen.
///
/// This class ensures that the K67Controller is created when the
/// K67Screen is first loaded.
class K67Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K67Controller());
  }
}
