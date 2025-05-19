import '../../../core/app_export.dart';
import '../controller/two10_controller.dart';

/// A binding class for the Two5Screen.
///
/// This class ensures that the Two5Controller is created when the
/// Two5Screen is first loaded.
class Two10Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Two10Controller());
  }
}
