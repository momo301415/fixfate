import '../../../core/app_export.dart';
import '../controller/k19_controller.dart';

/// A binding class for the K19Screen.
///
/// This class ensures that the K19Controller is created when the
/// K19Screen is first loaded.
class K19Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K19Controller());
  }
}
