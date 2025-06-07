import '../../../core/app_export.dart';
import '../controller/k5_controller.dart';

/// A binding class for the K5Screen.
///
/// This class ensures that the K5Controller is created when the
/// K5Screen is first loaded.
class K5Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K5Controller());
  }
}
