import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'controller/k86_controller.dart';
import 'initia_tab_page.dart'; // ignore_for_file: must_be_immutable

class K86Screen extends GetWidget<K86Controller> {
  const K86Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.teal50,
      body: SafeArea(
        child: Container(
          height: 796.h,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 796.h,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [_buildHorizontalscrol(), _buildStackunionone()],
                ),
              )
            ],
          ),
        ),
      ),
    );
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
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Obx(
                  () => Container(
                    height: 56.h,
                    width: 468.h,
                    margin: EdgeInsets.only(right: 18.h),
                    child: CalendarDatePicker2(
                      config: CalendarDatePicker2Config(
                        calendarType: CalendarDatePicker2Type.single,
                        firstDate: DateTime(DateTime.now().year - 5),
                        lastDate: DateTime(DateTime.now().year + 5),
                        firstDayOfWeek: 0,
                      ),
                      value: controller.selectedDatesFromCalendar.value,
                      onValueChanged: (dates) {
                        controller.selectedDatesFromCalendar.value = dates;
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 344.h,
                        margin: EdgeInsets.only(right: 16.h),
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
                                      "lbl_680".tr,
                                      style: theme.textTheme.headlineLarge,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 4.h,
                                      bottom: 6.h,
                                    ),
                                    child: Text(
                                      "lbl193".tr,
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
                            children: [
                              InitiaTabPage(),
                              InitiaTabPage(),
                              InitiaTabPage()
                            ],
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

  /// Section Widget
  Widget _buildStackunionone() {
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        height: 90.h,
        width: 376.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgUnion90x374,
              height: 90.h,
              width: double.maxFinite,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: CustomAppBar(
                leadingWidth: 56.h,
                leading: AppbarLeadingImage(
                  imagePath: ImageConstant.imgArrowLeft,
                  margin: EdgeInsets.only(left: 32.h),
                  onTap: () {
                    onTapArrowleftone();
                  },
                ),
                title: AppbarSubtitle(
                  text: "lbl243".tr,
                  margin: EdgeInsets.only(right: 88.h),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
