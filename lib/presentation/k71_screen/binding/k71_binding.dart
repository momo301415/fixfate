import '../../../core/app_export.dart';
import '../controller/k71_controller.dart';

/// A binding class for the K71Screen.
///
/// This class ensures that the K71Controller is created when the
/// K71Screen is first loaded.
class K71Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K71Controller());
  }
}
