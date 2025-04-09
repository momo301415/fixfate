import '../../../core/app_export.dart';
import '../controller/k72_controller.dart';

/// A binding class for the K72Screen.
///
/// This class ensures that the K72Controller is created when the
/// K72Screen is first loaded.
class K72Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K72Controller());
  }
}
