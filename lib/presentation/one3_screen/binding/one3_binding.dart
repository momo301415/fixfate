import '../../../core/app_export.dart';
import '../controller/one3_controller.dart';

/// A binding class for the One3Screen.
///
/// This class ensures that the One3Controller is created when the
/// One3Screen is first loaded.
class One3Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => One3Controller());
  }
}
