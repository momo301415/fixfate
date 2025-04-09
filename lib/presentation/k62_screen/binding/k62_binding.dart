import '../../../core/app_export.dart';
import '../controller/k62_controller.dart';

/// A binding class for the K62Screen.
///
/// This class ensures that the K62Controller is created when the
/// K62Screen is first loaded.
class K62Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K62Controller());
  }
}
