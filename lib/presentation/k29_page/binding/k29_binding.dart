import '../../../core/app_export.dart';
import '../controller/k29_controller.dart';

/// A binding class for the K30Screen.
///
/// This class ensures that the K30Controller is created when the
/// K30Screen is first loaded.
class K29Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K29Controller());
  }
}
