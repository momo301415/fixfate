import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/one3_find_device_screen/models/devicelistsection_item_model.dart';
import 'package:pulsedevice/presentation/one3_find_device_screen/models/k24_model.dart';
import 'package:pulsedevice/theme/custom_button_style.dart';
import 'package:pulsedevice/widgets/custom_elevated_button.dart';
import '../../../core/app_export.dart';
import '../models/one3_model.dart';

/// A controller class for the One3Screen.
///
/// This class manages the state of the One3Screen, including the
/// current one3ModelObj
class One3FindDeviceController extends GetxController {
  Rx<One3FindDeviceModel> one3FindDeviceModelObj = One3FindDeviceModel().obs;
  // Rx<K24Model> k24ModelObj = K24Model().obs;
  RxList<DevicelistsectionItemModel> devicelistsectionItemList =
      <DevicelistsectionItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 1300), () {
      devicelistsectionItemList.add(DevicelistsectionItemModel());
    });
  }

  void showMatchDeviceDialog() {
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent, // 重要：设置背景透明
      barrierColor: Colors.black.withOpacity(0.5), // 半透明遮罩
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // 模糊程度
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.0), // 半透明背景
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.maxFinite,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24.h, vertical: 26.h),
                      decoration: AppDecoration.fillWhiteA.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 6.h),
                          CustomImageView(
                            imagePath: ImageConstant.imgClosePrimarycontainer1,
                            height: 10.h,
                            width: 12.h,
                            alignment: Alignment.centerRight,
                            onTap: () {
                              Get.back();
                            },
                          ),
                          SizedBox(height: 4.h),
                          CustomImageView(
                            imagePath: ImageConstant.imgFrame866181,
                            height: 128.h,
                            width: 130.h,
                          ),
                          SizedBox(height: 22.h),
                          SizedBox(
                            width: double.maxFinite,
                            child: Text(
                              "msg_scanfit2".tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: CustomTextStyles
                                  .titleMediumManropePrimaryContainerSemiBold,
                            ),
                          ),
                          SizedBox(height: 26.h),
                          CustomElevatedButton(
                            height: 56.h,
                            text: "lbl33".tr,
                            buttonStyle: CustomButtonStyles.none,
                            decoration: CustomButtonStyles
                                .gradientCyanToPrimaryTL8Decoration,
                            buttonTextStyle: CustomTextStyles.titleMediumManrope,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
