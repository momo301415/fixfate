import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_switch.dart';
import 'controller/one8_controller.dart'; // ignore_for_file: must_be_immutable

class One8Screen extends GetWidget<One8Controller> {
  const One8Screen({Key? key})
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
                              "lbl176".tr,
                              style:
                                  CustomTextStyles.bodyMediumPrimaryContainer,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "lbl_1002".tr,
                                  style: CustomTextStyles
                                      .titleMediumPrimaryContainer_1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 4.h,
                                  top: 4.h,
                                ),
                                child: Text(
                                  "lbl177".tr,
                                  style: CustomTextStyles.bodySmallGray50001,
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: double.maxFinite,
                            decoration: AppDecoration.gray100,
                            child: Column(
                              children: [
                                _buildStackpolygonfou(),
                                _buildRowforty(
                                  fortyOne: "lbl_80".tr,
                                  fiftyOne: "lbl_902".tr,
                                  sixtyOne: "lbl_1002".tr,
                                  seventyOne: "lbl_1102".tr,
                                  eightyOne: "lbl_1202".tr,
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
                              "lbl178".tr,
                              style:
                                  CustomTextStyles.bodyMediumPrimaryContainer,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "lbl_60".tr,
                                  style: CustomTextStyles
                                      .titleMediumPrimaryContainer_1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 4.h,
                                  top: 4.h,
                                ),
                                child: Text(
                                  "lbl177".tr,
                                  style: CustomTextStyles.bodySmallGray50001,
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: double.maxFinite,
                            decoration: AppDecoration.gray100,
                            child: Column(
                              children: [
                                _buildStackpolygonfou1(),
                                _buildRowforty(
                                  fortyOne: "lbl_402".tr,
                                  fiftyOne: "lbl_502".tr,
                                  sixtyOne: "lbl_60".tr,
                                  seventyOne: "lbl_702".tr,
                                  eightyOne: "lbl_80".tr,
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
                              "msg_60_100".tr,
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
                text: "lbl174".tr,
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
      width: 314.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgGroup7196,
            height: 20.h,
            width: double.maxFinite,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgPolygon4,
            height: 5.h,
            width: 12.h,
            alignment: Alignment.topCenter,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildStackpolygonfou1() {
    return SizedBox(
      height: 20.h,
      width: 314.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgGroup7196,
            height: 20.h,
            width: double.maxFinite,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgPolygon4,
            height: 5.h,
            width: 12.h,
            alignment: Alignment.topCenter,
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildRowforty({
    required String fortyOne,
    required String fiftyOne,
    required String sixtyOne,
    required String seventyOne,
    required String eightyOne,
  }) {
    return SizedBox(
      width: 310.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 14.h),
            child: Text(
              fortyOne,
              style: CustomTextStyles.bodySmallGray500.copyWith(
                color: appTheme.gray500,
              ),
            ),
          ),
          Text(
            fiftyOne,
            style: CustomTextStyles.bodySmallGray500.copyWith(
              color: appTheme.gray500,
            ),
          ),
          Text(
            sixtyOne,
            style: CustomTextStyles.bodySmallGray500.copyWith(
              color: appTheme.gray500,
            ),
          ),
          Text(
            seventyOne,
            style: CustomTextStyles.bodySmallGray500.copyWith(
              color: appTheme.gray500,
            ),
          ),
          Text(
            eightyOne,
            style: CustomTextStyles.bodySmallGray500.copyWith(
              color: appTheme.gray500,
            ),
          )
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
