import '../../../core/app_export.dart';
import '../controller/one4_controller.dart';

/// A binding class for the One4Screen.
///
/// This class ensures that the One4Controller is created when the
/// One4Screen is first loaded.
class One4Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => One4Controller());
  }
}
