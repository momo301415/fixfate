import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_outlined_button.dart';
import 'controller/k63_controller.dart'; // ignore_for_file: must_be_immutable

/// 帳號與安全頁面
class K63Screen extends GetWidget<K63Controller> {
  const K63Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      title: "lbl65".tr,
      child: _buildColumn(),
    );
  }

  /// Section Widget
  Widget _buildColumn() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 16.h,
        top: 10.h,
        right: 16.h,
      ),
      child: Column(
        spacing: 36,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 8.h,
            ),
            decoration: AppDecoration.fillWhiteA.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.h,
                    vertical: 16.h,
                  ),
                  decoration: AppDecoration.outlineGray,
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () {
                          if (controller.eamil.value.isEmpty) {
                            return Text(
                              "lbl194".tr,
                              style: CustomTextStyles.bodyMedium15,
                            );
                          } else {
                            return Text(
                              controller.eamil.value,
                              style: CustomTextStyles.bodyMedium15,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      controller.goOne9Screen();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.h,
                        vertical: 16.h,
                      ),
                      decoration: AppDecoration.outlineGray,
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "lbl195".tr,
                            style: CustomTextStyles.bodyMedium15,
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgArrowRight,
                            height: 16.h,
                            width: 18.h,
                          )
                        ],
                      ),
                    )),
                SizedBox(height: 16.h),
                GestureDetector(
                    onTap: () {
                      controller.goK0screen();
                    },
                    child: Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(horizontal: 8.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "lbl".tr,
                            style: CustomTextStyles.bodyMedium15,
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgArrowRight,
                            height: 16.h,
                            width: 18.h,
                          )
                        ],
                      ),
                    )),
                SizedBox(height: 16.h)
              ],
            ),
          ),
          CustomOutlinedButton(
            text: "lbl196".tr,
            buttonTextStyle: CustomTextStyles.titleMediumPrimary,
            onPressed: () async {
              controller.showThree2Dialog();
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
