import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pulsedevice/presentation/k13_screen/widgets/nutrition_card_widget.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../core/utils/date_time_utils.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text_form_field.dart';

import 'controller/k2_controller.dart'; // ignore_for_file: must_be_immutable

class EditYsScreen extends GetWidget<EditYsController> {
  const EditYsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
        title: "lbl335".tr,
        child: Container(
          width: double.maxFinite,
          margin:
              EdgeInsets.only( bottom: 28.h,),
          child: Column(
            spacing: 20,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(16.h),
                decoration: AppDecoration.fillWhiteA.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder8,
                ),
                child: Column(
                  spacing: 10,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Obx(() => Text(
                            controller.foodNameData.value,
                            style: CustomTextStyles.titleSmallPrimary,
                          )),
                    ),
                    _buildFoodRow(),
                    InkWell(
                      onTap: () => controller.showInputKcal(),
                      child: Container(
                        margin: EdgeInsets.only(left: 24.h),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.h,
                          vertical: 10.h,
                        ),
                        decoration: AppDecoration.gray100.copyWith(
                          borderRadius: BorderRadiusStyle.circleBorder2,
                        ),
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => Text(
                                  "${controller.kcalData.value}",
                                  style: CustomTextStyles
                                      .bodySmallPrimaryContainer_2,
                                )),
                            Text(
                              "lbl_kcal".tr,
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true, // 添加这个
                      physics: NeverScrollableScrollPhysics(), // 添加这个
                      itemCount: controller.typeListData.length,
                      itemBuilder: (context, index) {
                        return _buildCarbohydratesRow(
                            controller.typeListData[index]);
                      },
                    ),
                    // _buildCarbohydratesRow(),
                    // _buildProteinRow(),
                    // _buildFatRow(),
                    // _buildFiberRow(),
                    _buildAddButton(),
                    _buildMealDateRow(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "lbl345".tr,
                        style: CustomTextStyles.titleSmallPrimary,
                      ),
                    ),
                    _buildMealCategoryColumn(),
                  ],
                ),
              ),
              CustomElevatedButton(
                text: "lbl124".tr,
                buttonStyle: CustomButtonStyles.none,
                decoration:
                    CustomButtonStyles.gradientCyanToPrimaryTL8Decoration,
                onPressed: () {
                  controller.saveChanges();
                },
              ),
              TextButton(
                  onPressed: () => controller.cancel(),
                  child: Text(
                    "lbl50".tr,
                    style: CustomTextStyles.titleMediumBluegray400,
                  ))
            ],
          ),
        ));
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
                                  "lbl3355".tr,
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

  /// Section Widget
  Widget _buildQuantityInput() {
    return Obx(() => CustomElevatedButton(
          height: 40.h,
          width: 40.h,
          text: "${controller.numberData.value}",
          buttonStyle: CustomButtonStyles.fillGrayTL41,
          buttonTextStyle: CustomTextStyles.bodySmallPrimaryContainer_6,
          onPressed: () {
            controller.showInputFoodNumber();
          },
        ));
  }

  /// Section Widget
  Widget _buildUnitButton() {
    return Obx(() => CustomElevatedButton(
          height: 40.h,
          width: 44.h,
          text: controller.pieceData.value,
          buttonStyle: CustomButtonStyles.fillGrayTL41,
          buttonTextStyle: CustomTextStyles.bodySmallPrimaryContainer_6,
          onPressed: () {
            controller.showInputFoodPiece();
          },
        ));
  }

  /// Section Widget
  Widget _buildFoodRow() {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: InkWell(
            onTap: () async {
              await controller.showInputFoodName();
            },
            child: Container(
              decoration: BoxDecoration(
                color: appTheme.gray30066,
                borderRadius: BorderRadius.circular(8.0), // 圆角
              ),
              padding: const EdgeInsets.all(12.0), // 内边距
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() => Text(
                        "${controller.kcalData.value ?? "lbl348".tr}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          )),
          _buildQuantityInput(),
          _buildUnitButton(),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCarbohydratesInput(String? type) {
    return Expanded(
      child: CustomTextFormField(
        hintText: "${type}".tr,
        hintStyle: CustomTextStyles.bodySmallPrimaryContainer11,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 10.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildCarbohydratesRow(FoodTypeData data) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SizedBox(
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildCarbohydratesInput(data.foodType),
            Container(
              width: 80,
              height: 40,
              margin: EdgeInsets.only(left: 12.h),
              padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
              decoration: AppDecoration.gray100.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder2,
              ),
              child: CustomTextFormField(
                hintText: "${data.foodKG}g".tr,
                hintStyle: CustomTextStyles.bodySmallPrimaryContainer11,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.h),
              child: CustomIconButton(
                height: 40.h,
                width: 40.h,
                padding: EdgeInsets.all(10.h),
                decoration: IconButtonStyleHelper.fillGray,
                child: CustomImageView(imagePath: ImageConstant.imgFiTrash2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildProteinInput() {
    return Expanded(
      child: CustomTextFormField(
        // controller: controller.proteinInputController,
        hintText: "lbl340".tr,
        hintStyle: CustomTextStyles.bodySmallPrimaryContainer11,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 10.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildProteinRow() {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildProteinInput(),
          Container(
            width: 100.h,
            margin: EdgeInsets.only(left: 12.h),
            padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
            decoration: AppDecoration.gray100.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "lbl_0_53".tr,
                  style: CustomTextStyles.bodySmallPrimaryContainer11_1,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("lbl_g".tr, style: CustomTextStyles.bodySmall11),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.h),
            child: CustomIconButton(
              height: 40.h,
              width: 40.h,
              padding: EdgeInsets.all(10.h),
              decoration: IconButtonStyleHelper.fillGray,
              child: CustomImageView(imagePath: ImageConstant.imgFiTrash2),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFatRow() {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 10.h),
            decoration: AppDecoration.gray100.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder2,
            ),
            child: Text(
              "lbl341".tr,
              textAlign: TextAlign.left,
              style: CustomTextStyles.bodySmallPrimaryContainer11,
            ),
          ),
          Container(
            width: 100.h,
            margin: EdgeInsets.only(left: 12.h),
            padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
            decoration: AppDecoration.gray100.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "lbl_0_53".tr,
                  style: CustomTextStyles.bodySmallPrimaryContainer11_1,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("lbl_g".tr, style: CustomTextStyles.bodySmall11),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.h),
            child: CustomIconButton(
              height: 40.h,
              width: 40.h,
              padding: EdgeInsets.all(10.h),
              decoration: IconButtonStyleHelper.fillGray,
              child: CustomImageView(imagePath: ImageConstant.imgFiTrash2),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFiberInput() {
    return Expanded(
      child: CustomTextFormField(
        // controller: controller.fiberInputController,
        hintText: "lbl342".tr,
        hintStyle: CustomTextStyles.bodySmallPrimaryContainer11,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 10.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildFiberRow() {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildFiberInput(),
          Container(
            width: 100.h,
            margin: EdgeInsets.only(left: 12.h),
            padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
            decoration: AppDecoration.gray100.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "lbl_0_53".tr,
                  style: CustomTextStyles.bodySmallPrimaryContainer11_1,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("lbl_g".tr, style: CustomTextStyles.bodySmall11),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.h),
            child: CustomIconButton(
              height: 40.h,
              width: 40.h,
              padding: EdgeInsets.all(10.h),
              decoration: IconButtonStyleHelper.fillGray,
              child: CustomImageView(imagePath: ImageConstant.imgFiTrash2),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAddButton() {
    return CustomElevatedButton(
      height: 40.h,
      text: "lbl294".tr,
      margin: EdgeInsets.only(left: 24.h),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 4.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgUplusBlueGray400,
          height: 20.h,
          width: 20.h,
          fit: BoxFit.contain,
        ),
      ),
      buttonStyle: CustomButtonStyles.fillGrayTL41,
      buttonTextStyle: CustomTextStyles.labelLargeBluegray400,
      onPressed: () async {
        final name = await controller.showBottomFoodName();
        if (name == null) return;
        final kg = await controller.showFoodKG(name);
        if (kg == null) return;
      },
    );
  }

  /// Section Widget
  Widget _buildMealDateInput() {
    return Padding(
        padding: EdgeInsets.only(right: 12.h),
        child: Obx(
          () => CustomTextFormField(
            readOnly: true,
            // controller: controller.mealDateInputController,
            hintText: controller.dayData.value.format(pattern: "yyyy年MM月dd日"),
            hintStyle: CustomTextStyles.bodySmallPrimaryContainer_2,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.h, vertical: 10.h),
            onTap: () async {
              await controller.showDatePicker();
              // onTapMealDateInput();
            },
          ),
        ));
  }

  /// Section Widget
  Widget _buildTimeInput() {
    return Obx(() => CustomTextFormField(
          readOnly: true,
          // controller: controller.timeInputController,
          hintText: controller.timeData.value.format(pattern: "H:s"),
          hintStyle: CustomTextStyles.bodySmallPrimaryContainer_2,
          textInputAction: TextInputAction.done,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 14.h, vertical: 10.h),
          onTap: () async {
            await controller.showTimePicker();
            // onTapTimeInput();
          },
        ));
  }

  /// Section Widget
  Widget _buildMealDateRow() {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        children: [
          Expanded(
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("lbl343".tr, style: CustomTextStyles.titleSmallPrimary),
                _buildMealDateInput(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("lbl344".tr, style: CustomTextStyles.titleSmallPrimary),
                _buildTimeInput(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildMealCategoryColumn() {
    return InkWell(
      onTap: () async {
        await controller.showMealCategorySelection();
      },
      child: Container(
        decoration: BoxDecoration(
          color: appTheme.gray30066,
          borderRadius: BorderRadius.circular(8.0), // 圆角
        ),
        padding: const EdgeInsets.all(12.0), // 内边距
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() => Text(
                  "${controller.typeData.value ?? "lbl348".tr}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ))
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSaveButton() {
    return CustomElevatedButton(
      text: "lbl124".tr,
      buttonStyle: CustomButtonStyles.none,
      decoration: CustomButtonStyles.gradientCyanToPrimaryTL8Decoration,
    );
  }

  /// Navigates to the previous screen.
  onTapImgArrowleftone() {
    Get.back();
  }

  /// Displays a date picker dialog and updates the selected date in the
  /// [k2ModelObj] object of the current [mealDateInputController] if the user
  /// selects a valid date.
  ///
  /// This function returns a `Future` that completes with `void`.
  Future<void> onTapMealDateInput() async {
    DateTime? dateTime = await showDatePicker(
      context: Get.context!,
      initialDate: controller.k2ModelObj.value.selectedMealDateInput!.value,
      firstDate: DateTime(1970),
      lastDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
    );
    if (dateTime != null) {
      controller.k2ModelObj.value.selectedMealDateInput!.value = dateTime;
      // controller.mealDateInputController.text = dateTime.format(pattern: Y_M_D);
    }
  }

  /// Displays a time picker dialog and updates the selected time in the
  /// [k2ModelObj] object of the current [controller] if the user
  /// selects a valid time.
  ///
  /// This function returns a `Future` that completes with `void`.
  Future<void> onTapTimeInput() async {
    TimeOfDay? time = await showTimePicker(
      context: Get.context!,
      initialTime: controller.k2ModelObj.value.selectedTimeInput!.value,
    );
    if (time != null) {
      controller.k2ModelObj.value.selectedTimeInput!.value = time;
      var parseDate = DateFormat.Hm().parse(time.format(Get.context!));
      // controller.timeInputController.text = parseDate.format(pattern: H_M);
    }
  }
}
