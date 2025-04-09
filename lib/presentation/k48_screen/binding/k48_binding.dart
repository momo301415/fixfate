import '../../../core/app_export.dart';
import '../controller/k48_controller.dart';

/// A binding class for the K48Screen.
///
/// This class ensures that the K48Controller is created when the
/// K48Screen is first loaded.
class K48Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K48Controller());
  }
}
