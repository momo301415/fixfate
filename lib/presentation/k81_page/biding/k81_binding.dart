import '../../../core/app_export.dart';
import '../controller/k81_controller.dart';

/// A binding class for the K81Screen.
///
/// This class ensures that the K81Controller is created when the
/// K81Page is first loaded.
class K81Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K81Controller());
  }
}
