import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/k84_controller.dart';
import 'models/initial_tab5_model.dart';

// ignore_for_file: must_be_immutable
class InitialTab5Page extends StatelessWidget {
  InitialTab5Page({Key? key})
      : super(
          key: key,
        );

  K84Controller controller = Get.put(K84Controller());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: 342.h,
                margin: EdgeInsets.only(top: 12.h),
                child: Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(horizontal: 6.h),
                            child: Row(
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant
                                      .imgArrowDownPrimarycontainer,
                                  height: 18.h,
                                  width: 18.h,
                                ),
                                Spacer(
                                  flex: 46,
                                ),
                                Text(
                                  "lbl_8_222".tr,
                                  style: CustomTextStyles
                                      .bodyMediumPrimaryContainer15_1,
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.imgForward,
                                  height: 6.h,
                                  width: 12.h,
                                  radius: BorderRadius.circular(
                                    1.h,
                                  ),
                                  margin: EdgeInsets.only(left: 10.h),
                                ),
                                Spacer(
                                  flex: 53,
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant
                                      .imgArrowRightPrimarycontainer,
                                  height: 18.h,
                                  width: 18.h,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          CustomImageView(
                            imagePath: ImageConstant.imgFrame86884,
                            height: 74.h,
                            width: double.maxFinite,
                          ),
                          SizedBox(height: 4.h),
                          SizedBox(
                            width: double.maxFinite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "lbl_23_32".tr,
                                  style: CustomTextStyles.bodySmallGray50010,
                                ),
                                Text(
                                  "lbl_06_13".tr,
                                  style: CustomTextStyles.bodySmallGray50010,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          SizedBox(
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                VerticalDivider(
                                  width: 4.h,
                                  thickness: 4.h,
                                  color: appTheme.cyan90002,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.h),
                                  child: Text(
                                    "lbl_2_3h".tr,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                                Spacer(),
                                VerticalDivider(
                                  width: 4.h,
                                  thickness: 4.h,
                                  color: theme.colorScheme.primary,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 4.h,
                                    right: 74.h,
                                  ),
                                  child: Text(
                                    "lbl_3_2h".tr,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          SizedBox(
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                VerticalDivider(
                                  width: 4.h,
                                  thickness: 4.h,
                                  color: appTheme.cyan30001,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.h),
                                  child: Text(
                                    "lbl_4_3h".tr,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                                Spacer(),
                                VerticalDivider(
                                  width: 4.h,
                                  thickness: 4.h,
                                  color: appTheme.cyanA100,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 4.h,
                                    right: 78.h,
                                  ),
                                  child: Text(
                                    "lbl_1_5h".tr,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "msg_6_54_2_12".tr,
                            style: CustomTextStyles.bodySmallGray500,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 42.h,
                        vertical: 8.h,
                      ),
                      decoration: AppDecoration.fillWhiteA.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 6.h),
                            child: _buildStacktwentyfour(
                              twentyfour: "lbl_52".tr,
                              two: "lbl161".tr,
                              one: "lbl246".tr,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: VerticalDivider(
                              width: 1.h,
                              thickness: 1.h,
                              color: appTheme.blueGray10001,
                            ),
                          ),
                          SizedBox(
                            height: 44.h,
                            width: 28.h,
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
                                            Text(
                                              "lbl_32".tr,
                                              style: theme.textTheme.titleLarge,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 6.h),
                                                child: Text(
                                                  "lbl161".tr,
                                                  style: CustomTextStyles
                                                      .bodySmall10,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  "lbl247".tr,
                                  style: theme.textTheme.bodySmall,
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: VerticalDivider(
                              width: 1.h,
                              thickness: 1.h,
                              color: appTheme.blueGray10001,
                            ),
                          ),
                          _buildStacktwentyfour(
                            twentyfour: "lbl_32".tr,
                            two: "lbl161".tr,
                            one: "lbl248".tr,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.all(16.h),
                      decoration: AppDecoration.fillWhiteA.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  controller: controller.oneController,
                                  hintText: "lbl239".tr,
                                  hintStyle:
                                      CustomTextStyles.titleSmallErrorContainer,
                                  textInputAction: TextInputAction.done,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      18.h, 12.h, 18.h, 8.h),
                                  borderDecoration:
                                      TextFormFieldStyleHelper.underLine,
                                  filled: false,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.fromLTRB(6.h, 12.h, 6.h, 10.h),
                                  decoration: AppDecoration.outlineGray,
                                  width: double.maxFinite,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 6.h),
                                        child: Text(
                                          "lbl_8_23".tr,
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "msg_2025_03_29_11_23".tr,
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.fromLTRB(6.h, 12.h, 6.h, 10.h),
                                  decoration: AppDecoration.outlineGray,
                                  width: double.maxFinite,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 6.h),
                                        child: Text(
                                          "lbl_8_23".tr,
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "msg_2025_03_29_11_23".tr,
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.fromLTRB(6.h, 12.h, 6.h, 10.h),
                                  decoration: AppDecoration.outlineGray,
                                  width: double.maxFinite,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 6.h),
                                        child: Text(
                                          "lbl_8_23".tr,
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "msg_2025_03_29_11_23".tr,
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.fromLTRB(6.h, 12.h, 6.h, 10.h),
                                  decoration: AppDecoration.outlineGray,
                                  width: double.maxFinite,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 6.h),
                                        child: Text(
                                          "lbl_8_23".tr,
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "msg_2025_03_29_11_23".tr,
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(8.h, 12.h, 8.h, 10.h),
                            decoration: AppDecoration.outlineGray,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "lbl_8_23".tr,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyMedium,
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    "msg_2023_03_23_14_32".tr,
                                    textAlign: TextAlign.right,
                                    style: theme.textTheme.bodySmall,
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
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildStacktwentyfour({
    required String twentyfour,
    required String two,
    required String one,
  }) {
    return SizedBox(
      height: 44.h,
      width: 28.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              twentyfour,
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Text(
                two,
                style: CustomTextStyles.bodySmall10.copyWith(
                  color: theme.colorScheme.errorContainer,
                ),
              ),
            ),
          ),
          Text(
            one,
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.errorContainer,
            ),
          )
        ],
      ),
    );
  }
}
