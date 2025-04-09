import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_switch.dart';
import 'controller/two5_controller.dart'; // ignore_for_file: must_be_immutable

class Two5Screen extends GetWidget<Two5Controller> {
  const Two5Screen({Key? key})
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
                  children: [_buildStackunionone(), _buildColumnone()],
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
                text: "lbl180".tr,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnone() {
    return Container(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "lbl175".tr,
                        style: CustomTextStyles.titleMediumPrimaryContainer,
                      ),
                      Text(
                        "msg8".tr,
                        style: CustomTextStyles.bodySmallGray50001,
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
              "lbl181".tr,
              style: CustomTextStyles.bodyMediumPrimaryContainer,
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
                  "lbl_902".tr,
                  style: CustomTextStyles.titleMediumPrimaryContainer_1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 4.h,
                  top: 4.h,
                ),
                child: Text(
                  "lbl182".tr,
                  style: CustomTextStyles.bodySmallGray50001,
                ),
              )
            ],
          ),
          Container(
            width: double.maxFinite,
            decoration: AppDecoration.gray100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                  width: 232.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgGroup7198,
                        height: 20.h,
                        width: double.maxFinite,
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgPolygon5,
                        height: 5.h,
                        width: 12.h,
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(right: 64.h),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.symmetric(horizontal: 14.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "lbl_702".tr,
                        style: CustomTextStyles.bodySmallGray500,
                      ),
                      Text(
                        "lbl_80".tr,
                        style: CustomTextStyles.bodySmallGray500,
                      ),
                      Text(
                        "lbl_902".tr,
                        style: CustomTextStyles.bodySmallGray500,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16.h),
                        child: Text(
                          "lbl_1002".tr,
                          style: CustomTextStyles.bodySmallGray500,
                        ),
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
              "lbl_98_100".tr,
              style: CustomTextStyles.bodySmallGray50001,
            ),
          ),
          SizedBox(height: 16.h),
          CustomOutlinedButton(
            text: "lbl179".tr,
            buttonTextStyle: CustomTextStyles.titleMediumPrimary,
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
