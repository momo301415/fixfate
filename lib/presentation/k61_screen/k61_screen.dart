import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_switch.dart';
import 'controller/k61_controller.dart'; // ignore_for_file: must_be_immutable

class K61Screen extends GetWidget<K61Controller> {
  const K61Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.teal50,
      body: SafeArea(
        child: Container(
          height: 796.h,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 796.h,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    _buildStackunionone(),
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                        left: 16.h,
                        top: 72.h,
                        right: 16.h,
                      ),
                      padding: EdgeInsets.all(36.h),
                      decoration: AppDecoration.fillWhiteA.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder24,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    spacing: 4,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "lbl175".tr,
                                        style: CustomTextStyles
                                            .titleMediumPrimaryContainer,
                                      ),
                                      Text(
                                        "msg8".tr,
                                        style:
                                            CustomTextStyles.bodySmallGray50001,
                                      )
                                    ],
                                  ),
                                ),
                                Obx(
                                  () => CustomSwitch(
                                    value: controller.isSelectedSwitch.value,
                                    onChange: (value) {
                                      controller.isSelectedSwitch.value = value;
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "lbl184".tr,
                              style:
                                  CustomTextStyles.bodyMediumPrimaryContainer,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          _buildRow33five(
                            p33fiveOne: "lbl_38_3".tr,
                            cOne: "lbl_c".tr,
                          ),
                          Container(
                            width: double.maxFinite,
                            decoration: AppDecoration.gray100,
                            child: Column(
                              children: [
                                _buildStackpolygonfou(),
                                SizedBox(
                                  width: double.maxFinite,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "lbl_362".tr,
                                        style:
                                            CustomTextStyles.bodySmallGray500,
                                      ),
                                      Text(
                                        "lbl_372".tr,
                                        style:
                                            CustomTextStyles.bodySmallGray500,
                                      ),
                                      Text(
                                        "lbl_382".tr,
                                        style:
                                            CustomTextStyles.bodySmallGray500,
                                      ),
                                      Text(
                                        "lbl_392".tr,
                                        style:
                                            CustomTextStyles.bodySmallGray500,
                                      ),
                                      Text(
                                        "lbl_402".tr,
                                        style:
                                            CustomTextStyles.bodySmallGray500,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 14.h)
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          SizedBox(
                            width: double.maxFinite,
                            child: Divider(),
                          ),
                          SizedBox(height: 14.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "lbl185".tr,
                              style:
                                  CustomTextStyles.bodyMediumPrimaryContainer,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          _buildRow33five(
                            p33fiveOne: "lbl_33_5".tr,
                            cOne: "lbl_c".tr,
                          ),
                          Container(
                            width: double.maxFinite,
                            decoration: AppDecoration.gray100,
                            child: Column(
                              children: [
                                _buildStackpolygonfou1(),
                                SizedBox(
                                  width: double.maxFinite,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "lbl_312".tr,
                                        style:
                                            CustomTextStyles.bodySmallGray500,
                                      ),
                                      Text(
                                        "lbl_322".tr,
                                        style:
                                            CustomTextStyles.bodySmallGray500,
                                      ),
                                      Text(
                                        "lbl_332".tr,
                                        style:
                                            CustomTextStyles.bodySmallGray500,
                                      ),
                                      Text(
                                        "lbl_342".tr,
                                        style:
                                            CustomTextStyles.bodySmallGray500,
                                      ),
                                      Text(
                                        "lbl_352".tr,
                                        style:
                                            CustomTextStyles.bodySmallGray500,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16.h)
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          SizedBox(
                            width: double.maxFinite,
                            child: Divider(),
                          ),
                          SizedBox(height: 14.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "lbl_35_37_2_c".tr,
                              style: CustomTextStyles.bodySmallGray50001,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          CustomOutlinedButton(
                            text: "lbl179".tr,
                            buttonTextStyle:
                                CustomTextStyles.titleMediumPrimary,
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
    );
  }

  /// Section Widget
  Widget _buildStackunionone() {
    return Container(
      height: 90.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgUnion90x374,
            height: 90.h,
            width: double.maxFinite,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CustomAppBar(
              leadingWidth: 55.h,
              leading: AppbarLeadingImage(
                imagePath: ImageConstant.imgArrowLeft,
                margin: EdgeInsets.only(left: 31.h),
                onTap: () {
                  onTapArrowleftone();
                },
              ),
              centerTitle: true,
              title: AppbarSubtitle(
                text: "lbl183".tr,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildStackpolygonfou() {
    return SizedBox(
      height: 20.h,
      width: 328.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgFrame86844,
            height: 20.h,
            width: double.maxFinite,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgPolygon4,
            height: 5.h,
            width: 12.h,
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(right: 140.h),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildStackpolygonfou1() {
    return SizedBox(
      height: 20.h,
      width: 342.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgFrame86843,
            height: 20.h,
            width: double.maxFinite,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgPolygon4,
            height: 5.h,
            width: 12.h,
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(right: 140.h),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildRow33five({
    required String p33fiveOne,
    required String cOne,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            p33fiveOne,
            style: CustomTextStyles.titleMediumPrimaryContainer_1.copyWith(
              color: theme.colorScheme.primaryContainer,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 4.h,
            top: 4.h,
          ),
          child: Text(
            cOne,
            style: CustomTextStyles.bodySmallGray50001.copyWith(
              color: appTheme.gray50001,
            ),
          ),
        )
      ],
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
