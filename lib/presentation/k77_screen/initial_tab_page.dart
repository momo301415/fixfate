import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k77_controller.dart';
import 'models/initial_tab_model.dart';

// ignore_for_file: must_be_immutable
class InitialTabPage extends StatelessWidget {
  InitialTabPage({Key? key})
      : super(
          key: key,
        );

  K77Controller controller = Get.put(K77Controller());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: 342.h,
                margin: EdgeInsets.only(top: 12.h),
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
                            "lbl_8_222".tr,
                            style:
                                CustomTextStyles.bodyMediumPrimaryContainer15_1,
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgForward,
                            height: 6.h,
                            width: 12.h,
                            radius: BorderRadius.circular(
                              1.h,
                            ),
                            margin: EdgeInsets.only(left: 10.h),
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
                    Container(
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
                    ),
                    Container(
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
                    ),
                    Container(
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
                                        style:
                                            CustomTextStyles.bodySmallGray5008,
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 4.h),
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
                                        style:
                                            CustomTextStyles.bodySmallGray5008,
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 4.h),
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
                                        style:
                                            CustomTextStyles.bodySmallGray5008,
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 4.h),
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
                    ),
                    Container(
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
                    ),
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                        left: 30.h,
                        right: 16.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "lbl_22_00".tr,
                            style: CustomTextStyles.bodySmallGray50010,
                          ),
                          Text(
                            "lbl_08_00".tr,
                            style: CustomTextStyles.bodySmallGray50010,
                          ),
                          Text(
                            "lbl_23_00".tr,
                            style: CustomTextStyles.bodySmallGray50010,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Container(
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
                                                    style: theme
                                                        .textTheme.titleLarge,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 6.h),
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
                                    three: "lbl177".tr,
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "lbl_1202".tr,
                                                      style: theme
                                                          .textTheme.titleLarge,
                                                    ),
                                                    Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 6.h),
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
                                      three: "lbl177".tr,
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
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.h,
                        vertical: 14.h,
                      ),
                      decoration: AppDecoration.fillWhiteA.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: Column(
                        spacing: 4,
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
                                    buttonStyle:
                                        CustomButtonStyles.fillPrimaryTL4,
                                    buttonTextStyle:
                                        CustomTextStyles.bodySmallWhiteA700_1,
                                  ),
                                ),
                                Expanded(
                                  child: CustomElevatedButton(
                                    height: 24.h,
                                    text: "lbl239".tr,
                                    buttonStyle: CustomButtonStyles.fillGrayLR4,
                                    buttonTextStyle: CustomTextStyles
                                        .bodySmallErrorContainer_1,
                                  ),
                                )
                              ],
                            ),
                          ),
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
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildStacktwentyfour1({
    required String twentyfourFive,
    required String three,
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
                            three,
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
}
