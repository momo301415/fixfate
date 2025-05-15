import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/k52_page2/k52_page2.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../k52_page/k52_page.dart';
import 'controller/k53_controller.dart';

// ignore_for_file: must_be_immutable
/// 警報紀錄頁面
class K53Screen extends GetWidget<K53Controller> {
  const K53Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      title: "lbl59".tr,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildCustomTabBar(
              controller: controller.tabviewController,
              selectedIndex: controller.selectedIndex),
          Obx(() {
            var index = controller.selectedIndex.value;
            return Container(
              height: index == 0 ? 600.v : 430.v,
              child: TabBarView(
                controller: controller.tabviewController,
                children: [
                  K52Page(),
                  K52Page2(),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget buildCustomTabBar({
    required TabController controller,
    required RxInt selectedIndex,
  }) {
    return Obx(
      () => Container(
        height: 44.v,
        margin: EdgeInsets.symmetric(horizontal: 16.h),
        padding: EdgeInsets.symmetric(vertical: 4.v, horizontal: 4.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22.h),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: List.generate(2, (i) {
            final selected = selectedIndex.value == i;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  if (!selected) {
                    controller.animateTo(i);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 44.v,
                  margin: EdgeInsets.symmetric(horizontal: 4.h),
                  decoration: BoxDecoration(
                    gradient: selected
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF5BB5C4), Color(0xFF1C6B91)],
                          )
                        : null,
                    color: selected ? null : Colors.white,
                    borderRadius: BorderRadius.circular(22.h),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    i == 0 ? "lbl158".tr : "lbl159".tr,
                    style: TextStyle(
                      fontSize: 15.fSize,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                      color: selected ? Colors.white : const Color(0xFF3A3A3A),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
