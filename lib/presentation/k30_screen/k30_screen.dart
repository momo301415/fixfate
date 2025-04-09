import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k30_controller.dart';
import 'models/chipview_four_item_model.dart';
import 'models/chipview_item_model.dart';
import 'models/chipview_one_item_model.dart';
import 'models/chipview_three_item_model.dart';
import 'models/chipview_two_item_model.dart';
import 'models/list_item_model.dart';
import 'widgets/chipview_four_item_widget.dart';
import 'widgets/chipview_item_widget.dart';
import 'widgets/chipview_one_item_widget.dart';
import 'widgets/chipview_three_item_widget.dart';
import 'widgets/chipview_two_item_widget.dart';
import 'widgets/list_item_widget.dart'; // ignore_for_file: must_be_immutable

class K30Screen extends GetWidget<K30Controller> {
  const K30Screen({Key? key})
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
            child: Container(
              height: 1974.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildStackunionone(),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Column(
                      spacing: 16,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildColumnone(),
                        _buildColumnone1(),
                        _buildColumnone2(),
                        _buildColumnone3(),
                        _buildColumnone4(),
                        _buildColumnone5(),
                        _buildRowfidownload()
                      ],
                    ),
                  )
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
                  text: "lbl61".tr,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnone() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "lbl71".tr,
              style: CustomTextStyles.titleMediumBluegray900,
            ),
          ),
          SizedBox(height: 4.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "lbl72".tr,
              style: CustomTextStyles.bodySmallGray50001,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.fromLTRB(8.h, 8.h, 8.h, 6.h),
            decoration: AppDecoration.outlineGray,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "lbl73".tr,
                  style: CustomTextStyles.bodyMediumBluegray900,
                ),
                Spacer(),
                CustomImageView(
                  imagePath: ImageConstant.imgEllipse82,
                  height: 40.h,
                  width: 42.h,
                  radius: BorderRadius.circular(
                    20.h,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgVectorGray50001,
                  height: 8.h,
                  width: 6.h,
                  margin: EdgeInsets.only(left: 16.h),
                )
              ],
            ),
          ),
          Obx(
            () => ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.k30ModelObj.value.listItemList.value.length,
              itemBuilder: (context, index) {
                ListItemModel model =
                    controller.k30ModelObj.value.listItemList.value[index];
                return ListItemWidget(
                  model,
                );
              },
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "lbl81".tr,
                  style: CustomTextStyles.bodyMediumBluegray900,
                ),
                Spacer(),
                Text(
                  "lbl_100_cm".tr,
                  style: CustomTextStyles.bodyMediumBluegray900,
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgVectorGray50001,
                  height: 8.h,
                  width: 6.h,
                  margin: EdgeInsets.only(left: 16.h),
                )
              ],
            ),
          ),
          SizedBox(height: 16.h)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnone1() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl82".tr,
            style: CustomTextStyles.titleMediumErrorContainer,
          ),
          SizedBox(height: 4.h),
          Text(
            "lbl83".tr,
            style: CustomTextStyles.bodySmallGray50001,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: Obx(
              () => Wrap(
                runSpacing: 6.h,
                spacing: 6.h,
                children: List<Widget>.generate(
                  controller.k30ModelObj.value.chipviewItemList.value.length,
                  (index) {
                    ChipviewItemModel model = controller
                        .k30ModelObj.value.chipviewItemList.value[index];
                    return ChipviewItemWidget(
                      model,
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnone2() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl94".tr,
            style: CustomTextStyles.titleMediumErrorContainer,
          ),
          SizedBox(height: 4.h),
          Text(
            "lbl95".tr,
            style: CustomTextStyles.bodySmallGray50001,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: Obx(
              () => Wrap(
                runSpacing: 6.h,
                spacing: 6.h,
                children: List<Widget>.generate(
                  controller.k30ModelObj.value.chipviewOneItemList.value.length,
                  (index) {
                    ChipviewOneItemModel model = controller
                        .k30ModelObj.value.chipviewOneItemList.value[index];
                    return ChipviewOneItemWidget(
                      model,
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnone3() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl102".tr,
            style: CustomTextStyles.titleMediumErrorContainer,
          ),
          SizedBox(height: 4.h),
          Text(
            "msg5".tr,
            style: CustomTextStyles.bodySmallGray50001,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: Obx(
              () => Wrap(
                runSpacing: 4.h,
                spacing: 4.h,
                children: List<Widget>.generate(
                  controller.k30ModelObj.value.chipviewTwoItemList.value.length,
                  (index) {
                    ChipviewTwoItemModel model = controller
                        .k30ModelObj.value.chipviewTwoItemList.value[index];
                    return ChipviewTwoItemWidget(
                      model,
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnone4() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl112".tr,
            style: CustomTextStyles.titleMediumErrorContainer,
          ),
          SizedBox(height: 4.h),
          Text(
            "msg6".tr,
            style: CustomTextStyles.bodySmallGray50001,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: Obx(
              () => Wrap(
                runSpacing: 4.h,
                spacing: 4.h,
                children: List<Widget>.generate(
                  controller
                      .k30ModelObj.value.chipviewThreeItemList.value.length,
                  (index) {
                    ChipviewThreeItemModel model = controller
                        .k30ModelObj.value.chipviewThreeItemList.value[index];
                    return ChipviewThreeItemWidget(
                      model,
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnone5() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl113".tr,
            style: CustomTextStyles.titleMediumErrorContainer,
          ),
          SizedBox(height: 4.h),
          Text(
            "lbl114".tr,
            style: CustomTextStyles.bodySmallGray50001,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: Obx(
              () => Wrap(
                runSpacing: 6.h,
                spacing: 6.h,
                children: List<Widget>.generate(
                  controller
                      .k30ModelObj.value.chipviewFourItemList.value.length,
                  (index) {
                    ChipviewFourItemModel model = controller
                        .k30ModelObj.value.chipviewFourItemList.value[index];
                    return ChipviewFourItemWidget(
                      model,
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowfidownload() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 14.h,
      ),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      width: double.maxFinite,
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgFiDownload,
            height: 36.h,
            width: 36.h,
          ),
          Expanded(
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl123".tr,
                  style: CustomTextStyles.titleMedium16,
                ),
                Text(
                  "msg_fixfate".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.bodySmallGray300.copyWith(
                    height: 1.40,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumn() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomElevatedButton(
            text: "lbl124".tr,
            margin: EdgeInsets.only(bottom: 12.h),
            buttonStyle: CustomButtonStyles.none,
            decoration: CustomButtonStyles.gradientCyanToPrimaryTL8Decoration,
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
