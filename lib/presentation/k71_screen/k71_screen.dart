import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_outlined_button.dart';
import 'controller/k71_controller.dart'; // ignore_for_file: must_be_immutable

class K71Screen extends GetWidget<K71Controller> {
  const K71Screen({Key? key})
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
                  children: [_buildStackunionone(), _buildColumnqrcode()],
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
              leadingWidth: 56.h,
              leading: AppbarLeadingImage(
                imagePath: ImageConstant.imgArrowLeft,
                margin: EdgeInsets.only(left: 32.h),
                onTap: () {
                  onTapArrowleftone();
                },
              ),
              centerTitle: true,
              title: AppbarSubtitle(
                text: "lbl213".tr,
              ),
              actions: [
                AppbarTrailingImage(
                  imagePath: ImageConstant.imgTelevision,
                  margin: EdgeInsets.only(right: 31.h),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnqrcode() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 16.h,
        top: 72.h,
        right: 16.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 36.h,
      ),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        spacing: 28,
        mainAxisSize: MainAxisSize.min,
        children: [
          QrImageView(
            data: 'https://www.google.com',
            size: 146.h,
          ),
          Text(
            "msg_qrcode".tr,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: CustomTextStyles.bodyMedium_1,
          ),
          CustomOutlinedButton(
            text: "lbl214".tr,
            leftIcon: Container(
              margin: EdgeInsets.only(right: 4.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgArrowup,
                height: 20.h,
                width: 20.h,
                fit: BoxFit.contain,
              ),
            ),
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
