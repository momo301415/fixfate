import '../../../core/app_export.dart';
import '../controller/k73_controller.dart';

/// A binding class for the K73Screen.
///
/// This class ensures that the K73Controller is created when the
/// K73Screen is first loaded.
class K73Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K73Controller());
  }
}
