import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pulsedevice/presentation/k76_screen/model/k76_model.dart';
import 'package:pulsedevice/presentation/k77_screen/controller/k77_controller.dart';

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
    tabController = TabController(
        length: K76ModelObj.value.listIconBarModelObj.value.length,
        vsync: this);
    iconKeys = List.generate(K76ModelObj.value.listIconBarModelObj.value.length,
        (index) => GlobalKey());
    tabController.addListener(() {
      selectedIndex.value = tabController.index;
      _scrollToIcon(tabController.index);
    });
    iconScrollController = ScrollController();
    initController();
  }

  @override
  void onClose() {
    tabController.dispose();
    iconScrollController.dispose();
    super.onClose();
  }

  void initController() {
    Get.put(K77Controller());
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
