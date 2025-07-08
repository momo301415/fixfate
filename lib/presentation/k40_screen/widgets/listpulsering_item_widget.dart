import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k40_controller.dart';
import '../models/listpulsering_item_model.dart';

// ignore_for_file: must_be_immutable
class ListpulseringItemWidget extends StatelessWidget {
  ListpulseringItemWidget(this.listpulseringItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ListpulseringItemModel listpulseringItemModelObj;

  var controller = Get.find<K40Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.h),
      padding: EdgeInsets.symmetric(
        horizontal: 22.h,
        vertical: 24.h,
      ),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    listpulseringItemModelObj.pulsering!.value,
                    style: CustomTextStyles.titleMediumManropePrimaryContainer,
                  ),
                ),
                Obx(
                  () => Text(
                    listpulseringItemModelObj.power!.value,
                    style: CustomTextStyles.bodySmall10,
                  ),
                ),
                Obx(
                  () => Text(
                    listpulseringItemModelObj.id!.value,
                    style: CustomTextStyles.bodySmall10,
                  ),
                ),
                Obx(
                  () => Text(
                    listpulseringItemModelObj.tf!.value,
                    style: CustomTextStyles.bodySmall10,
                  ),
                )
              ],
            ),
          ),
          Obx(
            () => CustomImageView(
              imagePath: listpulseringItemModelObj.pulsering1!.value,
              height: 38.h,
              width: 54.h,
            ),
          )
        ],
      ),
    );
  }
}
