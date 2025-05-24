import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/app_export.dart';
import 'package:pulsedevice/presentation/k76_screen/controller/k76_controller.dart';
import 'package:pulsedevice/presentation/k76_screen/widget/list_item_widget.dart';
import 'package:pulsedevice/presentation/k77_screen/k77_screen.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';

/// 健康-主要控制頁面
class K76Screen extends GetView<K76Controller> {
  const K76Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
        title: "lbl243".tr,
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
                      return K77Screen();
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
