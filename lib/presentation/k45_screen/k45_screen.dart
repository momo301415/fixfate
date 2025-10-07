import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_outlined_button.dart';
import 'controller/k45_controller.dart'; // ignore_for_file: must_be_immutable

/// 戒指設備資訊頁面
class K45Screen extends GetWidget<K45Controller> {
  const K45Screen({
    Key? key,
  }) : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      title: "lbl62".tr,
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            _buildStackpulsering(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(16.h, 0, 16.h, 50.h),
        child: CustomOutlinedButton(
          text: "lbl136".tr,
          buttonStyle: CustomButtonStyles.outlinePrimary,
          buttonTextStyle: CustomTextStyles.titleMediumPrimary,
          onPressed: () async {
            controller.showDelete();
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStackpulsering() {
    return SizedBox(
      height: 404.h,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 16.h),
            padding: EdgeInsets.only(top: 30.h),
            decoration: AppDecoration.fillWhiteA.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder24,
            ),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 18.h),
                    CustomImageView(
                      imagePath: ImageConstant.imgFrame86618,
                      height: 84.h,
                      width: 122.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 34.h),
                    Text(
                      "lbl_pulsering3".tr,
                      style:
                          CustomTextStyles.titleMediumManropePrimaryContainer,
                    ),
                    SizedBox(height: 16.h),
                    Obx(() {
                      return ListTile(
                        leading: Text(
                          'msg_power'.tr,
                          style: CustomTextStyles.bodyMedium13,
                        ),
                        trailing: Text(
                          controller.power.value,
                          style: CustomTextStyles.bodyMedium13,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 1),
                      );
                    }),
                    Divider(),
                    Obx(() {
                      return ListTile(
                        leading: Text(
                          'msg_id'.tr,
                          style: CustomTextStyles.bodyMedium13,
                        ),
                        trailing: Text(
                          controller.deviceId.value,
                          style: CustomTextStyles.bodyMedium13,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 1),
                      );
                    }),
                    Divider(),
                    Obx(() {
                      return ListTile(
                        leading: Text(
                          'msg_bind_time'.tr,
                          style: CustomTextStyles.bodyMedium13,
                        ),
                        trailing: Text(
                          controller.createdAt.value,
                          style: CustomTextStyles.bodyMedium13,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 1),
                      );
                    }),
                  ],
                )),
          )
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
