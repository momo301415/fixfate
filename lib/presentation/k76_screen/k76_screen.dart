import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/app_export.dart';
import 'package:pulsedevice/presentation/k76_screen/controller/k76_controller.dart';
import 'package:pulsedevice/presentation/k76_screen/widget/list_item_widget.dart';
import 'package:pulsedevice/presentation/k77_page/k77_page.dart';
import 'package:pulsedevice/presentation/k78_page/k78_page.dart';
import 'package:pulsedevice/presentation/k79_page/k79_page.dart';
import 'package:pulsedevice/presentation/k80_page/k80_page.dart';
import 'package:pulsedevice/presentation/k81_page/k81_page.dart';
import 'package:pulsedevice/presentation/k82_page/k82_page.dart';
import 'package:pulsedevice/presentation/k83_page/k83_page.dart';
import 'package:pulsedevice/presentation/k84_page/k84_page.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';

/// 健康-主要控制頁面
class K76Screen extends GetView<K76Controller> {
  const K76Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
        onBack: () {
          Get.back(result: true);
        },
        enableScroll: false,
        title: controller.gc.familyId.value.isEmpty
            ? "lbl243".tr
            : controller.gc.familyName.value + " 的數據偵測",
        child: Container(
          height: 796.h,
          child: Column(
            children: [
              SizedBox(
                  height: 60.v,
                  child: Obx(
                    () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: controller.iconScrollController,
                      itemCount: controller
                          .K76ModelObj.value.listIconBarModelObj.value.length,
                      itemBuilder: (context, index) {
                        return ListItemWidget(
                          controller.K76ModelObj.value.listIconBarModelObj
                              .value[index],
                          index: index,
                          keyItem: controller.iconKeys[index],
                        );
                      },
                    ),
                  )),
              SizedBox(height: 8.h),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: controller
                      .K76ModelObj.value.listIconBarModelObj.value
                      .map((item) {
                    if (item.label?.value == "心率") {
                      return K77Page();
                    }
                    //else if (item.label?.value == "氧氣指數") {
                    //   return K78Page();
                    // }
                    else if (item.label!.value == "體表溫度") {
                      return K79Page();
                    }
                    // else if (item.label?.value == "壓力") {
                    //   return K80Page();
                    // }
                    else if (item.label?.value == "步數") {
                      return K81Page();
                    } else if (item.label?.value == "睡眠") {
                      return K82Page();
                    } else if (item.label?.value == "卡路里") {
                      return K83Page();
                    } else if (item.label!.value.contains("距離")) {
                      return K84Page();
                    } else {
                      return Center(child: Text("這是 ${item.label} 頁面"));
                    }
                  }).toList(),
                ),
              ),
            ],
          ),
        ));
  }
}
