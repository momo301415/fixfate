import '../../../core/app_export.dart';
import '../controller/two7_controller.dart';

/// A binding class for the Two7Screen.
///
/// This class ensures that the Two7Controller is created when the
/// Two7Screen is first loaded.
class Two7Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Two7Controller());
  }
}
