import '../../../core/app_export.dart';
import '../controller/k61_controller.dart';

/// A binding class for the K61Screen.
///
/// This class ensures that the K61Controller is created when the
/// K61Screen is first loaded.
class K61Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K61Controller());
  }
}
