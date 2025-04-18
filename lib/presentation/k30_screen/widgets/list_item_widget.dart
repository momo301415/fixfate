import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k30_controller.dart';
import '../models/list_item_model.dart';

// ignore_for_file: must_be_immutable
class ListItemWidget extends StatelessWidget {
  ListItemWidget(this.listItemModelObj, {Key? key, required this.onTap})
      : super(
          key: key,
        );

  ListItemModel listItemModelObj;
  final VoidCallback? onTap;

  var controller = Get.find<K30Controller>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8.h,
            vertical: 16.h,
          ),
          decoration: AppDecoration.outlineGray,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return Text(
                  listItemModelObj.tf!.value,
                  style: CustomTextStyles.bodyMediumBluegray900,
                );
              }),
              Spacer(),
              Obx(() {
                return Text(
                  listItemModelObj.tf1!.value,
                  style: listItemModelObj.tf1!.value.isNotEmpty
                      ? CustomTextStyles.bodyMediumBluegray900
                      : CustomTextStyles.bodyMediumGray50001,
                );
              }),
              CustomImageView(
                imagePath: ImageConstant.imgVectorGray50001,
                height: 8.h,
                width: 6.h,
                margin: EdgeInsets.only(left: 16.h),
              )
            ],
          ),
        ));
  }
}
