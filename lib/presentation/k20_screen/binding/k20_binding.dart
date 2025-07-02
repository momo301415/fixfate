import '../../../core/app_export.dart';
import '../controller/k20_controller.dart';

/// A binding class for the K20Screen.
///
/// This class ensures that the K20Controller is created when the
/// K20Screen is first loaded.
class K20Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K20Controller());
  }
}
