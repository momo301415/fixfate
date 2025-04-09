import '../../../core/app_export.dart';
import '../controller/k44_controller.dart';

/// A binding class for the K44Screen.
///
/// This class ensures that the K44Controller is created when the
/// K44Screen is first loaded.
class K44Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K44Controller());
  }
}
