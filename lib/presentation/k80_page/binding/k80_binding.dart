import '../../../core/app_export.dart';
import '../controller/k80_controller.dart';

/// A binding class for the K80Screen.
///
/// This class ensures that the K80Controller is created when the
/// K80Screen is first loaded.
class K80Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K80Controller());
  }
}
