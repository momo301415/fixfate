import '../../../core/app_export.dart';
import '../controller/one5_controller.dart';

/// A binding class for the One5Screen.
///
/// This class ensures that the One5Controller is created when the
/// One5Screen is first loaded.
class One5Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => One5Controller());
  }
}
