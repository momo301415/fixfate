import '../../../core/app_export.dart';
import '../controller/k14_controller.dart';

/// A binding class for the K14Screen.
///
/// This class ensures that the K14Controller is created when the
/// K14Screen is first loaded.
class K14Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K14Controller());
  }
}
