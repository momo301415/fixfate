import '../../../core/app_export.dart';
import '../controller/k85_controller.dart';

/// A binding class for the K85Screen.
///
/// This class ensures that the K85Controller is created when the
/// K85Screen is first loaded.
class K85Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K85Controller());
  }
}
