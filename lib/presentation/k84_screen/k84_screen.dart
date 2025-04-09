import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'controller/k84_controller.dart';
import 'initial_tab5_page.dart'; // ignore_for_file: must_be_immutable

class K84Screen extends GetWidget<K84Controller> {
  const K84Screen({Key? key})
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Obx(
                  () => Container(
                    height: 56.h,
                    width: 402.h,
                    margin: EdgeInsets.only(left: 16.h),
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
                                      "lbl_83".tr,
                                      style: theme.textTheme.headlineLarge,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 4.h,
                                      bottom: 6.h,
                                    ),
                                    child: Text(
                                      "lbl189".tr,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 4.h),
                                      child: Text(
                                        "lbl_232".tr,
                                        style: theme.textTheme.headlineLarge,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 4.h,
                                      bottom: 6.h,
                                    ),
                                    child: Text(
                                      "lbl249".tr,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 6.h),
                                    child: Text(
                                      "lbl_243".tr,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 16.h,
                                      bottom: 2.h,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.h,
                                      vertical: 4.h,
                                    ),
                                    decoration: AppDecoration.gray100.copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.circleBorder12,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "lbl250".tr,
                                          style: theme.textTheme.labelLarge,
                                        )
                                      ],
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
                            SizedBox(height: 218.h)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: TabBarView(
                            controller: controller.tabviewController,
                            children: [
                              InitialTab5Page(),
                              InitialTab5Page(),
                              InitialTab5Page()
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
      alignment: Alignment.topLeft,
      child: Container(
        height: 90.h,
        margin: EdgeInsets.only(right: 44.h),
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
