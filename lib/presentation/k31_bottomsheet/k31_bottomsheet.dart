import 'package:flutter/material.dart';
import 'package:pulsedevice/core/utils/image_picker.dart';
import '../../core/app_export.dart';
import 'controller/k31_controller.dart';

// ignore_for_file: must_be_immutable
/// 相機/相簿 Bottomsheet
class K31Bottomsheet extends StatelessWidget {
  K31Bottomsheet(this.controller, {Key? key})
      : super(
          key: key,
        );

  K31Controller controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 40.h,
      ),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
              onTap: () async {
                final image = await ImagePickerHelper.pickFromCamera();
                if (image != null) {
                  Get.back(result: image.path);
                }
              },
              child: Text(
                "lbl125".tr,
                style: theme.textTheme.bodyLarge,
              )),
          SizedBox(height: 32.h),
          GestureDetector(
              onTap: () async {
                final image = await ImagePickerHelper.pickFromGallery();
                if (image != null) {
                  Get.back(result: image.path);
                }
              },
              child: Text(
                "lbl126".tr,
                style: theme.textTheme.bodyLarge,
              )),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: Divider(
              color: appTheme.gray200,
            ),
          ),
          SizedBox(height: 16.h),
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Text(
                "lbl50".tr,
                style: CustomTextStyles.bodyLargeGray500_1,
              )),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
