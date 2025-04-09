import '../../../core/app_export.dart';
import '../controller/k39_controller.dart';

/// A binding class for the K39Screen.
///
/// This class ensures that the K39Controller is created when the
/// K39Screen is first loaded.
class K39Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K39Controller());
  }
}
