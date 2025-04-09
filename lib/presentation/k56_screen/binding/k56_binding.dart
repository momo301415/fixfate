import '../../../core/app_export.dart';
import '../controller/k56_controller.dart';

/// A binding class for the K56Screen.
///
/// This class ensures that the K56Controller is created when the
/// K56Screen is first loaded.
class K56Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K56Controller());
  }
}
