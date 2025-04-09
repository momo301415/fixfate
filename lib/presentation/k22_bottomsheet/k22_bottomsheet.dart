import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k22_controller.dart';

// ignore_for_file: must_be_immutable
class K22Bottomsheet extends StatelessWidget {
  K22Bottomsheet(this.controller, {Key? key})
      : super(
          key: key,
        );

  K22Controller controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 6.h,
        vertical: 2.h,
      ),
      decoration: AppDecoration.fillWhiteA,
      child: Column(
        spacing: 18,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(left: 8.h),
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(
                    left: 48.h,
                    right: 54.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "lbl_1991".tr,
                        style: CustomTextStyles.bodyMediumGray700,
                      ),
                      Text(
                        "lbl_22".tr,
                        style: CustomTextStyles.bodyMediumGray700,
                      ),
                      Text(
                        "lbl_282".tr,
                        style: CustomTextStyles.bodyMediumGray700,
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(
                    left: 44.h,
                    right: 50.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "lbl_1992".tr,
                        style: CustomTextStyles.bodyLargeGray700_1,
                      ),
                      Text(
                        "lbl_32".tr,
                        style: CustomTextStyles.bodyLargeGray700_1,
                      ),
                      Text(
                        "lbl_292".tr,
                        style: CustomTextStyles.bodyLargeGray700_1,
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(
                    left: 40.h,
                    right: 48.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "lbl_1993".tr,
                        style: CustomTextStyles.bodyLargeGray700,
                      ),
                      Text(
                        "lbl_42".tr,
                        style: CustomTextStyles.bodyLargeGray700,
                      ),
                      Text(
                        "lbl_302".tr,
                        style: CustomTextStyles.bodyLargeGray700,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  margin: EdgeInsets.only(right: 8.h),
                  padding: EdgeInsets.symmetric(horizontal: 38.h),
                  decoration: AppDecoration.gray100.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder8,
                  ),
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "lbl_1994".tr,
                        style: CustomTextStyles.titleLargePrimaryContainer,
                      ),
                      Text(
                        "lbl_52".tr,
                        style: CustomTextStyles.titleLargePrimaryContainer,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 2.h),
                        child: Text(
                          "lbl_312".tr,
                          style: CustomTextStyles.titleLargePrimaryContainer,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.symmetric(horizontal: 40.h),
                  child: Row(
                    children: [
                      Text(
                        "lbl_1995".tr,
                        style: CustomTextStyles.bodyLargeGray700,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 90.h),
                        child: Text(
                          "lbl_62".tr,
                          style: CustomTextStyles.bodyLargeGray700,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.symmetric(horizontal: 44.h),
                  child: Row(
                    children: [
                      Text(
                        "lbl_1996".tr,
                        style: CustomTextStyles.bodyLargeGray700_1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 90.h),
                        child: Text(
                          "lbl_72".tr,
                          style: CustomTextStyles.bodyLargeGray700_1,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.symmetric(horizontal: 48.h),
                  child: Row(
                    children: [
                      Text(
                        "lbl_1997".tr,
                        style: CustomTextStyles.bodyMediumGray700,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 92.h),
                        child: Text(
                          "lbl_83".tr,
                          style: CustomTextStyles.bodyMediumGray700,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          CustomElevatedButton(
            text: "lbl51".tr,
            margin: EdgeInsets.symmetric(horizontal: 16.h),
            buttonStyle: CustomButtonStyles.fillPrimary,
          ),
          Text(
            "lbl50".tr,
            style: CustomTextStyles.bodyLargeGray500_1,
          ),
          SizedBox(height: 38.h)
        ],
      ),
    );
  }
}
