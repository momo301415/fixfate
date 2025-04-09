import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/one10_controller.dart';
import '../models/list_one_item_model.dart';

// ignore_for_file: must_be_immutable
class ListOneItemWidget extends StatelessWidget {
  ListOneItemWidget(this.listOneItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ListOneItemModel listOneItemModelObj;

  var controller = Get.find<One10Controller>();

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
            imagePath: ImageConstant.imgEllipse8248x48,
            height: 48.h,
            width: 48.h,
            radius: BorderRadius.circular(
              24.h,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    listOneItemModelObj.two!.value,
                    style: CustomTextStyles.titleMediumManropePrimaryContainer,
                  ),
                ),
                Obx(
                  () => Text(
                    listOneItemModelObj.tf!.value,
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
