import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k9_controller.dart'; // ignore_for_file: must_be_immutable

class K9Screen extends GetWidget<K9Controller> {
  const K9Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.whiteA700,
      appBar: _buildAppbar(),
      body: SafeArea(
        top: false,
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 6.h,
                vertical: 12.h,
              ),
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(left: 8.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "lbl".tr,
                                style: CustomTextStyles
                                    .titleLargePrimaryContainer22,
                              ),
                              SizedBox(height: 24.h),
                              Text(
                                "lbl2".tr,
                                style:
                                    CustomTextStyles.bodyMediumPrimaryContainer,
                              ),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.only(left: 6.h),
                                child: Text(
                                  "msg_app".tr,
                                  maxLines: 7,
                                  overflow: TextOverflow.ellipsis,
                                  style: CustomTextStyles.bodyMediumBluegray400
                                      .copyWith(
                                    height: 1.70,
                                  ),
                                ),
                              ),
                              SizedBox(height: 22.h),
                              Text(
                                "lbl3".tr,
                                style:
                                    CustomTextStyles.bodyMediumPrimaryContainer,
                              ),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.only(left: 6.h),
                                child: Text(
                                  "msg_app2".tr,
                                  maxLines: 8,
                                  overflow: TextOverflow.ellipsis,
                                  style: CustomTextStyles.bodyMediumBluegray400
                                      .copyWith(
                                    height: 1.70,
                                  ),
                                ),
                              ),
                              SizedBox(height: 22.h),
                              Text(
                                "lbl4".tr,
                                style:
                                    CustomTextStyles.bodyMediumPrimaryContainer,
                              ),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.only(left: 6.h),
                                child: Text(
                                  "msg".tr,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: CustomTextStyles.bodyMediumBluegray400
                                      .copyWith(
                                    height: 1.70,
                                  ),
                                ),
                              ),
                              SizedBox(height: 136.h),
                              Text(
                                "lbl4".tr,
                                style:
                                    CustomTextStyles.bodyMediumPrimaryContainer,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "msg".tr,
                                style: CustomTextStyles.bodyMediumBluegray400,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 594.h,
                          width: 4.h,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 34.h)
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildColumn(),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppbar() {
    return CustomAppBar(
      height: 56.h,
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgClose,
        margin: EdgeInsets.only(left: 24.h),
        onTap: () {
          onTapCloseone();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildColumn() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomElevatedButton(
            text: "lbl9".tr,
            margin: EdgeInsets.only(bottom: 12.h),
            buttonStyle: CustomButtonStyles.none,
            decoration: CustomButtonStyles.gradientCyanToPrimaryDecoration,
          )
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapCloseone() {
    Get.back();
  }
}
