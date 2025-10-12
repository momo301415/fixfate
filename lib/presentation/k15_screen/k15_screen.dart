import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k15_controller.dart';
import 'models/foodlistsection_item_model.dart';
import 'widgets/foodlistsection_item_widget.dart'; // ignore_for_file: must_be_immutable

class K15Screen extends GetWidget<K15Controller> {
  const K15Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
        title: "lbl360".tr,
        child: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(
            left: 16.h,
            top: 70.h,
            right: 16.h,
          ),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 16.h),
                    CustomImageView(
                      imagePath: ImageConstant.imgClosePrimary,
                      height: 24.h,
                      width: 26.h,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "lbl397".tr,
                      style: CustomTextStyles.titleSmallPrimary,
                    ),
                    Text(
                      "lbl398".tr,
                      style: CustomTextStyles.bodySmallBluegray4008,
                    ),
                    SizedBox(height: 24.h),
                    _buildFoodListSection(),
                    SizedBox(height: 22.h),
                    CustomElevatedButton(
                      text: "lbl399".tr,
                      buttonStyle: CustomButtonStyles.fillGrayTL8,
                      buttonTextStyle: CustomTextStyles.bodyLargeBluegray400,
                    ),
                  ],
                ),
              ),
              CustomElevatedButton(
                text: "lbl356".tr,
                buttonStyle: CustomButtonStyles.none,
                decoration:
                    CustomButtonStyles.gradientCyanToPrimaryTL8Decoration,
              ),
              Text(
                "lbl400".tr,
                style: CustomTextStyles.titleMediumBluegray400,
              ),
            ],
          ),
        ));
  }

  /// Section Widget
  

  /// Section Widget
  Widget _buildFoodListSection() {
    return Obx(
      () => ListView.separated(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(height: 12.h);
        },
        itemCount:
            controller.k15ModelObj.value.foodlistsectionItemList.value.length,
        itemBuilder: (context, index) {
          FoodlistsectionItemModel model =
              controller.k15ModelObj.value.foodlistsectionItemList.value[index];
          return FoodlistsectionItemWidget(model);
        },
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapImgArrowleftone() {
    Get.back();
  }
}
