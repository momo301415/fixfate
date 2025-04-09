import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/one11_controller.dart';
import '../models/gridview_item_model.dart';

// ignore_for_file: must_be_immutable
class GridviewItemWidget extends StatelessWidget {
  GridviewItemWidget(this.gridviewItemModelObj, {Key? key})
      : super(
          key: key,
        );

  GridviewItemModel gridviewItemModelObj;

  var controller = Get.find<One11Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 74.h,
              width: 162.h,
              decoration: BoxDecoration(
                color: appTheme.whiteA700,
                borderRadius: BorderRadius.circular(
                  8.h,
                ),
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(right: 8.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => CustomImageView(
                          imagePath: gridviewItemModelObj.one!.value,
                          height: 40.h,
                          width: 44.h,
                          margin: EdgeInsets.only(left: 8.h),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Obx(
                          () => Text(
                            gridviewItemModelObj.one1!.value,
                            style: CustomTextStyles.bodySmallPrimary,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 14.h),
                        child: Obx(
                          () => Text(
                            gridviewItemModelObj.tf!.value,
                            style:
                                CustomTextStyles.bodyMediumPrimaryContainer_2,
                          ),
                        ),
                      ),
                      Spacer(),
                      Obx(
                        () => Text(
                          gridviewItemModelObj.seventynine!.value,
                          style: theme.textTheme.headlineMedium,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 4.h,
                            bottom: 8.h,
                          ),
                          child: Obx(
                            () => Text(
                              gridviewItemModelObj.tf1!.value,
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
