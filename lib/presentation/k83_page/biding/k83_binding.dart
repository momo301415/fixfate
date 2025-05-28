import '../../../core/app_export.dart';
import '../controller/k83_controller.dart';

/// A binding class for the K83Screen.
///
/// This class ensures that the K83Controller is created when the
/// K83Page is first loaded.
class K83Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K83Controller());
  }
}
