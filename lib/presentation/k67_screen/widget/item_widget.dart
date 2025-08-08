import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/app_export.dart';
import 'package:pulsedevice/presentation/k67_screen/controller/k67_controller.dart';
import 'package:pulsedevice/presentation/k67_screen/models/k67_model.dart';

// ignore_for_file: must_be_immutable
class ItemWidget extends StatelessWidget {
  ItemWidget(this.itemModelObj, {Key? key})
      : super(
          key: key,
        );

  ItemModel itemModelObj;

  var controller = Get.find<K67Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.h),
      padding: EdgeInsets.symmetric(
        horizontal: 24.h,
        vertical: 16.h,
      ),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: itemModelObj.path?.value == ""
                ? ImageConstant.imgEllipse82
                : itemModelObj.path?.value,
            height: 48.h,
            width: 48.h,
            fit: BoxFit.cover,
            radius: BorderRadius.circular(
              24.h,
            ),
          ),
          SizedBox(width: 16.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    itemModelObj.two!.value,
                    style: CustomTextStyles.titleMediumManropePrimaryContainer,
                  ),
                ),
                Obx(
                  () => Text(
                    itemModelObj.tf!.value,
                    style: CustomTextStyles.bodySmall10,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
