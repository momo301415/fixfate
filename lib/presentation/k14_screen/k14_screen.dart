import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/k14_controller.dart';

// ignore_for_file: must_be_immutable
class K14Screen extends GetWidget<K14Controller> {
  K14Screen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.maxFinite,
        height: SizeUtils.height,
        decoration: AppDecoration.gradientLightBlueToOnErrorContainer,
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              height: 768.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 768.h,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgUnionWhiteA700,
                          height: 506.h,
                          width: double.maxFinite,
                        ),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(top: 28.h),
                          padding: EdgeInsets.symmetric(horizontal: 16.h),
                          child: Column(
                            spacing: 44,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 182.h,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.h,
                                  vertical: 56.h,
                                ),
                                decoration: AppDecoration.column15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 12.h),
                                      child: Text(
                                        "lbl40".tr,
                                        style: CustomTextStyles.titleLarge20,
                                      ),
                                    ),
                                    Text(
                                      "lbl41".tr,
                                      style:
                                          CustomTextStyles.bodySmallBluegray400,
                                    )
                                  ],
                                ),
                              ),
                              _buildColumnone()
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnone() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 24.h,
        vertical: 36.h,
      ),
      decoration: AppDecoration.gray50.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "lbl14".tr,
              style: CustomTextStyles.bodyMediumBluegray900,
            ),
          ),
          SizedBox(height: 16.h),
          CustomTextFormField(
            controller: controller.mobileNoController,
            hintText: "lbl_0934582915".tr,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.phone,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 14.h,
            ),
            validator: (value) {
              if (!isValidPhone(value)) {
                return "err_msg_please_enter_valid_phone_number".tr;
              }
              return null;
            },
          ),
          SizedBox(height: 48.h),
          CustomElevatedButton(
            height: 58.h,
            text: "lbl17".tr,
            buttonStyle: CustomButtonStyles.none,
            decoration: CustomButtonStyles.gradientCyanToPrimaryDecoration,
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgArrowDown,
                height: 16.h,
                width: 16.h,
              ),
              Text(
                "lbl42".tr,
                style: theme.textTheme.bodyMedium,
              )
            ],
          )
        ],
      ),
    );
  }
}
