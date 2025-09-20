import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k8_controller.dart';
import '../models/listweightvalue_item_model.dart';

// ignore_for_file: must_be_immutable
class ListweightvalueItemWidget extends StatelessWidget {
  ListweightvalueItemWidget(this.listweightvalueItemModelObj, {Key? key})
    : super(key: key);

  ListweightvalueItemModel listweightvalueItemModelObj;

  var controller = Get.find<K8Controller>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: 62.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => Text(
                          listweightvalueItemModelObj.weightValue!.value,
                          style: CustomTextStyles.titleMediumPrimary_2,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 4.h),
                          child: Obx(
                            () => Text(
                              listweightvalueItemModelObj.one!.value,
                              style: CustomTextStyles.bodySmallBluegray40010,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => Text(
              listweightvalueItemModelObj.one1!.value,
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
