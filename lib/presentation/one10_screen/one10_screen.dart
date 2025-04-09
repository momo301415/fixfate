import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import 'controller/one10_controller.dart';
import 'models/list_one_item_model.dart';
import 'widgets/list_one_item_widget.dart'; // ignore_for_file: must_be_immutable

class One10Screen extends GetWidget<One10Controller> {
  const One10Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.teal50,
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                spacing: 108,
                children: [
                  SizedBox(
                    height: 536.h,
                    width: double.maxFinite,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [_buildStackunionone(), _buildListone()],
                    ),
                  ),
                  CustomElevatedButton(
                    text: "lbl202".tr,
                    margin: EdgeInsets.symmetric(horizontal: 24.h),
                    buttonStyle: CustomButtonStyles.none,
                    decoration:
                        CustomButtonStyles.gradientCyanToPrimaryDecoration,
                  ),
                  SizedBox(height: 44.h)
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildColumn(),
    );
  }

  /// Section Widget
  Widget _buildStackunionone() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
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
                  text: "lbl66".tr,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildListone() {
    return Padding(
      padding: EdgeInsets.only(
        left: 14.h,
        right: 6.h,
      ),
      child: Obx(
        () => ListView.separated(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 16.h,
            );
          },
          itemCount:
              controller.one10ModelObj.value.listOneItemList.value.length,
          itemBuilder: (context, index) {
            ListOneItemModel model =
                controller.one10ModelObj.value.listOneItemList.value[index];
            return ListOneItemWidget(
              model,
            );
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumn() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomOutlinedButton(
            text: "lbl203".tr,
            margin: EdgeInsets.only(bottom: 12.h),
            buttonStyle: CustomButtonStyles.outlinePrimary,
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
