import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import 'controller/k3_controller.dart';

// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import 'controller/k3_controller.dart';

// ignore_for_file: must_be_immutable
class K3Bottomsheet extends StatelessWidget {
  K3Bottomsheet(this.controller, {Key? key}) : super(key: key);

  final K3Controller controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 32.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("lbl347".tr, style: CustomTextStyles.titleLargeErrorContainer),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                _buildAllFoodButton(),
                SizedBox(
                  width: 8.h,
                ),
                _buildNoCategoryButton()
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Obx(() => Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildSelectableItem(346, "lbl346".tr),
                      _buildSelectableItem(350, "lbl350".tr),
                      _buildSelectableItem(351, "lbl351".tr),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildSelectableItem(352, "lbl352".tr),
                      _buildSelectableItem(353, "lbl353".tr),
                      _buildSelectableItem(354, "lbl354".tr),
                    ],
                  ),
                ],
              )),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(children: [
              _buildCancelButton(),
              SizedBox(
                width: 16.h,
              ),
              _buildConfirmButton()
            ]),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildSelectableItem(int id, String label) {
    return GestureDetector(
      onTap: () => controller.selectItem(id),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 8.h),
        margin: EdgeInsets.symmetric(horizontal: 2),
        decoration: AppDecoration.outlineGray20001.copyWith(
          borderRadius: BorderRadiusStyle.circleBorder2,
          color: controller.selectedItemId.value == id
              ? Colors.blue.withOpacity(0.1)
              : null,
          border: controller.selectedItemId.value == id
              ? Border.all(color: Colors.blue)
              : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: CustomTextStyles.bodyLarge16.copyWith(
            color: controller.selectedItemId.value == id ? Colors.blue : null,
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAllFoodButton() {
    return Expanded(
      child: CustomOutlinedButton(
        height: 46.h,
        text: "lbl348".tr,
        buttonStyle: CustomButtonStyles.outlineGrayTL4,
        buttonTextStyle: CustomTextStyles.bodyLarge16,
      ),
    );
  }

  /// Section Widget
  Widget _buildNoCategoryButton() {
    return Expanded(
      child: CustomOutlinedButton(
        height: 46.h,
        text: "lbl349".tr,
        buttonStyle: CustomButtonStyles.outlinePrimaryTL4,
        buttonTextStyle: CustomTextStyles.bodyLargeWhiteA70016,
      ),
    );
  }

  /// Section Widget
  Widget _buildCancelButton() {
    return Expanded(
      child: CustomElevatedButton(
        height: 56.h,
        text: "lbl50".tr,
        buttonStyle: CustomButtonStyles.fillGrayTL8,
        buttonTextStyle: CustomTextStyles.bodyLargeGray500_1,
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildConfirmButton() {
    return Expanded(
      child: CustomElevatedButton(
        height: 56.h,
        text: "lbl51".tr,
        buttonStyle: CustomButtonStyles.fillPrimary,
        buttonTextStyle: CustomTextStyles.bodyLargeWhiteA700_1,
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}
