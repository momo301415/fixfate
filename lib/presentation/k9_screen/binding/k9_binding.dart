import '../../../core/app_export.dart';
import '../controller/k9_controller.dart';

/// A binding class for the K9Screen.
///
/// This class ensures that the K9Controller is created when the
/// K9Screen is first loaded.
class K9Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K9Controller());
  }
}
