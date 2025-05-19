import 'dart:io';

import 'package:flutter/material.dart';

import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
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
          _buildColumnone6(),
          SizedBox(height: 16),
          _buildRowfidownload(),
          SizedBox(height: 16),
          _buildColumn(),
          SizedBox(height: 36.h),
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
                    case 4:
                      await controller.showInputWeight();
                      if (controller.weight.value > 0) {
                        model.tf1?.value = "${controller.weight.value} kg";
                      }
                    case 5:
                      await controller.showInputHeight();
                      if (controller.height.value > 0) {
                        model.tf1?.value = "${controller.height.value} cm";
                      }
                      break;
                  }
                },
              );
            },
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () {
              controller.showInputWaistline();
            },
            child: Container(
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
                  Obx(() {
                    final waistline = controller.waistline.value;
                    if (waistline > 0) {
                      return Text(
                        "$waistline cm",
                        style: CustomTextStyles.bodyMediumBluegray900,
                      );
                    } else {
                      return Text(
                        "lbl_100_cm".tr,
                        style: CustomTextStyles.bodyMediumBluegray900,
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
            ),
          ),
          SizedBox(height: 16.h)
        ],
      ),
    );
  }

  Widget _buildColumnone1() {
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
              "lbl82".tr,
              style: CustomTextStyles.titleMediumBluegray900,
            ),
          ),
          SizedBox(height: 4.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "lbl82_2".tr,
              style: CustomTextStyles.bodySmallGray50001,
            ),
          ),
          SizedBox(height: 16.h),
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.k30ModelObj.value.listItemList2.value.length,
            itemBuilder: (context, index) {
              ListItemModel model =
                  controller.k30ModelObj.value.listItemList2.value[index];
              return ListItemWidget(
                model,
                onTap: () async {
                  switch (index) {
                    case 0:
                      await controller.selectDrink();
                      if (controller.drikValue.value.isNotEmpty) {
                        model.tf1?.value = controller.drikValue.value;
                      }
                      break;
                    case 1:
                      await controller.selectSmoke();
                      if (controller.smokeValue.value.isNotEmpty) {
                        model.tf1?.value = controller.smokeValue.value;
                      }

                      break;
                    case 2:
                      await controller.selectSport();
                      if (controller.sportValue.value.isNotEmpty) {
                        model.tf1?.value = controller.sportValue.value;
                      }
                      break;
                    case 3:
                      await controller.selectLongSit();
                      if (controller.longSitValue.value.isNotEmpty) {
                        model.tf1?.value = controller.longSitValue.value;
                      }
                      break;
                    case 4:
                      await controller.selectLongStand();
                      if (controller.longStandValue.value.isNotEmpty) {
                        model.tf1?.value = controller.longStandValue.value;
                      }
                      break;
                    case 5:
                      await controller.selectLowHead();
                      if (controller.lowHeadValue.value.isNotEmpty) {
                        model.tf1?.value = controller.lowHeadValue.value;
                      }
                      break;
                    case 6:
                      await controller.selectWater();
                      if (controller.waterValue.value.isNotEmpty) {
                        model.tf1?.value = controller.waterValue.value + "ml";
                      }
                      break;
                    case 7:
                      await controller.selectNoneSleep();
                      if (controller.noneSleepValue.value.isNotEmpty) {
                        model.tf1?.value = controller.noneSleepValue.value;
                      }
                      break;
                  }
                },
              );
            },
          ),
          SizedBox(height: 16.h),
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
            "lbl308".tr,
            style: CustomTextStyles.titleMediumErrorContainer,
          ),
          SizedBox(height: 4.h),
          Text(
            "lbl308_1".tr,
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
                  controller.k30ModelObj.value.chipviewItemList.length,
                  (index) {
                    ChipviewItemModel model =
                        controller.k30ModelObj.value.chipviewItemList[index];
                    return ChipviewItemWidget(
                      model,
                      onTap: () {
                        var list =
                            controller.k30ModelObj.value.chipviewItemList;
                        var lastIndex = list.length - 1; // lastIndex
                        if (index == lastIndex) {
                          controller.handleChipTap<ChipviewItemModel>(
                            index: index,
                            model: model,
                            list: list, // ✅ 傳 RxList
                            context: Get.context!,
                            title: "lbl308_2".tr,
                            subTitle: "lbl132".tr,
                            createModel: (text) => ChipviewItemModel(
                              five: text.obs,
                              isSelected: true.obs,
                            ),
                            onRefresh: () =>
                                controller.k30ModelObj.value.chipviewItemList,
                            onToggle: (m) => m.isSelected?.toggle(),
                          );
                        } else if (index == 0) {
                          // Toggle index 0 並取消其他選中狀態
                          final wasSelected = model.isSelected?.value ?? false;
                          for (var i = 0; i < list.length; i++) {
                            list[i].isSelected?.value = false;
                          }
                          model.isSelected?.value = !wasSelected;
                        } else {
                          // index != 0，檢查第一個是否有選中
                          if (!(list[0].isSelected?.value ?? false)) {
                            model.isSelected?.toggle();
                          }
                        }
                        controller.updateSelectedFoodHabits();
                      },
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
            "lbl315".tr,
            style: CustomTextStyles.titleMediumErrorContainer,
          ),
          SizedBox(height: 4.h),
          Text(
            "lbl315_1".tr,
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
                  controller.k30ModelObj.value.chipviewOneItemList.length,
                  (index) {
                    final model =
                        controller.k30ModelObj.value.chipviewOneItemList[index];
                    return ChipviewOneItemWidget(
                      model,
                      onTap: () {
                        var list =
                            controller.k30ModelObj.value.chipviewOneItemList;
                        var lastIndex = list.length - 1; // lastIndex
                        if (index == lastIndex) {
                          controller.handleChipTap<ChipviewOneItemModel>(
                            index: index,
                            model: model,
                            list: list, // ✅ 傳 RxList
                            context: Get.context!,
                            title: "lbl315_2".tr,
                            subTitle: "lbl132".tr,
                            createModel: (text) => ChipviewOneItemModel(
                              one: text.obs,
                              isSelected: true.obs,
                            ),
                            onRefresh: () => controller
                                .k30ModelObj.value.chipviewOneItemList,
                            onToggle: (m) => m.isSelected?.toggle(),
                          );
                        } else if (index == 0) {
                          // Toggle index 0 並取消其他選中狀態
                          final wasSelected = model.isSelected?.value ?? false;
                          for (var i = 0; i < list.length; i++) {
                            list[i].isSelected?.value = false;
                          }
                          model.isSelected?.value = !wasSelected;
                        } else {
                          // index != 0，檢查第一個是否有選中
                          if (!(list[0].isSelected?.value ?? false)) {
                            model.isSelected?.toggle();
                          }
                        }
                        controller.updateSelectedCookHabits();
                      },
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
                  controller.k30ModelObj.value.chipviewTwoItemList.length,
                  (index) {
                    final model =
                        controller.k30ModelObj.value.chipviewTwoItemList[index];
                    return ChipviewTwoItemWidget(
                      model,
                      onTap: () {
                        var list =
                            controller.k30ModelObj.value.chipviewTwoItemList;
                        var lastIndex = list.length - 1; // lastIndex
                        if (index == lastIndex) {
                          controller.handleChipTap<ChipviewTwoItemModel>(
                            index: index,
                            model: model,
                            list: list, // ✅ 傳 RxList
                            context: Get.context!,
                            title: "lbl131".tr,
                            subTitle: "lbl132".tr,
                            createModel: (text) => ChipviewTwoItemModel(
                              two: text.obs,
                              isSelected: true.obs,
                            ),
                            onRefresh: () => controller
                                .k30ModelObj.value.chipviewTwoItemList,
                            onToggle: (m) => m.isSelected?.toggle(),
                          );
                        } else if (index == 0) {
                          // Toggle index 0 並取消其他選中狀態
                          final wasSelected = model.isSelected?.value ?? false;
                          for (var i = 0; i < list.length; i++) {
                            list[i].isSelected?.value = false;
                          }
                          model.isSelected?.value = !wasSelected;
                        } else {
                          // index != 0，檢查第一個是否有選中
                          if (!(list[0].isSelected?.value ?? false)) {
                            model.isSelected?.toggle();
                          }
                        }
                        controller.updateSelectedPastDiseases();
                      },
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
                  controller.k30ModelObj.value.chipviewThreeItemList.length,
                  (index) {
                    final model = controller
                        .k30ModelObj.value.chipviewThreeItemList[index];
                    return ChipviewThreeItemWidget(
                      model,
                      onTap: () {
                        var list =
                            controller.k30ModelObj.value.chipviewThreeItemList;
                        var lastIndex = list.length - 1; // lastIndex
                        if (index == lastIndex) {
                          controller.handleChipTap<ChipviewThreeItemModel>(
                            index: index,
                            model: model,
                            list: list, // ✅ 傳 RxList
                            context: Get.context!,
                            title: "lbl112_1".tr,
                            subTitle: "lbl132".tr,
                            createModel: (text) => ChipviewThreeItemModel(
                              three: text.obs,
                              isSelected: true.obs,
                            ),
                            onRefresh: () => controller
                                .k30ModelObj.value.chipviewThreeItemList,
                            onToggle: (m) => m.isSelected?.toggle(),
                          );
                        } else if (index == 0) {
                          // Toggle index 0 並取消其他選中狀態
                          final wasSelected = model.isSelected?.value ?? false;
                          for (var i = 0; i < list.length; i++) {
                            list[i].isSelected?.value = false;
                          }
                          model.isSelected?.value = !wasSelected;
                        } else {
                          // index != 0，檢查第一個是否有選中
                          if (!(list[0].isSelected?.value ?? false)) {
                            model.isSelected?.toggle();
                          }
                        }
                        controller.updateSelectedFamilyDiseases();
                      },
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
  Widget _buildColumnone6() {
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
                  controller.k30ModelObj.value.chipviewFourItemList.length,
                  (index) {
                    ChipviewFourItemModel model = controller
                        .k30ModelObj.value.chipviewFourItemList[index];
                    return ChipviewFourItemWidget(
                      model,
                      onTap: () {
                        var list =
                            controller.k30ModelObj.value.chipviewFourItemList;
                        var lastIndex = list.length - 1; // lastIndex
                        if (index == lastIndex) {
                          controller.handleChipTap<ChipviewFourItemModel>(
                            index: index,
                            model: model,
                            list: list, // ✅ 傳 RxList
                            context: Get.context!,
                            title: "lbl113_1".tr,
                            subTitle: "lbl132".tr,
                            createModel: (text) => ChipviewFourItemModel(
                              four: text.obs,
                              isSelected: true.obs,
                            ),
                            onRefresh: () => controller
                                .k30ModelObj.value.chipviewFourItemList,
                            onToggle: (m) => m.isSelected?.toggle(),
                          );
                        } else if (index == 0) {
                          // Toggle index 0 並取消其他選中狀態
                          final wasSelected = model.isSelected?.value ?? false;
                          for (var i = 0; i < list.length; i++) {
                            list[i].isSelected?.value = false;
                          }
                          model.isSelected?.value = !wasSelected;
                        } else {
                          // index != 0，檢查第一個是否有選中
                          if (!(list[0].isSelected?.value ?? false)) {
                            model.isSelected?.toggle();
                          }
                        }
                        controller.updateSelectedDrugAllergies();
                      },
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
            onPressed: () async {
              var res = await controller.prossesSaveProfile();
              if (res) {
                Get.back();
              }
            },
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
