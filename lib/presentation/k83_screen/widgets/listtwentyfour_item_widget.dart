import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k83_controller.dart';
import '../models/listtwentyfour_item_model.dart';

// ignore_for_file: must_be_immutable
class ListtwentyfourItemWidget extends StatelessWidget {
  ListtwentyfourItemWidget(this.listtwentyfourItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ListtwentyfourItemModel listtwentyfourItemModelObj;

  var controller = Get.find<K83Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      width: 26.h,
      margin: EdgeInsets.only(bottom: 6.h),
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
                          listtwentyfourItemModelObj.twentyfour!.value,
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: Obx(
                            () => Text(
                              listtwentyfourItemModelObj.tf!.value,
                              style: CustomTextStyles.bodySmall10,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Obx(
            () => Text(
              listtwentyfourItemModelObj.tf1!.value,
              style: theme.textTheme.bodySmall,
            ),
          )
        ],
      ),
    );
  }
}
