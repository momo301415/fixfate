import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/presentation/bg_log_page/bg_log_page.dart';
import 'package:pulsedevice/presentation/home_page/controller/home_controller.dart';
import 'package:pulsedevice/presentation/k29_page/k29_page.dart';
import 'package:pulsedevice/presentation/k73_screen/chat_screenswitcher.dart';
import 'package:pulsedevice/presentation/k73_screen/k73_screen.dart';
import 'package:pulsedevice/widgets/custom_bottom_bar.dart';

// app主頁面父級別
class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  final List<Widget> pages = [
    ChatScreenSwitcher(),
    // K73Screen(),
    // BgLogPage(),
    K29Page(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            IndexedStack(
              index: controller.bottomBarIndex.value,
              children: pages,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: controller.cc.isK19Visible.value
                  ? Container()
                  : CustomBottomBar(
                      onChanged: (index) {
                        controller.onTabChanged(index);
                      },
                    ),
            ),
          ],
        ));
  }
}
