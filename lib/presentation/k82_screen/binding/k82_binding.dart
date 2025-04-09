import '../../../core/app_export.dart';
import '../controller/k82_controller.dart';

/// A binding class for the K82Screen.
///
/// This class ensures that the K82Controller is created when the
/// K82Screen is first loaded.
class K82Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K82Controller());
  }
}
