import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';

import 'controller/k57_controller.dart'; // ignore_for_file: must_be_immutable

/// 個人中心-測量設定頁面
class K57Screen extends GetWidget<K57Controller> {
  const K57Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      title: "lbl63".tr,
      child: Container(
        child: _buildColumnone(),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnone() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 16.h,
        top: 16.h,
        right: 16.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 8.h,
      ),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 24.h),
          GestureDetector(
              onTap: () {
                controller.goK58Screen();
              },
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 24.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgFrame3,
                      height: 20.h,
                      width: 22.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.h),
                      child: Text(
                        "lbl171".tr,
                        style: CustomTextStyles.bodyMedium15,
                      ),
                    ),
                    Spacer(),
                    CustomImageView(
                      imagePath: ImageConstant.imgArrowRight,
                      height: 16.h,
                      width: 18.h,
                    )
                  ],
                ),
              )),
          SizedBox(height: 24.h),
          // GestureDetector(
          //     onTap: () {
          //       controller.goK58Screen();
          //     },
          //     child: Container(
          //       padding: EdgeInsets.fromLTRB(24.h, 24.h, 24.h, 22.h),
          //       decoration: AppDecoration.outlineGray,
          //       width: double.maxFinite,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           CustomImageView(
          //             imagePath: ImageConstant.imgFrame3,
          //             height: 20.h,
          //             width: 22.h,
          //           ),
          //           Padding(
          //             padding: EdgeInsets.only(left: 8.h),
          //             child: Text(
          //               "lbl171".tr,
          //               style: CustomTextStyles.bodyMedium15,
          //             ),
          //           ),
          //           Spacer(),
          //           CustomImageView(
          //             imagePath: ImageConstant.imgArrowRight,
          //             height: 16.h,
          //             width: 18.h,
          //           )
          //         ],
          //       ),
          //     )),
          // GestureDetector(
          //     onTap: () {
          //       controller.goTwo5Screen();
          //     },
          //     child: Container(
          //       padding: EdgeInsets.fromLTRB(24.h, 24.h, 24.h, 22.h),
          //       decoration: AppDecoration.outlineGray,
          //       width: double.maxFinite,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           CustomImageView(
          //             imagePath: ImageConstant.imgFrame4,
          //             height: 20.h,
          //             width: 22.h,
          //           ),
          //           Padding(
          //             padding: EdgeInsets.only(left: 8.h),
          //             child: Text(
          //               "lbl172_1".tr,
          //               style: CustomTextStyles.bodyMedium15,
          //             ),
          //           ),
          //           Spacer(),
          //           CustomImageView(
          //             imagePath: ImageConstant.imgArrowRight,
          //             height: 16.h,
          //             width: 18.h,
          //           )
          //         ],
          //       ),
          //     )),
          // GestureDetector(
          //     onTap: () {
          //       controller.goK61Screen();
          //     },
          //     child: Container(
          //       padding: EdgeInsets.fromLTRB(24.h, 24.h, 24.h, 22.h),
          //       decoration: AppDecoration.outlineGray,
          //       width: double.maxFinite,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           CustomImageView(
          //             imagePath: ImageConstant.imgFrameErrorcontainer,
          //             height: 20.h,
          //             width: 22.h,
          //           ),
          //           Padding(
          //             padding: EdgeInsets.only(left: 8.h),
          //             child: Text(
          //               "lbl173_1".tr,
          //               style: CustomTextStyles.bodyMedium15,
          //             ),
          //           ),
          //           Spacer(),
          //           CustomImageView(
          //             imagePath: ImageConstant.imgArrowRight,
          //             height: 16.h,
          //             width: 18.h,
          //           )
          //         ],
          //       ),
          //     )),
          // GestureDetector(
          //     onTap: () {
          //       controller.goTwo9Screen();
          //     },
          //     child: Container(
          //       padding: EdgeInsets.fromLTRB(24.h, 24.h, 24.h, 22.h),
          //       decoration: AppDecoration.outlineGray,
          //       width: double.maxFinite,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           CustomImageView(
          //             imagePath: ImageConstant.imgFrame3,
          //             height: 20.h,
          //             width: 22.h,
          //           ),
          //           Padding(
          //             padding: EdgeInsets.only(left: 8.h),
          //             child: Text(
          //               "lbl217".tr,
          //               style: CustomTextStyles.bodyMedium15,
          //             ),
          //           ),
          //           Spacer(),
          //           CustomImageView(
          //             imagePath: ImageConstant.imgArrowRight,
          //             height: 16.h,
          //             width: 18.h,
          //           )
          //         ],
          //       ),
          //     )),
          // SizedBox(height: 24.h),
          // GestureDetector(
          //     onTap: () {
          //       controller.goK61Screen();
          //     },
          //     child: Container(
          //       width: double.maxFinite,
          //       margin: EdgeInsets.symmetric(horizontal: 24.h),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           CustomImageView(
          //             imagePath: ImageConstant.imgFrame3,
          //             height: 20.h,
          //             width: 22.h,
          //           ),
          //           Padding(
          //             padding: EdgeInsets.only(left: 8.h),
          //             child: Text(
          //               "lbl173_1".tr,
          //               style: CustomTextStyles.bodyMedium15,
          //             ),
          //           ),
          //           Spacer(),
          //           CustomImageView(
          //             imagePath: ImageConstant.imgArrowRight,
          //             height: 16.h,
          //             width: 18.h,
          //           )
          //         ],
          //       ),
          //     )),
          // SizedBox(height: 24.h),

          // GestureDetector(
          //     onTap: () {
          //       controller.goTwo10Screen();
          //     },
          //     child: Container(
          //       width: double.maxFinite,
          //       margin: EdgeInsets.symmetric(horizontal: 24.h),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           CustomImageView(
          //             imagePath: ImageConstant.imgFrame3,
          //             height: 20.h,
          //             width: 22.h,
          //           ),
          //           Padding(
          //             padding: EdgeInsets.only(left: 8.h),
          //             child: Text(
          //               "lbl_listen".tr,
          //               style: CustomTextStyles.bodyMedium15,
          //             ),
          //           ),
          //           Spacer(),
          //           CustomImageView(
          //             imagePath: ImageConstant.imgArrowRight,
          //             height: 16.h,
          //             width: 18.h,
          //           )
          //         ],
          //       ),
          //     )),
          // SizedBox(height: 24.h)
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
