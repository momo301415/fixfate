import '../../../core/app_export.dart';
import '../controller/k77_controller.dart';

/// A binding class for the K77Screen.
///
/// This class ensures that the K77Controller is created when the
/// K77Screen is first loaded.
class K77Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K77Controller());
  }
}
