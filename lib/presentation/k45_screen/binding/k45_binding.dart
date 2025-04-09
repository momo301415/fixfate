import '../../../core/app_export.dart';
import '../controller/k45_controller.dart';

/// A binding class for the K45Screen.
///
/// This class ensures that the K45Controller is created when the
/// K45Screen is first loaded.
class K45Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K45Controller());
  }
}
