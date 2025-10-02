import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_switch.dart';
import 'controller/ios_controller.dart';

// ignore_for_file: must_be_immutable
/// 藍芽設定dialog
class IosDialog extends StatelessWidget {
  IosDialog(this.controller, {Key? key})
      : super(
          key: key,
        );

  IosController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 24.h,
            vertical: 26.h,
          ),
          decoration: AppDecoration.fillWhiteA.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgClosePrimarycontainer,
                height: 10.h,
                width: 12.h,
                alignment: Alignment.centerRight,
                onTap: () {
                  onTapImgCloseone();
                },
              ),
              SizedBox(height: 10.h),
              Container(
                height: 138.h,
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 46.h),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(horizontal: 10.h),
                      padding: EdgeInsets.symmetric(horizontal: 18.h),
                      decoration: AppDecoration.gray600.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h),
                          Text(
                            "lbl_settings".tr,
                            style: CustomTextStyles.bodySmallBluegray200,
                          ),
                          SizedBox(height: 50.h),
                          CustomImageView(
                            imagePath: ImageConstant.img01,
                            height: 30.h,
                            width: double.maxFinite,
                          ),
                          SizedBox(height: 8.h),
                          SizedBox(
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                Container(
                                  height: 16.h,
                                  width: 22.h,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.onPrimaryContainer
                                        .withValues(
                                      alpha: 0.24,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      10.h,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 10.h,
                                      width: 102.h,
                                      decoration: BoxDecoration(
                                        color: theme
                                            .colorScheme.onPrimaryContainer
                                            .withValues(
                                          alpha: 0.24,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          4.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
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
                                child: Container(
                                  margin: EdgeInsets.only(top: 36.h),
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  decoration:
                                      AppDecoration.outlineGrayC.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder8,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomIconButton(
                                        height: 22.h,
                                        width: 22.h,
                                        padding: EdgeInsets.all(6.h),
                                        decoration: IconButtonStyleHelper.none,
                                        child: CustomImageView(
                                          imagePath: ImageConstant.img,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 6.h),
                                        child: Text(
                                          "lbl_bluetooth".tr,
                                          style: CustomTextStyles
                                              .labelMediumBlack900,
                                        ),
                                      ),
                                      Spacer(),
                                      Obx(
                                        () => CustomSwitch(
                                          value:
                                              controller.isSelectedSwitch.value,
                                          onChange: (value) {
                                            controller.isSelectedSwitch.value =
                                                value;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 26.h),
              Text(
                "lbl_openbluetoolth".tr,
                style:
                    CustomTextStyles.titleMediumManropePrimaryContainerSemiBold,
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.h),
                child: Text(
                  "msg_pulsering2".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodyMediumManropePrimaryContainer
                      .copyWith(
                    height: 1.43,
                  ),
                ),
              ),
              SizedBox(height: 46.h),
              CustomElevatedButton(
                height: 56.h,
                text: "lbl34".tr,
                buttonStyle: CustomButtonStyles.none,
                decoration:
                    CustomButtonStyles.gradientCyanToPrimaryTL8Decoration,
                buttonTextStyle: CustomTextStyles.titleMediumManrope,
                onPressed: () async {
                  await openAppSettings();
                },
              )
            ],
          ),
        )
      ],
    );
  }

  /// Navigates to the previous screen.
  onTapImgCloseone() {
    Get.back();
  }
}
