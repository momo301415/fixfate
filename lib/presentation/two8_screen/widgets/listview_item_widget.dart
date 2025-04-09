import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/two8_controller.dart';
import '../models/listview_item_model.dart';

// ignore_for_file: must_be_immutable
class ListviewItemWidget extends StatelessWidget {
  ListviewItemWidget(this.listviewItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ListviewItemModel listviewItemModelObj;

  var controller = Get.find<Two8Controller>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
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
                                imagePath: listviewItemModelObj.one!.value,
                                height: 40.h,
                                width: 44.h,
                                margin: EdgeInsets.only(left: 8.h),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Obx(
                                () => Text(
                                  listviewItemModelObj.one1!.value,
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
                                  listviewItemModelObj.tf!.value,
                                  style: CustomTextStyles
                                      .bodyMediumPrimaryContainer_2,
                                ),
                              ),
                            ),
                            Spacer(),
                            Obx(
                              () => Text(
                                listviewItemModelObj.seventynine!.value,
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
                                    listviewItemModelObj.tf1!.value,
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
          ),
        ),
        Expanded(
          child: Container(
            height: 88.h,
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
                          children: [
                            Obx(
                              () => CustomImageView(
                                imagePath: listviewItemModelObj.three!.value,
                                height: 40.h,
                                width: 40.h,
                                margin: EdgeInsets.only(left: 8.h),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Column(
                                  spacing: 2,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.h,
                                        vertical: 2.h,
                                      ),
                                      decoration:
                                          AppDecoration.fillOnError.copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder8,
                                      ),
                                      child: Obx(
                                        () => Text(
                                          listviewItemModelObj.tf2!.value,
                                          textAlign: TextAlign.center,
                                          style: CustomTextStyles
                                              .labelMediumWhiteA700,
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => Text(
                                        listviewItemModelObj.oneOne!.value,
                                        style:
                                            CustomTextStyles.bodySmallPrimary,
                                      ),
                                    )
                                  ],
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
                              padding: EdgeInsets.only(left: 16.h),
                              child: Obx(
                                () => Text(
                                  listviewItemModelObj.tf3!.value,
                                  style: CustomTextStyles
                                      .bodyMediumPrimaryContainer_2,
                                ),
                              ),
                            ),
                            Spacer(),
                            Obx(
                              () => Text(
                                listviewItemModelObj.ninetyeight!.value,
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
                                    listviewItemModelObj.tf4!.value,
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
          ),
        )
      ],
    );
  }
}
