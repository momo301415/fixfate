import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k8_controller.dart';
import '../models/listviewsection_item_model.dart';

// ignore_for_file: must_be_immutable
class ListviewsectionItemWidget extends StatelessWidget {
  ListviewsectionItemWidget(this.listviewsectionItemModelObj, {Key? key})
    : super(key: key);

  ListviewsectionItemModel listviewsectionItemModelObj;

  var controller = Get.find<K8Controller>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 12.h,
          width: 12.h,
          decoration: BoxDecoration(color: theme.colorScheme.primary),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.h),
          child: Obx(
            () => Text(
              listviewsectionItemModelObj.tf!.value,
              style: CustomTextStyles.bodySmall8,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24.h),
          child: Obx(
            () => Text(
              listviewsectionItemModelObj.nine!.value,
              style: CustomTextStyles.labelSmallErrorContainer,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Obx(
            () => Text(
              listviewsectionItemModelObj.tf1!.value,
              style: CustomTextStyles.pingFangTC4ErrorContainerRegular6,
            ),
          ),
        ),
      ],
    );
  }
}
