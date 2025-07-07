import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import 'controller/k55_controller.dart';
import 'models/list6_25_16fort_item_model.dart';
import 'widgets/list6_25_16fort_item_widget.dart'; // ignore_for_file: must_be_immutable

/// 通知消息頁面
class K55Screen extends GetWidget<K55Controller> {
  const K55Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      title: "lbl60".tr,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
        height: 600.v,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.h),
                decoration: AppDecoration.fillWhiteA.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder24,
                ),
                child: Column(
                  children: [_buildList62516fort(), SizedBox(height: 16.h)],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildList62516fort() {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount:
              controller.k55ModelObj.value.list62516fortItemList.value.length,
          itemBuilder: (context, index) {
            List62516fortItemModel model =
                controller.k55ModelObj.value.list62516fortItemList.value[index];
            return List62516fortItemWidget(
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
