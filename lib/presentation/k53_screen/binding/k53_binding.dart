import '../../../core/app_export.dart';
import '../controller/k53_controller.dart';

/// A binding class for the K53Screen.
///
/// This class ensures that the K53Controller is created when the
/// K53Screen is first loaded.
class K53Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K53Controller());
  }
}
