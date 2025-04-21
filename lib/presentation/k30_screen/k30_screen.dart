import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/presentation/k31_bottomsheet/controller/k31_controller.dart';
import 'package:pulsedevice/presentation/k31_bottomsheet/k31_bottomsheet.dart';
import 'package:pulsedevice/presentation/k32_dialog/controller/k32_controller.dart';
import 'package:pulsedevice/presentation/k32_dialog/k32_dialog.dart';
import 'package:pulsedevice/presentation/k34_dialog/controller/k34_controller.dart';
import 'package:pulsedevice/presentation/k34_dialog/k34_dialog.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
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
import 'widgets/list_item_widget.dart';
// ignore_for_file: must_be_immutable

/// 個人中心-個人資料
class K30Screen extends GetWidget<K30Controller> {
  const K30Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      title: "lbl61".tr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildColumnone(),
          SizedBox(height: 16),
          _buildColumnone1(),
          SizedBox(height: 16),
          _buildColumnone2(),
          SizedBox(height: 16),
          _buildColumnone3(),
          SizedBox(height: 16),
          _buildColumnone4(),
          SizedBox(height: 16),
          _buildColumnone5(),
          SizedBox(height: 16),
          _buildRowfidownload(),
          SizedBox(height: 16),
          _buildColumn(),
        ],
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
          GestureDetector(
              onTap: () {
                controller.selectAvatar();
              },
              child: Container(
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
                    Obx(() {
                      final path = controller.avatarPath.value;
                      if (path.isNotEmpty) {
                        return CircleAvatar(
                          radius: 20.h,
                          backgroundImage: FileImage(File(path)),
                        );
                      } else {
                        return CustomImageView(
                          imagePath: ImageConstant.imgEllipse82,
                          height: 40.h,
                          width: 42.h,
                          radius: BorderRadius.circular(
                            20.h,
                          ),
                        );
                      }
                    }),
                    CustomImageView(
                      imagePath: ImageConstant.imgVectorGray50001,
                      height: 8.h,
                      width: 6.h,
                      margin: EdgeInsets.only(left: 16.h),
                    )
                  ],
                ),
              )),
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.k30ModelObj.value.listItemList.value.length,
            itemBuilder: (context, index) {
              ListItemModel model =
                  controller.k30ModelObj.value.listItemList.value[index];
              return ListItemWidget(
                model,
                onTap: () async {
                  switch (index) {
                    case 0:
                      await controller.showInputNickName();
                      if (controller.nickName.value.isNotEmpty) {
                        model.tf1?.value = controller.nickName.value;
                      }
                      break;
                    case 1:
                      await controller.showInputEmail();
                      if (controller.email.value.isNotEmpty) {
                        model.tf1?.value = controller.email.value;
                      }

                      break;
                    case 2:
                      await controller.selectGender();
                      if (controller.gender.value.isNotEmpty) {
                        model.tf1?.value = controller.gender.value;
                      }
                      break;
                    case 3:
                      await controller.selectBirth();
                      if (controller.birth.value.isNotEmpty) {
                        model.tf1?.value = controller.birth.value;
                      }
                      break;
                  }
                },
              );
            },
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
