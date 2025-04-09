import '../../../core/app_export.dart';
import '../controller/one9_controller.dart';

/// A binding class for the One9Screen.
///
/// This class ensures that the One9Controller is created when the
/// One9Screen is first loaded.
class One9Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => One9Controller());
  }
}
