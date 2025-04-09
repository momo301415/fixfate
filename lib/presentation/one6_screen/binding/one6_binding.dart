import '../../../core/app_export.dart';
import '../controller/one6_controller.dart';

/// A binding class for the One6Screen.
///
/// This class ensures that the One6Controller is created when the
/// One6Screen is first loaded.
class One6Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => One6Controller());
  }
}
