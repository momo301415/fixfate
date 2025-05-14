import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import 'controller/k62_controller.dart';
import 'models/list_item_model.dart';
import 'widgets/list_item_widget.dart'; // ignore_for_file: must_be_immutable

/// 目標設定頁面
class K62Screen extends GetWidget<K62Controller> {
  const K62Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      title: "lbl64".tr,
      onBack: () async {
        print("click onBack");
        await controller.saveGoalProfile();
      },
      child: Container(
        child: _buildList(),
      ),
    );
  }

  /// Section Widget
  Widget _buildList() {
    return Padding(
      padding: EdgeInsets.only(left: 16.h, top: 0.h, right: 16.h, bottom: 50.h),
      child: Obx(
        () => ListView.separated(
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 12.h,
            );
          },
          itemCount: controller.k62ModelObj.value.listItemList.value.length,
          itemBuilder: (context, index) {
            ListItemModel model =
                controller.k62ModelObj.value.listItemList.value[index];
            return ListItemWidget(
              model,
            );
          },
        ),
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
