import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k42_controller.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';
import 'package:yc_product_plugin/yc_product_plugin_data_type.dart';

// ignore_for_file: must_be_immutable
/// android藍牙配對dialog
class K42Dialog extends StatelessWidget {
  K42Dialog(this.controller, {Key? key, required this.bluetoothDevice})
      : super(
          key: key,
        );
  final BluetoothDevice bluetoothDevice;
  K42Controller controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 24.h,
            vertical: 26.h,
          ),
          decoration: AppDecoration.fillWhiteA.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 6.h),
              CustomImageView(
                imagePath: ImageConstant.imgClosePrimarycontainer,
                height: 10.h,
                width: 12.h,
                alignment: Alignment.centerRight,
                onTap: () {
                  onTapImgCloseone();
                },
              ),
              SizedBox(height: 20.h),
              CustomImageView(
                imagePath: ImageConstant.imgFrame86618,
                height: 92.h,
                width: 130.h,
              ),
              SizedBox(height: 46.h),
              Text(
                "msg_pulsering".tr,
                style:
                    CustomTextStyles.titleMediumManropePrimaryContainerSemiBold,
              ),
              SizedBox(height: 48.h),
              CustomElevatedButton(
                height: 56.h,
                text: "lbl33".tr,
                buttonStyle: CustomButtonStyles.none,
                decoration:
                    CustomButtonStyles.gradientCyanToPrimaryTL8Decoration,
                buttonTextStyle: CustomTextStyles.titleMediumManrope,
                onPressed: () {
                  controller.connectToDevice(bluetoothDevice);
                },
              )
            ],
          ),
        )
      ],
    );
  }

  /// Navigates to the previous screen.
  onTapImgCloseone() {
    Get.back();
  }
}
