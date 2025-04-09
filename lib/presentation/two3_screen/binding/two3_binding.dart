import '../../../core/app_export.dart';
import '../controller/two3_controller.dart';

/// A binding class for the Two3Screen.
///
/// This class ensures that the Two3Controller is created when the
/// Two3Screen is first loaded.
class Two3Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Two3Controller());
  }
}
