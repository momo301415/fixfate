import '../../../core/app_export.dart';
import '../controller/k13_controller.dart';

/// A binding class for the K13Screen.
///
/// This class ensures that the K13Controller is created when the
/// K13Screen is first loaded.
class K13Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K13Controller());
  }
}
