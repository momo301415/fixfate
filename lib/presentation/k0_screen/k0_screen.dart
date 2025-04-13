import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k0_controller.dart'; // ignore_for_file: must_be_immutable

class K0Screen extends GetWidget<K0Controller> {
  const K0Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.whiteA700,
      appBar: _buildAppbar(),
      body: SafeArea(
        top: false,
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            controller: controller.scrollController,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 18.h,
                top: 12.h,
                right: 18.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "lbl".tr,
                    style: CustomTextStyles.titleLargePrimaryContainer22,
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "lbl2".tr,
                    style: CustomTextStyles.bodyMediumPrimaryContainer,
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(left: 6.h),
                    child: Text(
                      "msg_app".tr,
                      maxLines: 7,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.bodyMediumBluegray400.copyWith(
                        height: 1.70,
                      ),
                    ),
                  ),
                  SizedBox(height: 22.h),
                  _buildColumn(),
                  SizedBox(height: 22.h),
                  _buildColumn1(),
                  SizedBox(height: 22.h),
                  Text(
                    "lbl4".tr,
                    style: CustomTextStyles.bodyMediumPrimaryContainer,
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(left: 6.h),
                    child: Text(
                      "msg".tr,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.bodyMediumBluegray400.copyWith(
                        height: 1.70,
                      ),
                    ),
                  ),
                  SizedBox(height: 22.h),
                  Text(
                    "lbl5".tr,
                    style: CustomTextStyles.bodyMediumPrimaryContainer,
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(left: 6.h),
                    child: Text(
                      "msg_app3".tr,
                      maxLines: 7,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.bodyMediumBluegray400.copyWith(
                        height: 1.70,
                      ),
                    ),
                  ),
                  SizedBox(height: 22.h),
                  Text(
                    "lbl6".tr,
                    style: CustomTextStyles.bodyMediumPrimaryContainer,
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(left: 6.h),
                    child: Text(
                      "msg_app4".tr,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.bodyMediumBluegray400.copyWith(
                        height: 1.70,
                      ),
                    ),
                  ),
                  SizedBox(height: 22.h),
                  Text(
                    "lbl7".tr,
                    style: CustomTextStyles.bodyMediumPrimaryContainer,
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(left: 6.h),
                    child: Text(
                      "msg2".tr,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.bodyMediumBluegray400.copyWith(
                        height: 1.70,
                      ),
                    ),
                  ),
                  SizedBox(height: 22.h),
                  Text(
                    "lbl8".tr,
                    style: CustomTextStyles.bodyMediumPrimaryContainer,
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(left: 6.h),
                    child: Text(
                      "msg3".tr,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.bodyMediumBluegray400.copyWith(
                        height: 1.70,
                      ),
                    ),
                  ),
                  SizedBox(height: 34.h)
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: _buildColumn2(),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppbar() {
    return CustomAppBar(
      height: 56.h,
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgClose,
        margin: EdgeInsets.only(left: 24.h),
        onTap: () {
          onTapCloseone();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildColumn() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 10.h),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl3".tr,
            style: CustomTextStyles.bodyMediumPrimaryContainer,
          ),
          Padding(
            padding: EdgeInsets.only(left: 6.h),
            child: Text(
              "msg_app2".tr,
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.bodyMediumBluegray400.copyWith(
                height: 1.70,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumn1() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 8.h),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl4".tr,
            style: CustomTextStyles.bodyMediumPrimaryContainer,
          ),
          Padding(
            padding: EdgeInsets.only(left: 6.h),
            child: Text(
              "msg".tr,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.bodyMediumBluegray400.copyWith(
                height: 1.70,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumn2() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => CustomElevatedButton(
                text: "lbl9".tr,
                margin: EdgeInsets.only(bottom: 12.h),
                buttonStyle: controller.isBottomReached.value
                    ? CustomButtonStyles.none
                    : CustomButtonStyles.fillTeal,
                decoration: controller.isBottomReached.value
                    ? CustomButtonStyles.gradientCyanToPrimaryDecoration
                    : null,
                onPressed: controller.isBottomReached.value
                    ? () => Get.back(result: true)
                    : null,
              ))
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapCloseone() {
    Get.back();
  }
}
