import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/k67_screen/models/k67_model.dart';
import 'package:pulsedevice/presentation/k67_screen/widget/item_widget.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import 'controller/k67_controller.dart'; // ignore_for_file: must_be_immutable

/// 家人管理頁面
class K67Screen extends GetWidget<K67Controller> {
  const K67Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    var mediaHeight = Get.height;
    return BaseScaffoldImageHeader(
      title: "lbl66".tr,
      child: Obx(() {
        final hasFamily =
            controller.k67ModelObj.value.itemList.value.isNotEmpty;
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (hasFamily) ...[
            SizedBox(height: 24.h),
            ListView.separated(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 16.h,
                );
              },
              itemCount: controller.k67ModelObj.value.itemList.value.length,
              itemBuilder: (context, index) {
                final item = controller.k67ModelObj.value.itemList.value[index];
                return GestureDetector(
                    onTap: () {
                      controller.goTow7Screen(controller.selectFamily[index]);
                    },
                    child: ItemWidget(item));
              },
            ),
          ] else ...[
            SizedBox(height: mediaHeight * 0.2),
            Container(
              height: 100,
              width: double.infinity,
              child: CustomImageView(
                imagePath: ImageConstant.imgBag,
                height: 82.h,
                width: 102.h,
              ),
            ),
            SizedBox(height: 22.h),
            Text(
              "lbl201".tr,
              style: CustomTextStyles.bodySmallPrimaryContainer,
            ),
            SizedBox(height: mediaHeight * 0.5),
          ]
        ]);
      }),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomElevatedButton(
              text: "lbl202".tr,
              buttonStyle: CustomButtonStyles.none,
              decoration: CustomButtonStyles.gradientCyanToPrimaryDecoration,
              onPressed: () {
                controller.go72Screen();
              },
            ),
            SizedBox(height: 12.h),

            /// 暫時註解分享健康數據功能
            // CustomOutlinedButton(
            //   text: "lbl203".tr,
            //   buttonStyle: CustomButtonStyles.outlinePrimary,
            //   buttonTextStyle: CustomTextStyles.titleMediumPrimary,
            //   onPressed: () {
            //     controller.gok71Screen();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
