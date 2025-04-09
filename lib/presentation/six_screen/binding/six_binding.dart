import '../../../core/app_export.dart';
import '../controller/six_controller.dart';

/// A binding class for the SixScreen.
///
/// This class ensures that the SixController is created when the
/// SixScreen is first loaded.
class SixBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SixController());
  }
}
