import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k2_controller.dart'; // ignore_for_file: must_be_immutable

/// 登入/註冊頁
class K2Screen extends GetWidget<K2Controller> {
  const K2Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.maxFinite,
        height: SizeUtils.height,
        decoration: AppDecoration.gradientLightBlueToOnErrorContainer,
        child: SafeArea(
          child: Container(
            height: 768.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 768.h,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(vertical: 122.h),
                          decoration: AppDecoration.column3,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 4.h),
                              Container(
                                width: 240.h,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 50.h,
                                  vertical: 56.h,
                                ),
                                decoration: AppDecoration.column4,
                                child: Column(
                                  spacing: 24,
                                  children: [
                                    CustomImageView(
                                      imagePath: ImageConstant.imgMusic,
                                      height: 42.h,
                                      width: 44.h,
                                    ),
                                    Text(
                                      "msg4".tr,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: CustomTextStyles.bodyMedium15
                                          .copyWith(
                                        height: 1.70,
                                      ),
                                    ),
                                    SizedBox(height: 24.h)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      _buildColumn()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumn() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 22.h,
        right: 26.h,
        bottom: 162.h,
      ),
      child: Column(
        spacing: 20,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomElevatedButton(
            height: 58.h,
            text: "lbl10".tr,
            buttonStyle: CustomButtonStyles.none,
            decoration: CustomButtonStyles.gradientCyanToGrayDecoration,
            onPressed: () {
              controller.goOne2Screen();
            },
          ),
          CustomElevatedButton(
            height: 58.h,
            text: "lbl11".tr,
            buttonStyle: CustomButtonStyles.fillWhiteA,
            onPressed: () {
              controller.goOneScreen();
            },
          )
        ],
      ),
    );
  }
}
