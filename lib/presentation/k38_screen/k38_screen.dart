import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/k38_controller.dart';
import 'models/chipview_item_model.dart';
import 'models/chipview_one_item_model.dart';
import 'models/chipview_two_item_model.dart';
import 'widgets/chipview_item_widget.dart';
import 'widgets/chipview_one_item_widget.dart';
import 'widgets/chipview_two_item_widget.dart'; // ignore_for_file: must_be_immutable

class K38Screen extends GetWidget<K38Controller> {
  const K38Screen({Key? key})
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
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      spacing: 16,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgFrame86769,
                          height: 14.h,
                          width: double.maxFinite,
                        ),
                        _buildColumnone(),
                        _buildColumnone1(),
                        _buildColumnone2()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildColumntwo(),
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
                  controller.k38ModelObj.value.chipviewItemList.value.length,
                  (index) {
                    ChipviewItemModel model = controller
                        .k38ModelObj.value.chipviewItemList.value[index];
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
                  controller.k38ModelObj.value.chipviewOneItemList.value.length,
                  (index) {
                    ChipviewOneItemModel model = controller
                        .k38ModelObj.value.chipviewOneItemList.value[index];
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
                  controller.k38ModelObj.value.chipviewTwoItemList.value.length,
                  (index) {
                    ChipviewTwoItemModel model = controller
                        .k38ModelObj.value.chipviewTwoItemList.value[index];
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
  Widget _buildColumntwo() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: AppDecoration.fillWhiteA.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "lbl113".tr,
                  style: CustomTextStyles.titleMediumErrorContainer,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    "lbl114".tr,
                    style: CustomTextStyles.bodySmallGray50001,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.h,
                          vertical: 2.h,
                        ),
                        decoration: AppDecoration.ff.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder16,
                        ),
                        child: Text(
                          "lbl84".tr,
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.bodyLargeGray200,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.h,
                          vertical: 2.h,
                        ),
                        decoration: AppDecoration.outlineBlueGray.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder16,
                        ),
                        child: Text(
                          "lbl115".tr,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.h,
                          vertical: 2.h,
                        ),
                        decoration: AppDecoration.outlineBlueGray.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder16,
                        ),
                        child: Text(
                          "lbl116".tr,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.h,
                          vertical: 2.h,
                        ),
                        decoration: AppDecoration.outlineBlueGray.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder16,
                        ),
                        child: Text(
                          "lbl117".tr,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge,
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
    );
  }
}
