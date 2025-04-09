import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k89_controller.dart';
import '../models/gridframe_item_model.dart';

// ignore_for_file: must_be_immutable
class GridframeItemWidget extends StatelessWidget {
  GridframeItemWidget(this.gridframeItemModelObj, {Key? key})
      : super(
          key: key,
        );

  GridframeItemModel gridframeItemModelObj;

  var controller = Get.find<K89Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30.h,
        vertical: 8.h,
      ),
      decoration: AppDecoration.outlineGray20001.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder2,
      ),
      child: Obx(
        () => Text(
          gridframeItemModelObj.frame!.value,
          textAlign: TextAlign.center,
          style: CustomTextStyles.bodyLarge16,
        ),
      ),
    );
  }
}
