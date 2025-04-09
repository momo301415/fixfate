import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k83_controller.dart';
import '../models/list_item_model.dart';

// ignore_for_file: must_be_immutable
class ListItemWidget extends StatelessWidget {
  ListItemWidget(this.listItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ListItemModel listItemModelObj;

  var controller = Get.find<K83Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(left: 18.h),
      decoration: AppDecoration.outlineGray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Text(
              listItemModelObj.tf!.value,
              style: CustomTextStyles.titleSmallErrorContainer,
            ),
          ),
          SizedBox(height: 8.h)
        ],
      ),
    );
  }
}
