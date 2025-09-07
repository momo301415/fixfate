import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../core/utils/date_time_utils.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/k27_controller.dart'; // ignore_for_file: must_be_immutable
import 'custom_selection_dialog.dart';

// 填寫身體資料
class K27Screen extends GetWidget<K27Controller> {
  const K27Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
        title: "lbl422".tr,
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 220.h,
                child: Text(
                  "msg41".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodySmall11_1.copyWith(height: 1.70),
                ),
              ),
              SizedBox(height: 16.h),
              _buildBodyInfoSection(),
              SizedBox(height: 20.h),
              CustomElevatedButton(
                onPressed: () => controller.submitBodyInfo(),
                text: "lbl424".tr,
                margin: EdgeInsets.symmetric(horizontal: 16.h),
                buttonStyle: CustomButtonStyles.none,
                decoration:
                    CustomButtonStyles.gradientCyanToPrimaryTL8Decoration,
              ),
              SizedBox(height: 20.h),
              Text("lbl425".tr, style: CustomTextStyles.bodySmall11_1),
            ],
          ),
        ));
  }

  /// Section Widget
  Widget _buildBodyInfoSection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      padding: EdgeInsets.all(24.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("lbl423".tr, style: CustomTextStyles.bodySmallBluegray900),
          SizedBox(height: 8.h),
          CustomTextFormField(
            readOnly: true,
            controller: controller.genderController,
            hintText: "lbl77".tr,
            hintStyle: CustomTextStyles.bodyMediumPrimaryContainer_3,
            textInputAction: TextInputAction.done,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.h,
              vertical: 10.h,
            ),
            onTap: () {
              // onTapInputlighttwo();
              controller.selectGenderDialog();
            },
          ),
          SizedBox(height: 24.h),
          Text("lbl78".tr, style: CustomTextStyles.bodySmallBluegray900),
          SizedBox(height: 8.h),
          CustomTextFormField(
            readOnly: true,
            controller: controller.inputlighttwoController,
            hintText: "lbl_1985_03_14".tr,
            hintStyle: CustomTextStyles.bodyMediumPrimaryContainer_3,
            textInputAction: TextInputAction.done,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.h,
              vertical: 10.h,
            ),
            onTap: () {
              // onTapInputlighttwo();
              controller.showTimeDialog();
            },
          ),
          SizedBox(height: 24.h),
          Text("lbl80".tr, style: CustomTextStyles.bodySmallBluegray900),
          SizedBox(height: 8.h),
   
          InkWell(
            onTap: () => controller.showHeightInputDialog(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
              decoration: AppDecoration.gray100.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder2,
              ),
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                        controller.heightValueObx.value.isEmpty
                            ? 'lbl54'.tr
                            : controller.heightValueObx.value,
                        style:! controller.heightValueObx.value.isEmpty
                            ? CustomTextStyles.bodyMediumPrimaryContainer_3
                            : CustomTextStyles.bodyMediumGray500_1,
                      )),
                  Text("lbl_cm".tr, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text("lbl79".tr, style: CustomTextStyles.bodySmallBluegray900),
          SizedBox(height: 8.h),
          InkWell(
            onTap: () => controller.showWeightInputDialog(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
              decoration: AppDecoration.gray100.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder2,
              ),
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(controller.weightValueObx.value.isEmpty
                      ? 'lbl54'.tr
                      : controller.weightValueObx.value,
                      style: !controller.weightValueObx.value.isEmpty
                          ? CustomTextStyles.bodyMediumPrimaryContainer_3
                          : CustomTextStyles.bodyMediumGray500_1)),
                  Text("lbl_kg".tr, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}
