import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/k40_screen/widgets/listpulsering_item_widget.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';

import '../../widgets/custom_elevated_button.dart';
import 'controller/k40_controller.dart'; // ignore_for_file: must_be_immutable

/// 我的設備頁面
class K40Screen extends GetWidget<K40Controller> {
  const K40Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    var mediaHeight = Get.height;

    return BaseScaffoldImageHeader(
      title: "lbl133".tr,
      child: Obx(() {
        final hasDevice =
            controller.k40ModelObj.value.listpulseringItemList.value.isNotEmpty;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!hasDevice) ...[
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
                "lbl134".tr,
                style: CustomTextStyles.bodySmallPrimaryContainer,
              ),
              SizedBox(height: mediaHeight * 0.5),
            ] else ...[
              SizedBox(height: 24.h),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller
                    .k40ModelObj.value.listpulseringItemList.value.length,
                separatorBuilder: (context, index) => SizedBox(height: 8.h),
                itemBuilder: (context, index) {
                  final item = controller
                      .k40ModelObj.value.listpulseringItemList.value[index];
                  return GestureDetector(
                      onTap: () {
                        // controller.goK45Screen(controller.selectDevice[index]);
                        controller.goDeviceDetailPage(item);
                      },
                      child: ListpulseringItemWidget(item));
                },
              ),
              SizedBox(height: mediaHeight * 0.5),
            ],
          ],
        );
      }),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(16.h, 0, 16.h, 50.h),
          child: CustomElevatedButton(
            text: "lbl135".tr,
            buttonStyle: CustomButtonStyles.none,
            decoration: CustomButtonStyles.gradientCyanToPrimaryDecoration,
            onPressed: () async {
              await controller.checkBluetoothPermission();
            },
          )),
    );
  }

  /// Section Widget

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
