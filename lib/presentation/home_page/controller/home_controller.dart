import 'package:get/get.dart';
import 'package:pulsedevice/presentation/k29_page/controller/k29_controller.dart';
import 'package:pulsedevice/presentation/k73_screen/controller/k73_controller.dart';

class HomeController extends GetxController {
  final bottomBarIndex = 2.obs;

  void onTabChanged(int index) {
    bottomBarIndex.value = index;

    // 根據 index 主動刷新該 tab 頁資料
    switch (index) {
      case 0:
        Get.find<K73Controller>().getFamilyData();
        Get.find<K73Controller>().getHealthData();
        break;
      case 1:
        break;
    }
  }
}
