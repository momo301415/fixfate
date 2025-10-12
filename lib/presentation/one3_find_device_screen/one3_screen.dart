import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/one3_find_device_screen/controller/one3_controller.dart';
import 'package:pulsedevice/presentation/one3_find_device_screen/models/devicelistsection_item_model.dart';
import 'package:pulsedevice/presentation/one3_find_device_screen/widget/devicelistsection_item_widget.dart';
import 'package:pulsedevice/theme/custom_button_style.dart';
import 'package:pulsedevice/widgets/custom_elevated_button.dart';
import 'package:pulsedevice/widgets/custom_rotating_widget.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';

/// 體脂秤綁定頁面
class One3FindDeviceScreen extends GetWidget<One3FindDeviceController> {
  const One3FindDeviceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
        onBack: () {
          controller.onBack();
        },
        title: "lbl29".tr,
        isShowBackButton: true,
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Column(
                spacing: 14,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "msg_scanfit".tr,
                    style: CustomTextStyles.bodySmallPrimaryContainer_1,
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgImage764,
                    height: 200.h,
                    width: 240.h,
                  ),
                  Text(
                    "msg42".tr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.bodySmallPrimaryContainer_1,
                  ),
                ],
              ),
            ),
            _buildSearchingNearbyDevicesRow(),
          ],
        ));
  }

  /// Section Widget

  /// Section Widget
  Widget _buildSearchingNearbyDevicesRow() {
    return Container(
      margin: EdgeInsets.only(left: 12.h, right: 12.h, top: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 36.h),
      decoration: AppDecoration.gray50.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      width: double.maxFinite,
      child: Obx(() => Visibility(
            visible: controller.devices.isEmpty,
            child: Row(
              children: [
                CustomRotatingWidget(
                  child: CustomImageView(
                    imagePath: ImageConstant.img11611,
                    height: 16.h,
                    width: 16.h,
                  ),
                  duration: Duration(seconds: 1),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.h),
                  child: Text(
                    "lbl421".tr,
                    style: CustomTextStyles.labelLargePrimary_1,
                  ),
                ),
              ],
            ),
            replacement: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgUCheckCirclePrimary2,
                        height: 16.h,
                        width: 16.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.h),
                        child: Text(
                          "lbl419".tr,
                          style: CustomTextStyles.labelLargePrimary_1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                _buildDeviceListSection(),
                SizedBox(height: 24.h),
                CustomElevatedButton(
                  height: 58.h,
                  text: "lbl420".tr,
                  leftIcon: Container(
                    margin: EdgeInsets.only(right: 10.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgFirotatecw,
                      height: 16.h,
                      width: 16.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  buttonStyle: CustomButtonStyles.none,
                  decoration:
                      CustomButtonStyles.gradientCyanToPrimaryDecoration,
                ),
                SizedBox(height: 22.h),
                Text(
                  "lbl50".tr,
                  style: CustomTextStyles.bodyLargeBluegray400,
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildDeviceListSection() {
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.devices.length,
        itemBuilder: (context, index) {
          final device = controller.devices[index];
          return ListTile(
            leading: CustomImageView(
              imagePath: ImageConstant.imgFrameErrorcontainer16x16,
              height: 16.h,
              width: 16.h,
            ),
            title: Text("msg_pulsering4".tr),
            subtitle: Text(device.deviceMac!),
            trailing: Text('${device.rssi}' + 'lbl264'.tr),
            onTap: () async {
              print("");
              // TODO: 點選裝置後的行為
              controller.showMatchDeviceDialog(device);
            },
          );
        },
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapImgArrowleftone() {
    Get.back();
  }
}
