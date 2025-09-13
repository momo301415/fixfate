import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/home_page/controller/home_controller.dart';
import 'package:pulsedevice/presentation/k13_screen/widgets/nutrition_card_widget.dart';
import 'package:pulsedevice/presentation/k13_screen/widgets/custom_circular_progress.dart';
import 'package:pulsedevice/presentation/k13_screen/widgets/custom_horizontal_progress.dart';
import 'package:pulsedevice/presentation/k13_screen/widgets/custom_date_selector.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';

import '../../theme/custom_button_style.dart';
import '../../widgets/custom_bottom_bar.dart';

import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import 'controller/k13_controller.dart';

// ignore_for_file: must_be_immutable
// 饮食记录
class K13Screen extends GetWidget<K13Controller> {
  const K13Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      enabled: homeController.cc.isK19Visible.value,
      child: Container(
        margin: EdgeInsets.only(bottom: 120.h),
        child: BaseScaffoldImageHeader(
            onBack: () =>
                Get.find<HomeController>().cc.isK19Visible.value = false,
            title: "lbl383".tr,
            child: Container(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: double.maxFinite,
                    child: Column(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildIntakeGoalSection(),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.all(16.h),
                          decoration: AppDecoration.fillWhiteA.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder8,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await controller.showSelectAllFood();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: appTheme.gray30066,
                                    borderRadius:
                                        BorderRadius.circular(8.0), // 圆角
                                  ),
                                  padding: const EdgeInsets.all(12.0), // 内边距
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "lbl348".tr,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(),
                                      CustomImageView(
                                        imagePath: ImageConstant
                                            .imgArrowdownPrimarycontainer,
                                        height: 16.h,
                                        width: 16.h,
                                        fit: BoxFit.contain,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              _buildCalorieIntakeRow(),
                              // 营养卡片列表
                              Column(
                                children: controller.nutritionCards
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final index = entry.key;
                                  final data = entry.value;
                                  return InkWell(
                                    onTap: () async {
                                      // 等待K2Screen返回编辑后的数据
                                      final editedData = await Get.toNamed(
                                          AppRoutes.editYsScreen,
                                          arguments: data.copyWith());
                                      if (editedData != null &&
                                          editedData is NutritionCardData) {
                                        print(" editedData   ${editedData} ");
                                        // 更新对应位置的数据
                                        controller.updateNutritionCard(
                                            index, editedData);
                                      }
                                    },
                                    child: NutritionCard(data: data),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.symmetric(horizontal: 8.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      spacing: 10,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomIconButton(
                                          height: 40.h,
                                          width: 40.h,
                                          padding: EdgeInsets.all(10.h),
                                          decoration:
                                              IconButtonStyleHelper.fillPrimary,
                                          child: CustomImageView(
                                            imagePath:
                                                ImageConstant.imgFiRrUtensils,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 8.h),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 4.h,
                                          ),
                                          decoration:
                                              AppDecoration.gray100.copyWith(
                                            borderRadius:
                                                BorderRadiusStyle.circleBorder2,
                                          ),
                                          child: Text(
                                            "lbl358".tr,
                                            textAlign: TextAlign.center,
                                            style: CustomTextStyles
                                                .bodySmallBluegray4008,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Expanded(
                                    //   child: Align(
                                    //     alignment: Alignment.bottomCenter,
                                    //     child: Padding(
                                    //       padding: EdgeInsets.only(top: 6.h),
                                    //       child: _buildSupperRow(
                                    //         time: "lbl_09_30_pm".tr,
                                    //         prop: "lbl395".tr,
                                    //         one: "lbl_13".tr,
                                    //         prop1: "lbl338".tr,
                                    //         calorieValue: "lbl_1500".tr,
                                    //         kcal: "lbl_kcal".tr,
                                    //         prop2: "lbl339".tr,
                                    //         carbohydrateValue: "lbl_8_32".tr,
                                    //         gTwenty: "lbl_g".tr,
                                    //         five: "lbl340".tr,
                                    //         p83Twentyone: "lbl_31_02".tr,
                                    //         gTwentyone: "lbl_g".tr,
                                    //         prop3: "lbl341".tr,
                                    //         fatValue: "lbl_3_62".tr,
                                    //         gTwentytwo: "lbl_g".tr,
                                    //         one1: "lbl342".tr,
                                    //         fiberValue: "lbl_0_0".tr,
                                    //         gTwentythree: "lbl_g".tr,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  /// Section Widget
  Widget _buildHeaderSection() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 90.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgUnionBg2,
              height: 90.h,
              width: double.maxFinite,
              radius: BorderRadius.vertical(bottom: Radius.circular(36.h)),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 32.h,
                            top: 8.h,
                            right: 32.h,
                          ),
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgArrowLeftWhiteA700,
                                height: 24.h,
                                width: 24.h,
                                alignment: Alignment.bottomCenter,
                                onTap: () {
                                  onTapImgArrowleftone();
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 92.h),
                                child: Text(
                                  "lbl383".tr,
                                  style: theme.textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildIntakeGoalSection() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        spacing: 20,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 4.h),
          // 日期選擇組件
          Obx(() => CustomDateSelector(
            selectedDate: controller.selectedDate.value,
            onDateChanged: controller.updateSelectedDate,
          )),
          // 圓環和營養進度條
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(left: 16.h, right: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 自定義圓環進度組件
                Obx(() => CustomCircularProgress(
                  size: 122.h,
                  outerRadius: 60.h,
                  innerRadius: 48.h,
                  currentValue: controller.currentKcal.value.toDouble(),
                  totalValue: controller.kcalNumber.value.toDouble(),
                  centerLabel: "lbl415".tr, // "已攝取"
                  centerValue: controller.currentKcal.value.toString(),
                  centerUnit: "lbl_kcal".tr,
                  progressColor: appTheme.cyan70001,
                  backgroundColor: appTheme.teal5001,
                )),
                // 營養素水平進度條
                SizedBox(
                  width: 122.h,
                  child: Column(
                    children: [
                      // 碳水化合物
                      Obx(() => CustomHorizontalProgress(
                        label: "lbl339".tr, // "碳水化合物"
                        currentValue: controller.carbohydrates.value.current,
                        targetValue: controller.carbohydrates.value.target,
                        unit: controller.carbohydrates.value.unit,
                        progressColor: appTheme.cyan70001,
                        backgroundColor: appTheme.teal5003,
                        height: 8.h,
                        width: 122.h,
                      )),
                      SizedBox(height: 10.h),
                      // 蛋白質
                      Obx(() => CustomHorizontalProgress(
                        label: "lbl340".tr, // "蛋白質"
                        currentValue: controller.protein.value.current,
                        targetValue: controller.protein.value.target,
                        unit: controller.protein.value.unit,
                        progressColor: appTheme.cyan70001,
                        backgroundColor: appTheme.teal5003,
                        height: 8.h,
                        width: 122.h,
                      )),
                      SizedBox(height: 10.h),
                      // 脂肪
                      Obx(() => CustomHorizontalProgress(
                        label: "lbl341".tr, // "脂肪"
                        currentValue: controller.fat.value.current,
                        targetValue: controller.fat.value.target,
                        unit: controller.fat.value.unit,
                        progressColor: appTheme.cyan70001,
                        backgroundColor: appTheme.teal5003,
                        height: 8.h,
                        width: 122.h,
                      )),
                      SizedBox(height: 10.h),
                      // 膳食纖維
                      Obx(() => CustomHorizontalProgress(
                        label: "lbl416".tr, // "膳食纖維"
                        currentValue: controller.fiber.value.current,
                        targetValue: controller.fiber.value.target,
                        unit: controller.fiber.value.unit,
                        progressColor: appTheme.cyan70001,
                        backgroundColor: appTheme.teal5003,
                        height: 8.h,
                        width: 122.h,
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 目標攝取量和修改按鈕
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(),
                Text("lbl384".tr, style: theme.textTheme.bodySmall), // "目標攝取量"
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: EdgeInsets.only(left: 26.h, bottom: 4.h),
                      child: Obx(() => Text(
                            "${controller.kcalNumber.value}",
                            style: CustomTextStyles.titleMediumPrimary,
                          ))),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 6.h, bottom: 10.h),
                    child: Text(
                      "lbl_kcal".tr,
                      style: CustomTextStyles.bodySmallBluegray40010,
                    ),
                  ),
                ),
                CustomElevatedButton(
                  height: 38.h,
                  width: 84.h,
                  text: "lbl282".tr, // "修改"
                  margin: EdgeInsets.only(left: 26.h),
                  leftIcon: Container(
                    margin: EdgeInsets.only(right: 4.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgFiedit2,
                      height: 20.h,
                      width: 20.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  buttonStyle: CustomButtonStyles.fillBlue,
                  buttonTextStyle:
                      CustomTextStyles.titleSmallErrorContainer14_1,
                  onPressed: () async {
                    await controller.showInputKcal();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCalorieIntakeRow() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: AppDecoration.outlineGray200,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              "lbl385".tr,
              style: CustomTextStyles.titleSmallErrorContainer,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "lbl_1_250".tr,
              style: CustomTextStyles.titleMediumPrimary,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 4.h, bottom: 4.h),
              child: Text(
                "lbl_kcal".tr,
                style: CustomTextStyles.bodySmallBluegray40010,
              ),
            ),
          ),
          Spacer(),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 4.h),
              decoration: AppDecoration.fillBlue.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder2,
              ),
              child: InkWell(
                onTap: () => Get.toNamed(AppRoutes.scanFoodScreen),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgUplusPrimary,
                      height: 20.h,
                      width: 20.h,
                    ),
                    Text("lbl158".tr,
                        style: CustomTextStyles.labelLargePrimary),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBreakfastRow() {
    return Container(
      padding: EdgeInsets.fromLTRB(8.h, 10.h, 8.h, 8.h),
      decoration: AppDecoration.outlineGray200,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomIconButton(
                height: 40.h,
                width: 40.h,
                padding: EdgeInsets.all(10.h),
                decoration: IconButtonStyleHelper.fillPrimary,
                child: CustomImageView(
                  imagePath: ImageConstant.imgFiRrUtensils,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 4.h),
                decoration: AppDecoration.gray100.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder2,
                ),
                child: Text(
                  "lbl346".tr,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodySmallBluegray4008,
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: _buildSupperRow(
                  time: "lbl_9_30_am".tr,
                  prop: "lbl337".tr,
                  one: "lbl_13".tr,
                  prop1: "lbl379".tr,
                  calorieValue: "lbl_1500".tr,
                  kcal: "lbl_kcal".tr,
                  prop2: "lbl339".tr,
                  carbohydrateValue: "lbl_8_32".tr,
                  gTwenty: "lbl_g".tr,
                  five: "lbl340".tr,
                  p83Twentyone: "lbl_31_02".tr,
                  gTwentyone: "lbl_g".tr,
                  prop3: "lbl417".tr,
                  fatValue: "lbl_3_62".tr,
                  gTwentytwo: "lbl_g".tr,
                  one1: "lbl416".tr,
                  fiberValue: "lbl_0_0".tr,
                  gTwentythree: "lbl_g".tr,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTeaRow() {
    return Container(
      padding: EdgeInsets.fromLTRB(8.h, 12.h, 8.h, 10.h),
      decoration: AppDecoration.outlineGray200,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomIconButton(
                height: 40.h,
                width: 40.h,
                padding: EdgeInsets.all(10.h),
                decoration: IconButtonStyleHelper.fillPrimary,
                child: CustomImageView(
                  imagePath: ImageConstant.imgFiRrUtensils,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 4.h),
                decoration: AppDecoration.gray100.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder2,
                ),
                child: Text(
                  "lbl346".tr,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodySmallBluegray4008,
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              spacing: 8,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: _buildRowOne(
                    orderTime: "lbl_9_30_am".tr,
                    drinkName: "lbl386".tr,
                    drinkQuantity: "lbl_13".tr,
                    prop: "lbl387".tr,
                    calorieValue: "lbl_1500".tr,
                    kcal: "lbl_kcal".tr,
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "lbl388".tr,
                        style: CustomTextStyles.bodySmallBluegray4008,
                      ),
                      Spacer(flex: 49),
                      Text(
                        "lbl_8_32".tr,
                        style: CustomTextStyles.labelSmallBluegray400,
                      ),
                      Text(
                        "lbl_g".tr,
                        style: CustomTextStyles.bodySmallBluegray4008,
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgVector308,
                        height: 6.h,
                        width: 3.h,
                        margin: EdgeInsets.only(left: 8.h),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 6.h),
                        child: Text(
                          "lbl417".tr,
                          style: CustomTextStyles.bodySmallBluegray4008,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text(
                          "lbl_31_02".tr,
                          style: CustomTextStyles.labelSmallBluegray400,
                        ),
                      ),
                      Text(
                        "lbl_g".tr,
                        style: CustomTextStyles.bodySmallBluegray4008,
                      ),
                      Spacer(flex: 50),
                      CustomImageView(
                        imagePath: ImageConstant.imgNotification,
                        height: 16.h,
                        width: 18.h,
                        alignment: Alignment.bottomCenter,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildWaterIntakeRow() {
    return Container(
      padding: EdgeInsets.fromLTRB(8.h, 12.h, 8.h, 10.h),
      decoration: AppDecoration.outlineGray200,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomIconButton(
                  height: 40.h,
                  width: 40.h,
                  padding: EdgeInsets.all(10.h),
                  decoration: IconButtonStyleHelper.fillPrimary,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgIconUWaterGlass,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 8.h),
                  padding: EdgeInsets.symmetric(horizontal: 4.h),
                  decoration: AppDecoration.gray100.copyWith(
                    borderRadius: BorderRadiusStyle.circleBorder2,
                  ),
                  child: Text(
                    "lbl352".tr,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.bodySmallBluegray4008,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(left: 6.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "lbl_10_00_am".tr,
                              style: CustomTextStyles.labelSmallPrimary,
                            ),
                            Text(
                              "lbl389".tr,
                              style: CustomTextStyles.bodySmall11,
                            ),
                          ],
                        ),
                        Spacer(flex: 50),
                        Text(
                          "lbl_500".tr,
                          style: CustomTextStyles.titleSmallBluegray40014,
                        ),
                        Text(
                          "lbl_ml".tr,
                          style: CustomTextStyles.bodySmallBluegray40010,
                        ),
                        Spacer(flex: 50),
                        Text(
                          "lbl_0".tr,
                          style: CustomTextStyles.titleSmallPrimary,
                        ),
                        Text(
                          "lbl_kcal".tr,
                          style: CustomTextStyles.bodySmallBluegray40010,
                        ),
                      ],
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgNotification,
                    height: 16.h,
                    width: 18.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildLunchRow() {
    return Container(
      padding: EdgeInsets.fromLTRB(8.h, 10.h, 8.h, 8.h),
      decoration: AppDecoration.outlineGray200,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomIconButton(
                height: 40.h,
                width: 40.h,
                padding: EdgeInsets.all(10.h),
                decoration: IconButtonStyleHelper.fillPrimary,
                child: CustomImageView(
                  imagePath: ImageConstant.imgFiRrUtensils,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 4.h),
                decoration: AppDecoration.gray100.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder2,
                ),
                child: Text(
                  "lbl350".tr,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodySmallBluegray4008,
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: Column(
                  spacing: 8,
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "lbl_12_30_am".tr,
                                style: CustomTextStyles.labelSmallPrimary,
                              ),
                              Text(
                                "lbl390".tr,
                                style: CustomTextStyles.bodySmall11,
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            "lbl_13".tr,
                            style: CustomTextStyles.titleSmallBluegray40014,
                          ),
                          Text(
                            "lbl338".tr,
                            style: CustomTextStyles.bodySmallBluegray40010,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.h),
                            child: Text(
                              "lbl_1500".tr,
                              style: CustomTextStyles.titleSmallPrimary,
                            ),
                          ),
                          Text(
                            "lbl_kcal".tr,
                            style: CustomTextStyles.bodySmallBluegray40010,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: _buildRownotification(
                        prop: "lbl339".tr,
                        p83Six: "lbl_8_32".tr,
                        gSix: "lbl_g".tr,
                        two: "lbl340".tr,
                        p83Seven: "lbl_31_02".tr,
                        gSeven: "lbl_g".tr,
                        two1: "lbl417".tr,
                        p83Eight: "lbl_3_62".tr,
                        gEight: "lbl_g".tr,
                        two2: "lbl416".tr,
                        p83Nine: "lbl_0_0".tr,
                        gNine: "lbl_g".tr,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSnackRow() {
    return Container(
      padding: EdgeInsets.fromLTRB(8.h, 10.h, 8.h, 8.h),
      decoration: AppDecoration.outlineGray200,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomIconButton(
                height: 40.h,
                width: 40.h,
                padding: EdgeInsets.all(10.h),
                decoration: IconButtonStyleHelper.fillPrimary,
                child: CustomImageView(
                  imagePath: ImageConstant.imgFiRrUtensils,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 4.h),
                decoration: AppDecoration.gray100.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder2,
                ),
                child: Text(
                  "lbl353".tr,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodySmallBluegray4008,
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Column(
                  spacing: 8,
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: _buildRowtimeTwo(
                        time: "lbl_02_20_pm".tr,
                        drinkName: "lbl391".tr,
                        volume: "lbl_500".tr,
                        ml: "lbl392".tr,
                        calories: "lbl_1500".tr,
                        kcal: "lbl_kcal".tr,
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: _buildRownotification(
                        prop: "lbl339".tr,
                        p83Six: "lbl_8_32".tr,
                        gSix: "lbl_g".tr,
                        two: "lbl340".tr,
                        p83Seven: "lbl_31_02".tr,
                        gSeven: "lbl_g".tr,
                        two1: "lbl418".tr,
                        p83Eight: "lbl_3_62".tr,
                        gEight: "lbl_g".tr,
                        two2: "lbl416".tr,
                        p83Nine: "lbl_0_0".tr,
                        gNine: "lbl_g".tr,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildMilkTeaRow() {
    return Container(
      padding: EdgeInsets.fromLTRB(8.h, 12.h, 8.h, 10.h),
      decoration: AppDecoration.outlineGray200,
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40.h,
            width: 40.h,
            decoration: AppDecoration.fillPrimary1.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder20,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgFiRrUtensils,
                  height: 20.h,
                  width: 22.h,
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 6.h, bottom: 4.h),
                child: Column(
                  spacing: 8,
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: _buildRowtimeTwo(
                        time: "lbl_02_20_pm".tr,
                        drinkName: "lbl393".tr,
                        volume: "lbl_750".tr,
                        ml: "lbl_ml".tr,
                        calories: "lbl_1500".tr,
                        kcal: "lbl_kcal".tr,
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "lbl388".tr,
                            style: CustomTextStyles.bodySmallBluegray4008,
                          ),
                          Spacer(flex: 34),
                          Text(
                            "lbl_8_32".tr,
                            style: CustomTextStyles.labelSmallBluegray400,
                          ),
                          Text(
                            "lbl_g".tr,
                            style: CustomTextStyles.bodySmallBluegray4008,
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgVector308,
                            height: 6.h,
                            width: 3.h,
                            margin: EdgeInsets.only(left: 8.h),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 6.h),
                            child: Text(
                              "lbl341".tr,
                              style: CustomTextStyles.bodySmallBluegray4008,
                            ),
                          ),
                          Spacer(flex: 30),
                          Text(
                            "lbl_31_02".tr,
                            style: CustomTextStyles.labelSmallBluegray400,
                          ),
                          Text(
                            "lbl_g".tr,
                            style: CustomTextStyles.bodySmallBluegray4008,
                          ),
                          Spacer(flex: 35),
                          CustomImageView(
                            imagePath: ImageConstant.imgNotification,
                            height: 16.h,
                            width: 18.h,
                            alignment: Alignment.bottomCenter,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildDinnerRow() {
    return Container(
      padding: EdgeInsets.fromLTRB(8.h, 10.h, 8.h, 8.h),
      decoration: AppDecoration.outlineGray200,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomIconButton(
                height: 40.h,
                width: 40.h,
                padding: EdgeInsets.all(10.h),
                decoration: IconButtonStyleHelper.fillPrimary,
                child: CustomImageView(
                  imagePath: ImageConstant.imgFiRrUtensils,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 4.h),
                decoration: AppDecoration.gray100.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder2,
                ),
                child: Text(
                  "lbl351".tr,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodySmallBluegray4008,
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Column(
                  spacing: 8,
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "lbl_07_30_pm".tr,
                                  style: CustomTextStyles.labelSmallPrimary,
                                ),
                                Text(
                                  "lbl394".tr,
                                  style: CustomTextStyles.bodySmall11,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.h),
                            child: Text(
                              "lbl_202".tr,
                              style: CustomTextStyles.titleSmallBluegray40014,
                            ),
                          ),
                          Text(
                            "lbl380".tr,
                            style: CustomTextStyles.bodySmallBluegray40010,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.h),
                            child: Text(
                              "lbl_1500".tr,
                              style: CustomTextStyles.titleSmallPrimary,
                            ),
                          ),
                          Text(
                            "lbl_kcal".tr,
                            style: CustomTextStyles.bodySmallBluegray40010,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: _buildRownotification(
                        prop: "lbl339".tr,
                        p83Six: "lbl_8_32".tr,
                        gSix: "lbl_g".tr,
                        two: "lbl340".tr,
                        p83Seven: "lbl_31_02".tr,
                        gSeven: "lbl_g".tr,
                        two1: "lbl418".tr,
                        p83Eight: "lbl_3_62".tr,
                        gEight: "lbl_g".tr,
                        two2: "lbl416".tr,
                        p83Nine: "lbl_0_0".tr,
                        gNine: "lbl_g".tr,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomNavigationBar() {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        onChanged: (p0) {},
      ),
    );
  }

  /// Common widget
  Widget _buildRownotification({
    required String prop,
    required String p83Six,
    required String gSix,
    required String two,
    required String p83Seven,
    required String gSeven,
    required String two1,
    required String p83Eight,
    required String gEight,
    required String two2,
    required String p83Nine,
    required String gNine,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 180.h,
            child: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        prop,
                        style: CustomTextStyles.bodySmallBluegray4008.copyWith(
                          color: appTheme.blueGray400,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 22.h),
                        child: Text(
                          p83Six,
                          style: CustomTextStyles.labelSmallBluegray400
                              .copyWith(color: appTheme.blueGray400),
                        ),
                      ),
                      Text(
                        gSix,
                        style: CustomTextStyles.bodySmallBluegray4008.copyWith(
                          color: appTheme.blueGray400,
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgVector308,
                        height: 6.h,
                        width: 3.h,
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(left: 8.h),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 6.h),
                        child: Text(
                          two,
                          style: CustomTextStyles.bodySmallBluegray4008
                              .copyWith(color: appTheme.blueGray400),
                        ),
                      ),
                      Spacer(),
                      Text(
                        p83Seven,
                        style: CustomTextStyles.labelSmallBluegray400.copyWith(
                          color: appTheme.blueGray400,
                        ),
                      ),
                      Text(
                        gSeven,
                        style: CustomTextStyles.bodySmallBluegray4008.copyWith(
                          color: appTheme.blueGray400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        two1,
                        style: CustomTextStyles.bodySmallBluegray4008.copyWith(
                          color: appTheme.blueGray400,
                        ),
                      ),
                      Spacer(flex: 50),
                      Text(
                        p83Eight,
                        style: CustomTextStyles.labelSmallBluegray400.copyWith(
                          color: appTheme.blueGray400,
                        ),
                      ),
                      Text(
                        gEight,
                        style: CustomTextStyles.bodySmallBluegray4008.copyWith(
                          color: appTheme.blueGray400,
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgVector308,
                        height: 6.h,
                        width: 3.h,
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(left: 8.h),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 6.h),
                        child: Text(
                          two2,
                          style: CustomTextStyles.bodySmallBluegray4008
                              .copyWith(color: appTheme.blueGray400),
                        ),
                      ),
                      Spacer(flex: 49),
                      Text(
                        p83Nine,
                        style: CustomTextStyles.labelSmallBluegray400.copyWith(
                          color: appTheme.blueGray400,
                        ),
                      ),
                      Text(
                        gNine,
                        style: CustomTextStyles.bodySmallBluegray4008.copyWith(
                          color: appTheme.blueGray400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgNotification,
          height: 16.h,
          width: 18.h,
          margin: EdgeInsets.only(top: 4.h),
        ),
      ],
    );
  }

  /// Common widget
  Widget _buildRowtimeTwo({
    required String time,
    required String drinkName,
    required String volume,
    required String ml,
    required String calories,
    required String kcal,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: CustomTextStyles.labelSmallPrimary.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              Text(
                drinkName,
                style: CustomTextStyles.bodySmall11.copyWith(
                  color: theme.colorScheme.errorContainer,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.h),
          child: Text(
            volume,
            style: CustomTextStyles.titleSmallBluegray40014.copyWith(
              color: appTheme.blueGray400,
            ),
          ),
        ),
        Text(
          ml,
          style: CustomTextStyles.bodySmallBluegray40010.copyWith(
            color: appTheme.blueGray400,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.h),
          child: Text(
            calories,
            style: CustomTextStyles.titleSmallPrimary.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        Text(
          kcal,
          style: CustomTextStyles.bodySmallBluegray40010.copyWith(
            color: appTheme.blueGray400,
          ),
        ),
      ],
    );
  }

  /// Common widget
  Widget _buildRowOne({
    required String orderTime,
    required String drinkName,
    required String drinkQuantity,
    required String prop,
    required String calorieValue,
    required String kcal,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderTime,
                style: CustomTextStyles.labelSmallPrimary.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              Text(
                drinkName,
                style: CustomTextStyles.bodySmall11.copyWith(
                  color: theme.colorScheme.errorContainer,
                ),
              ),
            ],
          ),
        ),
        Text(
          drinkQuantity,
          style: CustomTextStyles.titleSmallBluegray40014.copyWith(
            color: appTheme.blueGray400,
          ),
        ),
        Text(
          prop,
          style: CustomTextStyles.bodySmallBluegray40010.copyWith(
            color: appTheme.blueGray400,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.h),
          child: Text(
            calorieValue,
            style: CustomTextStyles.titleSmallPrimary.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        Text(
          kcal,
          style: CustomTextStyles.bodySmallBluegray40010.copyWith(
            color: appTheme.blueGray400,
          ),
        ),
      ],
    );
  }

  /// Common widget
  Widget _buildRow({
    required String six,
    required String currentAndGoalValue,
    required String one,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          six,
          style: CustomTextStyles.bodySmall8.copyWith(
            color: theme.colorScheme.errorContainer,
          ),
        ),
        Spacer(),
        Text(
          currentAndGoalValue,
          style: CustomTextStyles.pingFangTC4ErrorContainer.copyWith(
            color: theme.colorScheme.errorContainer,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            one,
            style: CustomTextStyles.pingFangTC4ErrorContainerRegular6.copyWith(
              color: theme.colorScheme.errorContainer,
            ),
          ),
        ),
      ],
    );
  }

  /// Common widget
  Widget _buildSupperRow({
    required String time,
    required String prop,
    required String one,
    required String prop1,
    required String calorieValue,
    required String kcal,
    required String prop2,
    required String carbohydrateValue,
    required String gTwenty,
    required String five,
    required String p83Twentyone,
    required String gTwentyone,
    required String prop3,
    required String fatValue,
    required String gTwentytwo,
    required String one1,
    required String fiberValue,
    required String gTwentythree,
  }) {
    return Column(
      spacing: 8,
      children: [
        SizedBox(
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      time,
                      style: CustomTextStyles.labelSmallPrimary.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    Text(
                      prop,
                      style: CustomTextStyles.bodySmall11.copyWith(
                        color: theme.colorScheme.errorContainer,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                one,
                style: CustomTextStyles.titleSmallBluegray40014.copyWith(
                  color: appTheme.blueGray400,
                ),
              ),
              Text(
                prop1,
                style: CustomTextStyles.bodySmallBluegray40010.copyWith(
                  color: appTheme.blueGray400,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.h),
                child: Text(
                  calorieValue,
                  style: CustomTextStyles.titleSmallPrimary.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              Text(
                kcal,
                style: CustomTextStyles.bodySmallBluegray40010.copyWith(
                  color: appTheme.blueGray400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 180.h,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              prop2,
                              style: CustomTextStyles.bodySmallBluegray4008
                                  .copyWith(color: appTheme.blueGray400),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 22.h),
                              child: Text(
                                carbohydrateValue,
                                style: CustomTextStyles.labelSmallBluegray400
                                    .copyWith(color: appTheme.blueGray400),
                              ),
                            ),
                            Text(
                              gTwenty,
                              style: CustomTextStyles.bodySmallBluegray4008
                                  .copyWith(color: appTheme.blueGray400),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgVector308,
                              height: 6.h,
                              width: 3.h,
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.only(left: 8.h),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 6.h),
                              child: Text(
                                five,
                                style: CustomTextStyles.bodySmallBluegray4008
                                    .copyWith(color: appTheme.blueGray400),
                              ),
                            ),
                            Spacer(),
                            Text(
                              p83Twentyone,
                              style: CustomTextStyles.labelSmallBluegray400
                                  .copyWith(color: appTheme.blueGray400),
                            ),
                            Text(
                              gTwentyone,
                              style: CustomTextStyles.bodySmallBluegray4008
                                  .copyWith(color: appTheme.blueGray400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              prop3,
                              style: CustomTextStyles.bodySmallBluegray4008
                                  .copyWith(color: appTheme.blueGray400),
                            ),
                            Spacer(flex: 54),
                            Text(
                              fatValue,
                              style: CustomTextStyles.labelSmallBluegray400
                                  .copyWith(color: appTheme.blueGray400),
                            ),
                            Text(
                              gTwentytwo,
                              style: CustomTextStyles.bodySmallBluegray4008
                                  .copyWith(color: appTheme.blueGray400),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgVector308,
                              height: 6.h,
                              width: 3.h,
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.only(left: 8.h),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 6.h),
                              child: Text(
                                one1,
                                style: CustomTextStyles.bodySmallBluegray4008
                                    .copyWith(color: appTheme.blueGray400),
                              ),
                            ),
                            Spacer(flex: 45),
                            Text(
                              fiberValue,
                              style: CustomTextStyles.labelSmallBluegray400
                                  .copyWith(color: appTheme.blueGray400),
                            ),
                            Text(
                              gTwentythree,
                              style: CustomTextStyles.bodySmallBluegray4008
                                  .copyWith(color: appTheme.blueGray400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgNotification,
                height: 16.h,
                width: 18.h,
                margin: EdgeInsets.only(top: 4.h),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.tf:
        return "/";
      default:
        return "/";
    }
  }

  /// Navigates to the previous screen.
  onTapImgArrowleftone() {
    Get.back();
  }
}
