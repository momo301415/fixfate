import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pulsedevice/presentation/k76_screen/model/k76_model.dart';
import 'package:pulsedevice/presentation/k77_page/controller/k77_controller.dart';
import 'package:pulsedevice/presentation/k78_page/controller/k78_controller.dart';
import 'package:pulsedevice/presentation/k79_page/controller/k79_controller.dart';
import 'package:pulsedevice/presentation/k80_page/controller/k80_controller.dart';
import 'package:pulsedevice/presentation/k81_page/controller/k81_controller.dart';
import 'package:pulsedevice/presentation/k83_page/controller/k83_controller.dart';
import 'package:pulsedevice/presentation/k84_page/controller/k84_controller.dart';

import '../../k82_page/controller/k82_controller.dart';

class K76Controller extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<K76Model> K76ModelObj = K76Model().obs;
  RxInt selectedIndex = 0.obs;
  late TabController tabController;
  late ScrollController iconScrollController;
  late List<GlobalKey> iconKeys;
  @override
  void onInit() {
    super.onInit();
    final length = K76ModelObj.value.listIconBarModelObj.value.length;
    final initialIndex = (Get.arguments ?? 0) as int;

    tabController = TabController(length: length, vsync: this);
    iconScrollController = ScrollController();
    iconKeys = List.generate(length, (_) => GlobalKey());

    tabController.addListener(() {
      selectedIndex.value = tabController.index;
      _scrollToIcon(tabController.index);
    });

    initController();

    // 延遲跳轉初始 index
    Future.delayed(Duration.zero, () {
      tabController.index = initialIndex;
      selectedIndex.value = initialIndex;
      _scrollToIcon(initialIndex);
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    iconScrollController.dispose();
    super.onClose();
  }

  void initController() {
    Get.put(K77Controller());
    Get.put(K78Controller());
    Get.put(K79Controller());
    Get.put(K80Controller());
    Get.put(K81Controller());
    Get.put(K82Controller());
    Get.put(K83Controller());
    Get.put(K84Controller());
  }

  void onIconTap(int index) {
    selectedIndex.value = index;
    tabController.animateTo(index);
    _scrollToIcon(index);
  }

  void _scrollToIcon(int index) {
    final key = iconKeys[index];
    final itemContext = key.currentContext;
    if (itemContext != null) {
      Scrollable.ensureVisible(itemContext,
          duration: Duration(milliseconds: 300),
          alignment: 0.5,
          curve: Curves.easeInOut);
    }
  }
}
