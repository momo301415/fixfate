import '../../../core/app_export.dart';
import '../controller/one10_controller.dart';

/// A binding class for the One10Screen.
///
/// This class ensures that the One10Controller is created when the
/// One10Screen is first loaded.
class One10Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => One10Controller());
  }
}
