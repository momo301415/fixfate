import '../../../core/app_export.dart';
import '../controller/k55_controller.dart';

/// A binding class for the K55Screen.
///
/// This class ensures that the K55Controller is created when the
/// K55Screen is first loaded.
class K55Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K55Controller());
  }
}
