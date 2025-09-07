import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/presentation/home_page/controller/home_controller.dart';
import 'package:pulsedevice/presentation/k13_screen/k13_screen.dart';
import 'package:pulsedevice/presentation/k29_page/k29_page.dart';
import 'package:pulsedevice/presentation/k73_screen/k73_screen.dart';
import 'package:pulsedevice/presentation/k19_screen/k19_screen.dart';
import 'package:pulsedevice/widgets/custom_bottom_bar.dart';

// app主頁面父級別
class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  final List<Widget> pages = [
    K73Screen(),
    K29Page(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          clipBehavior: Clip.none,
          children: [
            // 底層：頁面切換
            IndexedStack(
              index: controller.bottomBarIndex.value,
              children: pages,
            ),

            // 頂層：全局諮詢覆蓋
            // Obx(() => IgnorePointer(
            //       ignoring: !controller.cc.isK19Visible.value,
            //       child: AnimatedSlide(
            //         duration: const Duration(milliseconds: 500),
            //         curve: Curves.easeInOut,
            //         offset: controller.cc.isK19Visible.value
            //             ? Offset.zero
            //             : const Offset(0, -1),
            //         child: const K19Screen(),
            //       ),
            //     )),
            Obx(() => IgnorePointer(
                  ignoring: !controller.cc.isK19Visible.value,
                  child: AnimatedSlide(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    offset: controller.cc.isK19Visible.value
                        ? Offset.zero
                        : const Offset(0, -1),
                    child: const K13Screen(),
                  ),
                )),

            // 底部導航欄
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomBottomBar(
                onChanged: (index) {
                  if (controller.cc.isK19Visible.value) {
                    return;
                  }
                  controller.onTabChanged(index);
                },
              ),
            ),
          ],
        ));
  }
}
