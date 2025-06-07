import 'package:flutter/material.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/presentation/k6_screen/k6_page.dart';

import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import 'controller/k6_controller.dart';

/// 運動歷史頁面
// ignore_for_file: must_be_immutable
class K6Screen extends GetWidget<K6Controller> {
  K6Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      title: 'lbl256'.tr,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCustomTabBar(
            tabCtrl: controller.tabviewController,
            selectedIndex: controller.tabIndex,
          ),
          Obx(() {
            var index = controller.tabIndex.value;
            return Container(
              height: index == 0 ? 600.v : 600.v,
              child: TabBarView(
                controller: controller.tabviewController,
                children: [
                  K6Page(
                    tabIndex: 0,
                  ),
                  K6Page(
                    tabIndex: 1,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  /// 自定义的 TabBar：两个选项，用 Row + GestureDetector + AnimatedContainer 实现
  Widget _buildCustomTabBar({
    required TabController tabCtrl,
    required RxInt selectedIndex,
  }) {
    return Obx(
      () => Container(
        height: 44.v,
        margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.v),
        decoration: BoxDecoration(
          color: appTheme.whiteA700, // 背景白色
          borderRadius: BorderRadius.circular(22.h), // 整体圆角
          boxShadow: [
            BoxShadow(
              color: appTheme.teal2007f,
              spreadRadius: 2.h,
              blurRadius: 2.h,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: List.generate(2, (i) {
            final bool isSelected = selectedIndex.value == i;
            return Expanded(
              child: GestureDetector(
                onTap: () async {
                  if (!isSelected) {
                    LoadingHelper.show();
                    Future.delayed(Duration(milliseconds: 150));
                    tabCtrl.animateTo(i);
                    selectedIndex.value = i;
                    LoadingHelper.hide();
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 44.v,
                  margin: EdgeInsets.symmetric(horizontal: 4.h, vertical: 4.v),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              appTheme.cyan700,
                              theme.colorScheme.onErrorContainer
                            ],
                          )
                        : null,
                    color: isSelected ? null : Colors.white,
                    borderRadius: BorderRadius.circular(22.h),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    i == 0 ? "lbl253".tr : "lbl255".tr,
                    style: TextStyle(
                      fontSize: 15.fSize,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                      color:
                          isSelected ? Colors.white : const Color(0xFF3A3A3A),
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
}
