import '../../../core/app_export.dart';
import '../controller/three4_controller.dart';

/// A binding class for the Three4Screen.
///
/// This class ensures that the Three4Controller is created when the
/// Three4Screen is first loaded.
class Three4Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Three4Controller());
  }
}
