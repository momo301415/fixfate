import '../../../core/app_export.dart';
import '../controller/k6_controller.dart';

/// A binding class for the K5Screen.
///
/// This class ensures that the K5Controller is created when the
/// K5Screen is first loaded.
class K6Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K6Controller());
  }
}
