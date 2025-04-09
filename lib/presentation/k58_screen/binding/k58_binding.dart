import '../../../core/app_export.dart';
import '../controller/k58_controller.dart';

/// A binding class for the K58Screen.
///
/// This class ensures that the K58Controller is created when the
/// K58Screen is first loaded.
class K58Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K58Controller());
  }
}
