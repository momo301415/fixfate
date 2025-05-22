import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../k78_page/k78_page.dart';
import '../k79_page/k79_page.dart';
import 'controller/k77_controller.dart';
import 'initial_tab_page.dart'; // ignore_for_file: must_be_immutable

/// 健康-心率頁面
class K77Screen extends GetWidget<K77Controller> {
  const K77Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
        title: "lbl243".tr,
        child: Container(
          height: 796.h,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [_buildHorizontalscrol()],
          ),
        ));
  }

  /// Section Widget
  Widget _buildHorizontalscrol() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: IntrinsicWidth(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            spacing: 16,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16.h,
              ),
              Expanded(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 344.h,
                        margin: EdgeInsets.only(left: 16.h),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.h,
                          vertical: 20.h,
                        ),
                        decoration: AppDecoration.fillWhiteA.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder8,
                        ),
                        child: Column(
                          spacing: 12,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: double.maxFinite,
                              margin: EdgeInsets.symmetric(horizontal: 8.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "lbl_782".tr,
                                      style: theme.textTheme.headlineLarge,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 4.h,
                                      bottom: 6.h,
                                    ),
                                    child: Text(
                                      "lbl177".tr,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 6.h),
                                    child: Text(
                                      "lbl_12".tr,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ),
                                  CustomElevatedButton(
                                    height: 24.h,
                                    width: 48.h,
                                    text: "lbl216".tr,
                                    margin: EdgeInsets.only(
                                      left: 16.h,
                                      bottom: 2.h,
                                    ),
                                    buttonStyle: CustomButtonStyles.fillYellow,
                                    buttonTextStyle: CustomTextStyles
                                        .labelLargePrimaryContainer,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: appTheme.gray200,
                                borderRadius: BorderRadius.circular(
                                  4.h,
                                ),
                              ),
                              width: double.maxFinite,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  4.h,
                                ),
                                child: TabBar(
                                  controller: controller.tabviewController,
                                  labelPadding: EdgeInsets.zero,
                                  labelColor: appTheme.whiteA700,
                                  labelStyle: TextStyle(
                                    fontSize: 12.fSize,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  unselectedLabelColor: theme
                                      .colorScheme.errorContainer
                                      .withValues(
                                    alpha: 0.85,
                                  ),
                                  unselectedLabelStyle: TextStyle(
                                    fontSize: 12.fSize,
                                    fontFamily: 'PingFang TC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicator: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                  ),
                                  dividerHeight: 0.0,
                                  tabs: [
                                    Tab(
                                      height: 24,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.h),
                                        child: Text(
                                          "lbl229".tr,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      height: 24,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.h),
                                        child: Text(
                                          "lbl230".tr,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      height: 24,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.h),
                                        child: Text(
                                          "lbl231".tr,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 132.h)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: TabBarView(
                            controller: controller.tabviewController,
                            children: [InitialTabPage(), K78Page(), K79Page()],
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
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
