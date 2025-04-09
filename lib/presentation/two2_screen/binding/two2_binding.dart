import '../../../core/app_export.dart';
import '../controller/two2_controller.dart';

/// A binding class for the Two2Screen.
///
/// This class ensures that the Two2Controller is created when the
/// Two2Screen is first loaded.
class Two2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Two2Controller());
  }
}
