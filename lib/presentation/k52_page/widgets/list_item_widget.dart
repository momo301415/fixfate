import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k52_controller.dart';
import '../models/list_item_model.dart';

// ignore_for_file: must_be_immutable
class ListItemWidget extends StatelessWidget {
  ListItemWidget(this.listItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ListItemModel listItemModelObj;

  var controller = Get.find<K52Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.h, 20.h, 20.h, 18.h),
      decoration: AppDecoration.outlineGray,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => Text(
              listItemModelObj.tf!.value,
              style: CustomTextStyles.titleSmall14,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Obx(
              () => Text(
                listItemModelObj.tf1!.value,
                style: CustomTextStyles.bodySmallPrimaryContainer_3,
              ),
            ),
          )
        ],
      ),
    );
  }
}
