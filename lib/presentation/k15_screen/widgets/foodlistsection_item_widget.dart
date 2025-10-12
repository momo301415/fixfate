import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k15_controller.dart';
import '../models/foodlistsection_item_model.dart';

// ignore_for_file: must_be_immutable
class FoodlistsectionItemWidget extends StatelessWidget {
  FoodlistsectionItemWidget(this.foodlistsectionItemModelObj, {Key? key})
    : super(key: key);

  FoodlistsectionItemModel foodlistsectionItemModelObj;

  var controller = Get.find<K15Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.h, 10.h, 8.h, 8.h),
      decoration: AppDecoration.outlineGray200,
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
                Obx(
                  () => CustomImageView(
                    imagePath: foodlistsectionItemModelObj.tf!.value,
                    height: 20.h,
                    width: 22.h,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => Text(
                              foodlistsectionItemModelObj.tf1!.value,
                              style:
                                  CustomTextStyles.labelMediumPrimarySemiBold,
                            ),
                          ),
                          Spacer(),
                          Obx(
                            () => Text(
                              foodlistsectionItemModelObj.one!.value,
                              style: CustomTextStyles.titleSmallBluegray40014,
                            ),
                          ),
                          Obx(
                            () => Text(
                              foodlistsectionItemModelObj.tf2!.value,
                              style: CustomTextStyles.bodySmallBluegray40010,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.h),
                            child: Obx(
                              () => Text(
                                foodlistsectionItemModelObj.zipcode!.value,
                                style: CustomTextStyles.titleSmallPrimary,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              foodlistsectionItemModelObj.kcal!.value,
                              style: CustomTextStyles.bodySmallBluegray40010,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.h),
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          Obx(
                            () => Text(
                              foodlistsectionItemModelObj.tf3!.value,
                              style: CustomTextStyles.bodySmallBluegray4008,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 22.h),
                            child: Obx(
                              () => Text(
                                foodlistsectionItemModelObj.eightyThree!.value,
                                style: CustomTextStyles.labelSmallBluegray400,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              foodlistsectionItemModelObj.g!.value,
                              style: CustomTextStyles.bodySmallBluegray4008,
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
                            child: Obx(
                              () => Text(
                                foodlistsectionItemModelObj.tf4!.value,
                                style: CustomTextStyles.bodySmallBluegray4008,
                              ),
                            ),
                          ),
                          Spacer(),
                          Obx(
                            () => Text(
                              foodlistsectionItemModelObj.one1!.value,
                              style: CustomTextStyles.labelSmallBluegray400,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 64.h),
                            child: Obx(
                              () => Text(
                                foodlistsectionItemModelObj.gOne!.value,
                                style: CustomTextStyles.bodySmallBluegray4008,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          Obx(
                            () => Text(
                              foodlistsectionItemModelObj.tf5!.value,
                              style: CustomTextStyles.bodySmallBluegray4008,
                            ),
                          ),
                          Spacer(flex: 31),
                          Obx(
                            () => Text(
                              foodlistsectionItemModelObj.two!.value,
                              style: CustomTextStyles.labelSmallBluegray400,
                            ),
                          ),
                          Obx(
                            () => Text(
                              foodlistsectionItemModelObj.gTwo!.value,
                              style: CustomTextStyles.bodySmallBluegray4008,
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
                            child: Obx(
                              () => Text(
                                foodlistsectionItemModelObj.one2!.value,
                                style: CustomTextStyles.bodySmallBluegray4008,
                              ),
                            ),
                          ),
                          Spacer(flex: 25),
                          Obx(
                            () => Text(
                              foodlistsectionItemModelObj.three!.value,
                              style: CustomTextStyles.labelSmallBluegray400,
                            ),
                          ),
                          Spacer(flex: 42),
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
}
