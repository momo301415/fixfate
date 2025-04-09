import '../../../core/app_export.dart';
import '../controller/two6_controller.dart';

/// A binding class for the Two6Screen.
///
/// This class ensures that the Two6Controller is created when the
/// Two6Screen is first loaded.
class Two6Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Two6Controller());
  }
}
