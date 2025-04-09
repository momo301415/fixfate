import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k30_controller.dart';
import '../models/list_item_model.dart';

// ignore_for_file: must_be_immutable
class ListItemWidget extends StatelessWidget {
  ListItemWidget(this.listItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ListItemModel listItemModelObj;

  var controller = Get.find<K30Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 16.h,
      ),
      decoration: AppDecoration.outlineGray,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Text(
              listItemModelObj.tf!.value,
              style: CustomTextStyles.bodyMediumBluegray900,
            ),
          ),
          Spacer(),
          Obx(
            () => Text(
              listItemModelObj.tf1!.value,
              style: CustomTextStyles.bodyMediumGray50001,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgVectorGray50001,
            height: 8.h,
            width: 6.h,
            margin: EdgeInsets.only(left: 16.h),
          )
        ],
      ),
    );
  }
}
