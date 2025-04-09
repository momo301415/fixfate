import '../../../core/app_export.dart';
import '../controller/k38_controller.dart';

/// A binding class for the K38Screen.
///
/// This class ensures that the K38Controller is created when the
/// K38Screen is first loaded.
class K38Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K38Controller());
  }
}
