import 'package:get/get.dart';

import 'package:pulsedevice/presentation/ruler_piker_test/controller/ruler_picker_test_controller.dart';

class RulerPikerTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RulerPickerTestScreenController());
  }
}
