import 'package:pulsedevice/core/hiveDb/sport_record.dart';

import '../../../core/app_export.dart';
import '../models/k7_model.dart';

/// A controller class for the K7Screen.
///
/// This class manages the state of the K7Screen, including the
/// current k7ModelObj
class K7Controller extends GetxController {
  Rx<K7Model> k7ModelObj = K7Model().obs;
  late SportRecord record;

  @override
  void onInit() {
    super.onInit();
    record = Get.arguments as SportRecord;
    print("""record: ${record.time} ${record.avgBpm}""");
  }
}
