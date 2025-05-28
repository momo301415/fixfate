import 'package:pulsedevice/presentation/k78_page/controller/k78_controller.dart';

import '../../../core/app_export.dart';

/// A binding class for the K77Screen.
///
/// This class ensures that the K77Controller is created when the
/// K78Page is first loaded.
class K78Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => K78Controller());
  }
}
