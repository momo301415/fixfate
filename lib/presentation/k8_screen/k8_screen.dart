import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k8_controller.dart';
import 'models/listviewsection_item_model.dart';
import 'models/listweightvalue_item_model.dart';
import 'models/weight_analysis_model.dart';
import 'widgets/listviewsection_item_widget.dart';
import 'widgets/listweightvalue_item_widget.dart';
import 'widgets/weight_analysis_widget.dart'; // ignore_for_file: must_be_immutable

class K8Screen extends GetWidget<K8Controller> {
  const K8Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.teal50,
      body: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Container(
        
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // _buildHeaderSection(),
                Container(
                  width: double.maxFinite,
                
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(right: 16.h),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.h,
                          vertical: 16.h,
                        ),
                        decoration: AppDecoration.fillWhiteA.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder8,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 10.h),
                            WeightAnalysisWidget(
                              data: WeightAnalysisModel(
                                weight: 77.2,
                                bmi: 24.3,
                                bodyFat: 17.9,
                                bodyWater: 43.4,
                                protein: 11.7,
                                mineral: 4.2,
                                updateTime: "8:30更新",
                              ),
                              outerRadius: 70.0,
                              strokeWidth: 15.0,
                            ),
                            SizedBox(height: 30.h),
                            _buildTabViewSection(),
                            SizedBox(height: 12.h),
                            Container(
                              width: double.maxFinite,
                              margin: EdgeInsets.symmetric(horizontal: 8.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomImageView(
                                    imagePath:
                                        ImageConstant
                                            .imgArrowDownPrimarycontainer1,
                                    height: 18.h,
                                    width: 18.h,
                                  ),
                                  Spacer(flex: 50),
                                  Text(
                                    "lbl_8_222".tr,
                                    style:
                                        CustomTextStyles
                                            .bodyMediumPrimaryContainer15_1,
                                  ),
                                  CustomImageView(
                                    imagePath: ImageConstant.imgForward,
                                    height: 6.h,
                                    width: 12.h,
                                    radius: BorderRadius.circular(1.h),
                                    margin: EdgeInsets.only(left: 10.h),
                                  ),
                                  Spacer(flex: 50),
                                  CustomImageView(
                                    imagePath:
                                        ImageConstant
                                            .imgArrowRightPrimarycontainer1,
                                    height: 18.h,
                                    width: 18.h,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            _buildWeightRowSection(),
                            _buildWeightStackSection(),
                            Container(
                              width: double.maxFinite,
                              margin: EdgeInsets.only(left: 16.h),
                              child: _buildTimeRow(
                                timeThree: "lbl_22_00".tr,
                                timeFour: "lbl_08_00".tr,
                                timeFive: "lbl_23_00".tr,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            _buildBodyFatRowSection(),
                            _buildBodyFatStackSection(),
                            Container(
                              width: double.maxFinite,
                              margin: EdgeInsets.only(left: 16.h),
                              child: _buildTimeRow(
                                timeThree: "lbl_22_00".tr,
                                timeFour: "lbl_08_00".tr,
                                timeFive: "lbl_23_00".tr,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            SizedBox(
                              width: double.maxFinite,
                              child: _buildMuscleDistribution(
                                one: "lbl369".tr,
                                kgTwo: "lbl_kg".tr,
                                leftArmMass: "lbl370".tr,
                                rightArmMass: "lbl371".tr,
                                trunkMass: "lbl372".tr,
                                leftLegMass: "lbl373".tr,
                                rightLegMass: "lbl374".tr,
                              ),
                            ),
                            _buildRowTenSection(),
                            _buildRowEightSection(),
                            _buildRowSixSection(),
                            _buildRowFourSection(),
                            _buildRowSixtySection(),
                            _buildRowZeroSection(),
                            Container(
                              width: double.maxFinite,
                              margin: EdgeInsets.only(left: 16.h),
                              child: _buildTimeRow(
                                timeThree: "lbl_22_00".tr,
                                timeFour: "lbl_08_00".tr,
                                timeFive: "lbl_23_00".tr,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            SizedBox(
                              width: double.maxFinite,
                              child: _buildMuscleDistribution(
                                one: "lbl375".tr,
                                kgTwo: "lbl_kg".tr,
                                leftArmMass: "lbl370".tr,
                                rightArmMass: "lbl371".tr,
                                trunkMass: "lbl372".tr,
                                leftLegMass: "lbl373".tr,
                                rightLegMass: "lbl374".tr,
                              ),
                            ),
                            _buildRowTwentyfiveSection(),
                            _buildRowTwentySection(),
                            _buildRowFifteenSection(),
                            _buildRowTenSection1(),
                            _buildRowSixtySection1(),
                            _buildRowZeroSection1(),
                            Container(
                              width: double.maxFinite,
                              margin: EdgeInsets.only(left: 16.h),
                              child: _buildTimeRow(
                                timeThree: "lbl_22_00".tr,
                                timeFour: "lbl_08_00".tr,
                                timeFive: "lbl_23_00".tr,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildWeightValueColumnSection(),
                      SizedBox(height: 8.h),
                      _buildWeightColumnSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  

  /// Section Widget
  // Widget _buildHorizontalScrollSection() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: IntrinsicWidth(
  //       child: SizedBox(
  //         width: 542.h,
  //         child: Row(
  //           children: [
  //             Expanded(
  //               child: Container(
  //                 width: double.maxFinite,
  //                 padding: EdgeInsets.symmetric(vertical: 8.h),
  //                 decoration: AppDecoration.fillTealF.copyWith(
  //                   borderRadius: BorderRadiusStyle.roundedBorder8,
  //                 ),
  //                 child: Column(
  //                   spacing: 4,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     CustomImageView(
  //                       imagePath: ImageConstant.imgFavoriteWhiteA7001,
  //                       height: 20.h,
  //                       width: 22.h,
  //                     ),
  //                     Text(
  //                       "lbl171".tr,
  //                       style: CustomTextStyles.bodySmallWhiteA700_1,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Container(
  //                 width: double.maxFinite,
  //                 margin: EdgeInsets.only(left: 6.h),
  //                 padding: EdgeInsets.symmetric(vertical: 8.h),
  //                 decoration: AppDecoration.fillTeal2007f02.copyWith(
  //                   borderRadius: BorderRadiusStyle.roundedBorder8,
  //                 ),
  //                 child: Column(
  //                   spacing: 4,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     CustomImageView(
  //                       imagePath: ImageConstant.imgUserWhiteA7001,
  //                       height: 20.h,
  //                       width: 22.h,
  //                     ),
  //                     Text(
  //                       "lbl172".tr,
  //                       style: CustomTextStyles.bodySmallWhiteA700_1,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Container(
  //                 width: double.maxFinite,
  //                 margin: EdgeInsets.only(left: 6.h),
  //                 padding: EdgeInsets.symmetric(vertical: 8.h),
  //                 decoration: AppDecoration.fillTeal2007f02.copyWith(
  //                   borderRadius: BorderRadiusStyle.roundedBorder8,
  //                 ),
  //                 child: Column(
  //                   spacing: 4,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     CustomImageView(
  //                       imagePath: ImageConstant.imgUserWhiteA7001,
  //                       height: 20.h,
  //                       width: 22.h,
  //                     ),
  //                     Text(
  //                       "lbl172".tr,
  //                       style: CustomTextStyles.bodySmallWhiteA700_1,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Container(
  //                 width: double.maxFinite,
  //                 margin: EdgeInsets.only(left: 6.h),
  //                 padding: EdgeInsets.symmetric(vertical: 8.h),
  //                 decoration: AppDecoration.fillTeal2007f02.copyWith(
  //                   borderRadius: BorderRadiusStyle.roundedBorder8,
  //                 ),
  //                 child: Column(
  //                   spacing: 4,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     CustomImageView(
  //                       imagePath: ImageConstant.imgLocation,
  //                       height: 20.h,
  //                       width: 22.h,
  //                     ),
  //                     Text(
  //                       "lbl404".tr,
  //                       style: CustomTextStyles.bodySmallWhiteA700_1,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Container(
  //                 width: double.maxFinite,
  //                 margin: EdgeInsets.only(left: 6.h),
  //                 padding: EdgeInsets.symmetric(vertical: 8.h),
  //                 decoration: AppDecoration.fillTeal2007f02.copyWith(
  //                   borderRadius: BorderRadiusStyle.roundedBorder8,
  //                 ),
  //                 child: Column(
  //                   spacing: 4,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     CustomImageView(
  //                       imagePath: ImageConstant.imgCheckmark,
  //                       height: 20.h,
  //                       width: 22.h,
  //                     ),
  //                     Text(
  //                       "lbl217".tr,
  //                       style: CustomTextStyles.bodySmallWhiteA700_1,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Container(
  //                 width: double.maxFinite,
  //                 margin: EdgeInsets.only(left: 6.h),
  //                 padding: EdgeInsets.symmetric(vertical: 8.h),
  //                 decoration: AppDecoration.fillBlueGray.copyWith(
  //                   borderRadius: BorderRadiusStyle.roundedBorder8,
  //                 ),
  //                 child: Column(
  //                   spacing: 4,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     CustomImageView(
  //                       imagePath: ImageConstant.imgFiSrHourglass,
  //                       height: 20.h,
  //                       width: 22.h,
  //                     ),
  //                     Text(
  //                       "lbl79".tr,
  //                       style: CustomTextStyles.bodySmallWhiteA700_1,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Container(
  //                 width: double.maxFinite,
  //                 margin: EdgeInsets.only(left: 6.h),
  //                 padding: EdgeInsets.symmetric(vertical: 8.h),
  //                 decoration: AppDecoration.fillTeal2007f02.copyWith(
  //                   borderRadius: BorderRadiusStyle.roundedBorder8,
  //                 ),
  //                 child: Column(
  //                   spacing: 4,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     CustomImageView(
  //                       imagePath: ImageConstant.imgTelevisionWhiteA700,
  //                       height: 20.h,
  //                       width: 22.h,
  //                     ),
  //                     Text(
  //                       "lbl218".tr,
  //                       textAlign: TextAlign.center,
  //                       style: CustomTextStyles.bodySmallWhiteA700_1,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Container(
  //                 width: double.maxFinite,
  //                 margin: EdgeInsets.only(left: 6.h),
  //                 padding: EdgeInsets.symmetric(vertical: 8.h),
  //                 decoration: AppDecoration.fillTeal2007f02.copyWith(
  //                   borderRadius: BorderRadiusStyle.roundedBorder8,
  //                 ),
  //                 child: Column(
  //                   spacing: 4,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     CustomImageView(
  //                       imagePath: ImageConstant.imgIconWhiteA7001,
  //                       height: 20.h,
  //                       width: 22.h,
  //                     ),
  //                     Text(
  //                       "lbl219".tr,
  //                       textAlign: TextAlign.center,
  //                       style: CustomTextStyles.bodySmallWhiteA700_1,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Container(
  //                 width: double.maxFinite,
  //                 margin: EdgeInsets.only(left: 6.h),
  //                 padding: EdgeInsets.symmetric(vertical: 8.h),
  //                 decoration: AppDecoration.fillTeal2007f02.copyWith(
  //                   borderRadius: BorderRadiusStyle.roundedBorder8,
  //                 ),
  //                 child: Column(
  //                   spacing: 4,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     CustomImageView(
  //                       imagePath: ImageConstant.imgFavoriteWhiteA7001,
  //                       height: 18.h,
  //                       width: 22.h,
  //                     ),
  //                     Text(
  //                       "lbl171".tr,
  //                       textAlign: TextAlign.center,
  //                       style: CustomTextStyles.bodySmallWhiteA700_1,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Container(
  //                 width: double.maxFinite,
  //                 margin: EdgeInsets.only(left: 6.h),
  //                 padding: EdgeInsets.symmetric(vertical: 8.h),
  //                 decoration: AppDecoration.fillTeal2007f021.copyWith(
  //                   borderRadius: BorderRadiusStyle.roundedBorder8,
  //                 ),
  //                 child: Column(
  //                   spacing: 4,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     CustomImageView(
  //                       imagePath: ImageConstant.imgFavoriteWhiteA7001,
  //                       height: 18.h,
  //                       width: 22.h,
  //                     ),
  //                     Text(
  //                       "lbl171".tr,
  //                       textAlign: TextAlign.center,
  //                       style: CustomTextStyles.bodySmallWhiteA700_1,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }



  /// Section Widget
  Widget _buildTabViewSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 4.h),
          decoration: AppDecoration.fillPrimary.copyWith(
            borderRadius: BorderRadiusStyle.customBorderTL4,
          ),
          child: Text(
            "lbl229".tr,
            textAlign: TextAlign.center,
            style: CustomTextStyles.bodySmallWhiteA700_1,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 4.h),
          decoration: AppDecoration.gray100,
          child: Text(
            "lbl230".tr,
            textAlign: TextAlign.center,
            style: CustomTextStyles.bodySmallErrorContainer_1,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 4.h),
          decoration: AppDecoration.gray100.copyWith(
            borderRadius: BorderRadiusStyle.customBorderLR4,
          ),
          child: Text(
            "lbl231".tr,
            textAlign: TextAlign.center,
            style: CustomTextStyles.bodySmallErrorContainer_1,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildWeightRowSection() {
    return Container(
      decoration: AppDecoration.fillWhiteA,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("lbl79".tr, style: CustomTextStyles.labelMediumPrimary_1),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: Text(
                "lbl_kg".tr,
                style: CustomTextStyles.pingFangTC3Primary,
              ),
            ),
          ),
          Spacer(),
          Container(
            height: 2.h,
            width: 6.h,
            decoration: BoxDecoration(color: appTheme.amber3007f),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "lbl366".tr,
              style: CustomTextStyles.bodySmallErrorContainer10_1,
            ),
          ),
          Container(
            height: 2.h,
            width: 6.h,
            margin: EdgeInsets.only(left: 16.h),
            decoration: BoxDecoration(color: appTheme.tealA7007f),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "lbl367".tr,
              style: CustomTextStyles.bodySmallErrorContainer10_1,
            ),
          ),
          Container(
            height: 2.h,
            width: 6.h,
            margin: EdgeInsets.only(left: 16.h),
            decoration: BoxDecoration(color: appTheme.pink3007f),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "lbl285".tr,
              style: CustomTextStyles.bodySmallErrorContainer10_1,
            ),
          ),
          Container(
            height: 2.h,
            width: 6.h,
            margin: EdgeInsets.only(left: 16.h),
            decoration: BoxDecoration(color: appTheme.redA4007f),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "lbl286".tr,
              style: CustomTextStyles.bodySmallErrorContainer10_1,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildWeightStackSection() {
    return SizedBox(
      height: 78.h,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.center,
        children: [
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "lbl_1102".tr,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "lbl_902".tr,
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "lbl_702".tr,
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
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "lbl_502".tr,
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "lbl_302".tr,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 16.h,
              width: 294.h,
              margin: EdgeInsets.only(top: 4.h),
              decoration: BoxDecoration(
                color: appTheme.redA4007f.withValues(alpha: 0.2),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 16.h,
              width: 294.h,
              margin: EdgeInsets.only(top: 22.h),
              decoration: BoxDecoration(
                color: appTheme.pink3007f.withValues(alpha: 0.2),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(left: 14.h, bottom: 22.h),
              padding: EdgeInsets.only(left: 62.h),
              decoration: AppDecoration.fillTealAF,
              child: Column(
                spacing: 6,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 4.h,
                      width: 4.h,
                      margin: EdgeInsets.only(right: 12.h),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(2.h),
                      ),
                    ),
                  ),
                  Container(
                    height: 4.h,
                    width: 4.h,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(2.h),
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 16.h,
              width: 294.h,
              margin: EdgeInsets.only(bottom: 6.h),
              decoration: BoxDecoration(
                color: appTheme.amber3007f.withValues(alpha: 0.2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBodyFatRowSection() {
    return Container(
      decoration: AppDecoration.fillWhiteA,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("lbl368".tr, style: CustomTextStyles.labelMediumPrimary_1),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: Text(
                "lbl182".tr,
                style: CustomTextStyles.pingFangTC3Primary,
              ),
            ),
          ),
          Spacer(),
          Container(
            height: 2.h,
            width: 6.h,
            decoration: BoxDecoration(color: appTheme.orange1007f),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "lbl366".tr,
              style: CustomTextStyles.bodySmallErrorContainer10_1,
            ),
          ),
          Container(
            height: 2.h,
            width: 6.h,
            margin: EdgeInsets.only(left: 16.h),
            decoration: BoxDecoration(color: appTheme.amber3007f),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "lbl284".tr,
              style: CustomTextStyles.bodySmallErrorContainer10_1,
            ),
          ),
          Container(
            height: 2.h,
            width: 6.h,
            margin: EdgeInsets.only(left: 16.h),
            decoration: BoxDecoration(color: appTheme.tealA7007f),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "lbl367".tr,
              style: CustomTextStyles.bodySmallErrorContainer10_1,
            ),
          ),
          Container(
            height: 2.h,
            width: 6.h,
            margin: EdgeInsets.only(left: 16.h),
            decoration: BoxDecoration(color: appTheme.pink3007f),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "lbl285".tr,
              style: CustomTextStyles.bodySmallErrorContainer10_1,
            ),
          ),
          Container(
            height: 2.h,
            width: 6.h,
            margin: EdgeInsets.only(left: 16.h),
            decoration: BoxDecoration(color: appTheme.redA4007f),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "lbl286".tr,
              style: CustomTextStyles.bodySmallErrorContainer10_1,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBodyFatStackSection() {
    return Container(
      height: 78.h,
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 4.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "lbl_352".tr,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                      child: Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "lbl_302".tr,
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                      child: Padding(
                        padding: EdgeInsets.only(top: 26.h),
                        child: Row(
                          children: [
                            Text(
                              "lbl_252".tr,
                              style: CustomTextStyles.bodySmallGray5008,
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Column(
                                  spacing: 2,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: Divider(indent: 2.h),
                                    ),
                                    Container(
                                      height: 4.h,
                                      width: 4.h,
                                      margin: EdgeInsets.only(right: 76.h),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary,
                                        borderRadius: BorderRadius.circular(
                                          2.h,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 26.h),
                        child: Row(
                          children: [
                            Text(
                              "lbl_202".tr,
                              style: CustomTextStyles.bodySmallGray5008,
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: Divider(indent: 2.h),
                                    ),
                                    Container(
                                      height: 4.h,
                                      width: 4.h,
                                      margin: EdgeInsets.only(left: 66.h),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary,
                                        borderRadius: BorderRadius.circular(
                                          2.h,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "lbl_152".tr,
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "lbl_102".tr,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 12.h,
              width: 294.h,
              margin: EdgeInsets.only(top: 6.h),
              decoration: BoxDecoration(
                color: appTheme.redA4007f.withValues(alpha: 0.2),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 12.h,
              width: 294.h,
              margin: EdgeInsets.only(top: 18.h),
              decoration: BoxDecoration(
                color: appTheme.pink3007f.withValues(alpha: 0.2),
              ),
            ),
          ),
          Container(
            height: 12.h,
            width: 294.h,
            decoration: BoxDecoration(
              color: appTheme.tealA7007f.withValues(alpha: 0.2),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 12.h,
              width: 294.h,
              margin: EdgeInsets.only(bottom: 18.h),
              decoration: BoxDecoration(
                color: appTheme.amber3007f.withValues(alpha: 0.2),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 12.h,
              width: 294.h,
              margin: EdgeInsets.only(bottom: 6.h),
              decoration: BoxDecoration(color: appTheme.orange10033),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowTenSection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("lbl_102".tr, style: CustomTextStyles.bodySmallGray5008),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Divider(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowEightSection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("lbl_83".tr, style: CustomTextStyles.bodySmallGray5008),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Divider(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowSixSection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("lbl_62".tr, style: CustomTextStyles.bodySmallGray5008),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Divider(indent: 4.h),
                  ),
                  Container(
                    height: 4.h,
                    width: 4.h,
                    margin: EdgeInsets.only(right: 76.h),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(2.h),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowFourSection() {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 6.h),
            child: Text("lbl_42".tr, style: CustomTextStyles.bodySmallGray5008),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Divider(indent: 4.h),
                  ),
                  Container(
                    height: 4.h,
                    width: 4.h,
                    margin: EdgeInsets.only(left: 66.h),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(2.h),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowSixtySection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("lbl_22".tr, style: CustomTextStyles.bodySmallGray5008),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Divider(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowZeroSection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("lbl_0".tr, style: CustomTextStyles.bodySmallGray5008),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Divider(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowTwentyfiveSection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("lbl_252".tr, style: CustomTextStyles.bodySmallGray5008),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Divider(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowTwentySection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("lbl_202".tr, style: CustomTextStyles.bodySmallGray5008),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Divider(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowFifteenSection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("lbl_152".tr, style: CustomTextStyles.bodySmallGray5008),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Divider(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowTenSection1() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "lbl_102".tr,
              style: CustomTextStyles.bodySmallGray5008,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 4.h,
                    width: 4.h,
                    margin: EdgeInsets.only(right: 76.h),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(2.h),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                SizedBox(width: double.maxFinite, child: Divider(indent: 4.h)),
                Container(
                  height: 4.h,
                  width: 4.h,
                  margin: EdgeInsets.only(left: 66.h),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(2.h),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowSixtySection1() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("lbl_52".tr, style: CustomTextStyles.bodySmallGray5008),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Divider(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowZeroSection1() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("lbl_0".tr, style: CustomTextStyles.bodySmallGray5008),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Divider(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildWeightValueColumnSection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 26.h, vertical: 10.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 42.h,
            width: double.maxFinite,
            child: Obx(
              () => ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13.0.h),
                    child: VerticalDivider(
                      width: 1.h,
                      thickness: 1.h,
                      color: appTheme.blueGray10001,
                    ),
                  );
                },
                itemCount:
                    controller
                        .k8ModelObj
                        .value
                        .listweightvalueItemList
                        .value
                        .length,
                itemBuilder: (context, index) {
                  ListweightvalueItemModel model =
                      controller
                          .k8ModelObj
                          .value
                          .listweightvalueItemList
                          .value[index];
                  return ListweightvalueItemWidget(model);
                },
              ),
            ),
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildWeightColumnSection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 16.h),
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    height: 24.h,
                    text: "lbl79".tr,
                    buttonStyle: CustomButtonStyles.fillGrayTL4,
                    buttonTextStyle: theme.textTheme.bodySmall!,
                  ),
                ),
                Expanded(
                  child: CustomElevatedButton(
                    height: 24.h,
                    text: "lbl368".tr,
                    buttonStyle: CustomButtonStyles.fillPrimaryLR4,
                    buttonTextStyle: CustomTextStyles.bodySmallWhiteA700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.fromLTRB(8.h, 12.h, 8.h, 10.h),
            decoration: AppDecoration.outlineGray200,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 18.h),
                  child: Text(
                    "lbl_23_22".tr,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Text(
                  "msg_2025_03_29_11_23".tr,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.h, 12.h, 8.h, 10.h),
            decoration: AppDecoration.outlineGray200,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 18.h),
                  child: Text(
                    "lbl_23_22".tr,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Text(
                  "msg_2025_03_29_11_23".tr,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.h, 12.h, 8.h, 10.h),
            decoration: AppDecoration.outlineGray200,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 18.h),
                  child: Text(
                    "lbl_23_22".tr,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Text(
                  "msg_2025_03_29_11_23".tr,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.h, 12.h, 8.h, 10.h),
            decoration: AppDecoration.outlineGray200,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 18.h),
                  child: Text(
                    "lbl_23_22".tr,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Text(
                  "msg_2025_03_29_11_23".tr,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.h, 12.h, 8.h, 10.h),
            decoration: AppDecoration.outlineGray200,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 18.h),
                  child: Text(
                    "lbl_23_22".tr,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Text(
                  "msg_2025_03_29_11_23".tr,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 18.h),
                  child: Text(
                    "lbl_23_22".tr,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Text(
                  "msg_2025_03_29_11_23".tr,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildTimeRow({
    required String timeThree,
    required String timeFour,
    required String timeFive,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          timeThree,
          style: CustomTextStyles.bodySmallGray50010.copyWith(
            color: appTheme.gray500,
          ),
        ),
        Text(
          timeFour,
          style: CustomTextStyles.bodySmallGray50010.copyWith(
            color: appTheme.gray500,
          ),
        ),
        Text(
          timeFive,
          style: CustomTextStyles.bodySmallGray50010.copyWith(
            color: appTheme.gray500,
          ),
        ),
      ],
    );
  }

  /// Common widget
  Widget _buildMuscleDistribution({
    required String one,
    required String kgTwo,
    required String leftArmMass,
    required String rightArmMass,
    required String trunkMass,
    required String leftLegMass,
    required String rightLegMass,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            one,
            style: CustomTextStyles.labelMediumPrimary_1.copyWith(
              color: theme.colorScheme.primary.withValues(alpha: 0.8),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: Text(
                kgTwo,
                style: CustomTextStyles.pingFangTC3Primary.copyWith(
                  color: theme.colorScheme.primary.withValues(alpha: 0.8),
                ),
              ),
            ),
          ),
          Spacer(),
          Text(
            leftArmMass,
            style: CustomTextStyles.bodySmallPrimary10.copyWith(
              color: theme.colorScheme.primary.withValues(alpha: 0.8),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              rightArmMass,
              style: CustomTextStyles.bodySmallGray50010_1.copyWith(
                color: appTheme.gray500.withValues(alpha: 0.8),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              trunkMass,
              style: CustomTextStyles.bodySmallGray50010_1.copyWith(
                color: appTheme.gray500.withValues(alpha: 0.8),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              leftLegMass,
              style: CustomTextStyles.bodySmallGray50010_1.copyWith(
                color: appTheme.gray500.withValues(alpha: 0.8),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.h, right: 6.h),
            child: Text(
              rightLegMass,
              style: CustomTextStyles.bodySmallGray50010_1.copyWith(
                color: appTheme.gray500.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapImgArrowleftone() {
    Get.back();
  }
}
