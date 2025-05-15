import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k10_controller.dart'; // ignore_for_file: must_be_immutable

/// 註冊設備頁面
class K10Screen extends GetWidget<K10Controller> {
  const K10Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: SizeUtils.height,
        decoration: AppDecoration.gradientLightBlueToOnErrorContainer,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: 768.h,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgUnionWhiteA700,
                    height: 506.h,
                    width: double.infinity,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 28.h),
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Column(
                      children: [
                        _buildHeader(),
                        SizedBox(height: 32.h),
                        _buildDeviceSection(), // 裝置 + 按鈕
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section - Header
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 56.h),
      decoration: AppDecoration.column11,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            child: Text(
              "lbl29".tr,
              style: CustomTextStyles.titleLarge20,
            ),
          ),
          Text(
            "lbl30".tr,
            style: CustomTextStyles.bodySmallBluegray400,
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  /// Section - Devices + 按鈕
  Widget _buildDeviceSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 32.h),
      decoration: AppDecoration.gray50.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDeviceList(), // ✅ 這邊會變成有滾動
          SizedBox(height: 60.h),
          _buildTf(),
          SizedBox(height: 22.h),
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Text(
                "lbl32".tr,
                style: CustomTextStyles.bodyLargeBluegray400,
              )),
        ],
      ),
    );
  }

  /// Section - Device List
  Widget _buildDeviceList() {
    return Obx(() {
      if (controller.devices.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Center(
            child: Text(
              "device_not_found".tr,
              style: CustomTextStyles.bodyLargeGray500,
            ),
          ),
        );
      }
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 300.h, // ⚡ 最多顯示300高度，超出可以滾動
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: controller.devices.length,
          separatorBuilder: (_, __) => Divider(color: appTheme.gray300),
          itemBuilder: (context, index) {
            final device = controller.devices[index];
            return ListTile(
              leading: CustomImageView(
                imagePath: ImageConstant.imgFrameErrorcontainer16x16,
                height: 16.h,
                width: 16.h,
              ),
              title: Text(device.name),
              subtitle: Text(device.macAddress),
              trailing: Text('${device.rssiValue}'),
              onTap: () async {
                print("");
                // TODO: 點選裝置後的行為
                controller.showConnectDevice(device);
              },
            );
          },
        ),
      );
    });
  }

  /// Section - 確定按鈕
  Widget _buildTf() {
    return CustomElevatedButton(
      height: 58.h,
      text: "lbl31".tr,
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
      decoration: CustomButtonStyles.gradientCyanToPrimaryDecoration,
      onPressed: () async {
        await controller.scanDevices();
      },
    );
  }
}
