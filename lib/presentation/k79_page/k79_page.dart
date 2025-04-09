import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k79_controller.dart';
import 'models/k79_model.dart';

// ignore_for_file: must_be_immutable
class K79Page extends StatelessWidget {
  K79Page({Key? key})
      : super(
          key: key,
        );

  K79Controller controller = Get.put(K79Controller(K79Model().obs));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: double.maxFinite,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: 342.h,
                    child: Column(
                      children: [
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(horizontal: 22.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomImageView(
                                imagePath:
                                    ImageConstant.imgArrowDownPrimarycontainer,
                                height: 18.h,
                                width: 18.h,
                              ),
                              Spacer(
                                flex: 50,
                              ),
                              Text(
                                "lbl_2025_8".tr,
                                style: CustomTextStyles
                                    .bodyMediumPrimaryContainer15_1,
                              ),
                              CustomImageView(
                                imagePath: ImageConstant.imgForward,
                                height: 6.h,
                                width: 12.h,
                                radius: BorderRadius.circular(
                                  1.h,
                                ),
                                margin: EdgeInsets.only(left: 12.h),
                              ),
                              Spacer(
                                flex: 49,
                              ),
                              CustomImageView(
                                imagePath:
                                    ImageConstant.imgArrowRightPrimarycontainer,
                                height: 18.h,
                                width: 18.h,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 14.h),
                        _buildRowonehundredfo(),
                        _buildRowonehundredtw(),
                        _buildStackonehundred(),
                        _buildRowforty(),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(
                            left: 30.h,
                            right: 24.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "lbl_13".tr,
                                style: CustomTextStyles.bodySmallGray50010,
                              ),
                              Text(
                                "lbl_52".tr,
                                style: CustomTextStyles.bodySmallGray50010,
                              ),
                              Text(
                                "lbl_102".tr,
                                style: CustomTextStyles.bodySmallGray50010,
                              ),
                              Text(
                                "lbl_152".tr,
                                style: CustomTextStyles.bodySmallGray50010,
                              ),
                              Text(
                                "lbl_202".tr,
                                style: CustomTextStyles.bodySmallGray50010,
                              ),
                              Text(
                                "lbl_252".tr,
                                style: CustomTextStyles.bodySmallGray50010,
                              ),
                              Text(
                                "lbl_302".tr,
                                style: CustomTextStyles.bodySmallGray50010,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        _buildColumntwentyfou(),
                        SizedBox(height: 8.h),
                        _buildColumn()
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
  Widget _buildRowonehundredfo() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "lbl_1402".tr,
            style: CustomTextStyles.bodySmallGray5008,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Divider(),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowonehundredtw() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "lbl_1202".tr,
            style: CustomTextStyles.bodySmallGray5008,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Divider(),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildStackonehundred() {
    return Container(
      height: 38.h,
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "lbl_1002".tr,
                        style: CustomTextStyles.bodySmallGray5008,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 4.h),
                            child: Divider(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(left: 2.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "lbl_80".tr,
                        style: CustomTextStyles.bodySmallGray5008,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 4.h),
                            child: Divider(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(left: 2.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "lbl_60".tr,
                        style: CustomTextStyles.bodySmallGray5008,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 4.h),
                            child: Divider(),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgLine1,
            height: 24.h,
            width: double.maxFinite,
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 4.h),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowforty() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 18.h,
        right: 16.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "lbl_402".tr,
            style: CustomTextStyles.bodySmallGray5008,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Divider(),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumntwentyfou() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 24.h,
        vertical: 8.h,
      ),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(
              left: 12.h,
              right: 18.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 44.h,
                  width: 42.h,
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "lbl_242".tr,
                                    style: theme.textTheme.titleLarge,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 6.h),
                                      child: Text(
                                        "lbl161".tr,
                                        style: CustomTextStyles
                                            .bodySmallBluegray40010,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 6.h),
                        child: Text(
                          "lbl232".tr,
                          style: theme.textTheme.bodySmall,
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: VerticalDivider(
                    width: 1.h,
                    thickness: 1.h,
                    color: appTheme.blueGray10001,
                    endIndent: 4.h,
                  ),
                ),
                _buildStacktwentyfour(
                  twentyfourTwo: "lbl_22".tr,
                  two: "lbl161".tr,
                  one: "lbl233".tr,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: VerticalDivider(
                    width: 1.h,
                    thickness: 1.h,
                    color: appTheme.blueGray10001,
                    endIndent: 4.h,
                  ),
                ),
                _buildStacktwentyfour(
                  twentyfourTwo: "lbl_13".tr,
                  two: "lbl161".tr,
                  one: "lbl234".tr,
                )
              ],
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _buildStacktwentyfour1(
                    twentyfourFive: "lbl_862".tr,
                    two: "lbl177".tr,
                    one: "lbl235".tr,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 24.h),
                    child: VerticalDivider(
                      width: 1.h,
                      thickness: 1.h,
                      color: appTheme.blueGray10001,
                      endIndent: 4.h,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 44.h,
                    margin: EdgeInsets.only(left: 16.h),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "lbl_1202".tr,
                                      style: theme.textTheme.titleLarge,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 6.h),
                                        child: Text(
                                          "lbl177".tr,
                                          style: CustomTextStyles
                                              .bodySmallBluegray40010,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          "lbl236".tr,
                          style: theme.textTheme.bodySmall,
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 18.h),
                    child: VerticalDivider(
                      width: 1.h,
                      thickness: 1.h,
                      color: appTheme.blueGray10001,
                      endIndent: 4.h,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 22.h),
                    child: _buildStacktwentyfour1(
                      twentyfourFive: "lbl_80".tr,
                      two: "lbl177".tr,
                      one: "lbl237".tr,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 6.h)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumn() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 14.h,
      ),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    height: 24.h,
                    text: "lbl238".tr,
                    buttonStyle: CustomButtonStyles.fillPrimaryTL4,
                    buttonTextStyle: CustomTextStyles.bodySmallWhiteA700_1,
                  ),
                ),
                Expanded(
                  child: CustomElevatedButton(
                    height: 24.h,
                    text: "lbl239".tr,
                    buttonStyle: CustomButtonStyles.fillGrayLR4,
                    buttonTextStyle: CustomTextStyles.bodySmallErrorContainer_1,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 4.h),
          SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 12.h,
                    bottom: 10.h,
                  ),
                  decoration: AppDecoration.outlineGray,
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "lbl155".tr,
                        style: theme.textTheme.bodyMedium,
                      ),
                      Spacer(
                        flex: 43,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "lbl_1502".tr,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      Spacer(
                        flex: 56,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "msg_2025_03_29_11_23".tr,
                          style: theme.textTheme.bodySmall,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 12.h,
                    bottom: 10.h,
                  ),
                  decoration: AppDecoration.outlineGray,
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "lbl155".tr,
                        style: theme.textTheme.bodyMedium,
                      ),
                      Spacer(
                        flex: 43,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "lbl_1502".tr,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      Spacer(
                        flex: 56,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "msg_2025_03_29_11_23".tr,
                          style: theme.textTheme.bodySmall,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 12.h,
                    bottom: 10.h,
                  ),
                  decoration: AppDecoration.outlineGray,
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "lbl155".tr,
                        style: theme.textTheme.bodyMedium,
                      ),
                      Spacer(
                        flex: 43,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "lbl_1502".tr,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      Spacer(
                        flex: 56,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "msg_2025_03_29_11_23".tr,
                          style: theme.textTheme.bodySmall,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 12.h,
                    bottom: 10.h,
                  ),
                  decoration: AppDecoration.outlineGray,
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "lbl155".tr,
                        style: theme.textTheme.bodyMedium,
                      ),
                      Spacer(
                        flex: 43,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "lbl_1502".tr,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      Spacer(
                        flex: 56,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "msg_2025_03_29_11_23".tr,
                          style: theme.textTheme.bodySmall,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 12.h,
                    bottom: 10.h,
                  ),
                  decoration: AppDecoration.outlineGray,
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "lbl155".tr,
                        style: theme.textTheme.bodyMedium,
                      ),
                      Spacer(
                        flex: 43,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "lbl_1502".tr,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      Spacer(
                        flex: 56,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "msg_2025_03_29_11_23".tr,
                          style: theme.textTheme.bodySmall,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.h, 12.h, 8.h, 10.h),
            decoration: AppDecoration.outlineGray,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "lbl155".tr,
                  style: theme.textTheme.bodyMedium,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "lbl_1502".tr,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "msg_2023_03_23_14_32".tr,
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodySmall,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.h, 12.h, 8.h, 10.h),
            decoration: AppDecoration.outlineGray,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "lbl155".tr,
                  style: theme.textTheme.bodyMedium,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "lbl_1502".tr,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "msg_2023_03_23_14_32".tr,
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodySmall,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildStacktwentyfour({
    required String twentyfourTwo,
    required String two,
    required String one,
  }) {
    return SizedBox(
      height: 44.h,
      width: 28.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        twentyfourTwo,
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: Text(
                            two,
                            style: CustomTextStyles.bodySmallBluegray40010
                                .copyWith(
                              color: appTheme.blueGray400,
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
          Text(
            one,
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.errorContainer,
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildStacktwentyfour1({
    required String twentyfourFive,
    required String two,
    required String one,
  }) {
    return SizedBox(
      height: 44.h,
      width: 64.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        twentyfourFive,
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: Text(
                            two,
                            style: CustomTextStyles.bodySmallBluegray40010
                                .copyWith(
                              color: appTheme.blueGray400,
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
          Text(
            one,
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.errorContainer,
            ),
          )
        ],
      ),
    );
  }
}
