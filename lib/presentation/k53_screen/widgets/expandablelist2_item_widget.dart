import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k53_controller.dart';
import '../models/expandablelist2_item_model.dart';

// ignore_for_file: must_be_immutable
class Expandablelist2ItemWidget extends StatelessWidget {
  Expandablelist2ItemWidget(this.expandablelist2ItemModelObj, {Key? key})
      : super(
          key: key,
        );

  Expandablelist2ItemModel expandablelist2ItemModelObj;

  var controller = Get.find<K53Controller>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 14.h,
              vertical: 12.h,
            ),
            decoration: AppDecoration.fillGray30066.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder24,
            ),
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text(
                    "lbl_2025_08".tr,
                    style: CustomTextStyles.bodyMediumPrimaryContainer_1,
                  ),
                )
              ],
            ),
          ),
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(18.h, 6.h, 18.h, 4.h),
                    decoration: AppDecoration.outlineGray,
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "lbl160".tr,
                                    style: CustomTextStyles
                                        .titleMediumPrimaryContainer16,
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    margin: EdgeInsets.only(right: 14.h),
                                    child: Container(
                                      height: 4.h,
                                      width: 218.h,
                                      decoration: BoxDecoration(
                                        color: appTheme.gray200,
                                        borderRadius: BorderRadius.circular(
                                          2.h,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          2.h,
                                        ),
                                        child: LinearProgressIndicator(
                                          value: 0.26,
                                          backgroundColor: appTheme.gray200,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            theme.colorScheme.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Text(
                            "lbl_102".tr,
                            style:
                                CustomTextStyles.headlineLargePrimaryContainer,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Text(
                            "lbl161".tr,
                            style: CustomTextStyles.bodySmallPrimaryContainer_2,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(18.h, 6.h, 18.h, 4.h),
                    decoration: AppDecoration.outlineGray,
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "lbl162".tr,
                                    style: CustomTextStyles
                                        .titleMediumPrimaryContainer16,
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    margin: EdgeInsets.only(right: 8.h),
                                    decoration: AppDecoration.gray100.copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.circleBorder2,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 148.h,
                                          child: Divider(
                                            color: theme.colorScheme.primary,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Text(
                            "lbl_202".tr,
                            style:
                                CustomTextStyles.headlineLargePrimaryContainer,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Text(
                            "lbl161".tr,
                            style: CustomTextStyles.bodySmallPrimaryContainer_2,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(18.h, 6.h, 18.h, 4.h),
                    decoration: AppDecoration.outlineGray,
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "lbl163".tr,
                                    style: CustomTextStyles
                                        .titleMediumPrimaryContainer16,
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    margin: EdgeInsets.only(right: 14.h),
                                    decoration: AppDecoration.gray100.copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.circleBorder2,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 98.h,
                                          child: Divider(
                                            color: theme.colorScheme.primary,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Text(
                            "lbl_162".tr,
                            style:
                                CustomTextStyles.headlineLargePrimaryContainer,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Text(
                            "lbl161".tr,
                            style: CustomTextStyles.bodySmallPrimaryContainer_2,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(18.h, 6.h, 18.h, 4.h),
                    decoration: AppDecoration.outlineGray,
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "lbl164".tr,
                                    style: CustomTextStyles
                                        .titleMediumPrimaryContainer16,
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    margin: EdgeInsets.only(right: 26.h),
                                    child: Container(
                                      height: 4.h,
                                      width: 218.h,
                                      decoration: BoxDecoration(
                                        color: appTheme.gray200,
                                        borderRadius: BorderRadius.circular(
                                          2.h,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          2.h,
                                        ),
                                        child: LinearProgressIndicator(
                                          value: 0.17,
                                          backgroundColor: appTheme.gray200,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            theme.colorScheme.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Text(
                            "lbl_83".tr,
                            style:
                                CustomTextStyles.headlineLargePrimaryContainer,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Text(
                            "lbl161".tr,
                            style: CustomTextStyles.bodySmallPrimaryContainer_2,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(
                      left: 20.h,
                      top: 10.h,
                      right: 20.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 6.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "lbl165".tr,
                                  style: CustomTextStyles
                                      .titleMediumPrimaryContainer16,
                                ),
                                Container(
                                  width: double.maxFinite,
                                  margin: EdgeInsets.only(right: 28.h),
                                  child: Container(
                                    height: 4.h,
                                    width: 218.h,
                                    decoration: BoxDecoration(
                                      color: appTheme.gray200,
                                      borderRadius: BorderRadius.circular(
                                        2.h,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        2.h,
                                      ),
                                      child: LinearProgressIndicator(
                                        value: 0.07,
                                        backgroundColor: appTheme.gray200,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          theme.colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "lbl_22".tr,
                            style:
                                CustomTextStyles.headlineLargePrimaryContainer,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: Text(
                              "lbl161".tr,
                              style:
                                  CustomTextStyles.bodySmallPrimaryContainer_2,
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
    );
  }
}
