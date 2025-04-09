import '../../../core/app_export.dart';
import '../controller/k63_controller.dart';

/// A binding class for the K63Screen.
///
/// This class ensures that the K63Controller is created when the
/// K63Screen is first loaded.
class K63Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K63Controller());
  }
}
