import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k29_controller.dart';
import '../models/list_one_item_model.dart';

// ignore_for_file: must_be_immutable
class ListOneItemWidget extends StatelessWidget {
  ListOneItemWidget(this.listOneItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ListOneItemModel listOneItemModelObj;

  var controller = Get.find<K29Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 102.h,
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 6.h,
      ),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => CustomImageView(
              imagePath: listOneItemModelObj.one!.value,
              height: 80.h,
              width: 80.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            child: Obx(
              () => Text(
                listOneItemModelObj.two!.value,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyles.bodyMedium13,
              ),
            ),
          )
        ],
      ),
    );
  }
}
