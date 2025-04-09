import '../../../core/app_export.dart';
import '../controller/k10_controller.dart';

/// A binding class for the K10Screen.
///
/// This class ensures that the K10Controller is created when the
/// K10Screen is first loaded.
class K10Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K10Controller());
  }
}
