import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/one7_controller.dart';
import '../models/gridmonth_item_model.dart';

// ignore_for_file: must_be_immutable
class GridmonthItemWidget extends StatelessWidget {
  GridmonthItemWidget(this.gridmonthItemModelObj, {Key? key})
      : super(
          key: key,
        );

  GridmonthItemModel gridmonthItemModelObj;

  var controller = Get.find<One7Controller>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        gridmonthItemModelObj.month!.value,
        style: CustomTextStyles.titleLargeErrorContainer,
      ),
    );
  }
}
