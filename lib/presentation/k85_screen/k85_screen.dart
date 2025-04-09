import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'controller/k85_controller.dart';
import 'initi_tab_page.dart'; // ignore_for_file: must_be_immutable

class K85Screen extends GetWidget<K85Controller> {
  const K85Screen({Key? key})
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
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTabview(),
                          Expanded(
                            child: Container(
                              child: TabBarView(
                                controller: controller.tabviewController,
                                children: [
                                  Container(),
                                  Container(),
                                  Container(),
                                  Container(),
                                  Container(),
                                  InitiTabPage()
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    _buildStackunionone()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTabview() {
    return Obx(
      () => SizedBox(
        width: 374.h,
        child: TabBar(
          controller: controller.tabviewController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: appTheme.whiteA700,
          labelStyle: TextStyle(
            fontSize: 12.fSize,
            fontFamily: 'PingFang TC',
            fontWeight: FontWeight.w400,
          ),
          unselectedLabelColor: appTheme.whiteA700,
          unselectedLabelStyle: TextStyle(
            fontSize: 12.fSize,
            fontFamily: 'PingFang TC',
            fontWeight: FontWeight.w400,
          ),
          tabs: [
            Tab(
              height: 56,
              child: Container(
                alignment: Alignment.center,
                decoration: controller.tabIndex.value == 0
                    ? BoxDecoration(
                        color: appTheme.blueGray90001,
                        borderRadius: BorderRadius.circular(
                          8.h,
                        ))
                    : BoxDecoration(
                        color: appTheme.teal2007f01,
                        borderRadius: BorderRadius.circular(
                          8.h,
                        ),
                      ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.h,
                    vertical: 32.h,
                  ),
                  child: Text(
                    "lbl171".tr,
                  ),
                ),
              ),
            ),
            Tab(
              height: 56,
              child: Container(
                alignment: Alignment.center,
                decoration: controller.tabIndex.value == 1
                    ? BoxDecoration(
                        color: appTheme.blueGray90001,
                        borderRadius: BorderRadius.circular(
                          8.h,
                        ))
                    : BoxDecoration(
                        color: appTheme.teal2007f01,
                        borderRadius: BorderRadius.circular(
                          8.h,
                        ),
                      ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.h,
                    vertical: 32.h,
                  ),
                  child: Text(
                    "lbl172".tr,
                  ),
                ),
              ),
            ),
            Tab(
              height: 56,
              child: Container(
                alignment: Alignment.center,
                decoration: controller.tabIndex.value == 2
                    ? BoxDecoration(
                        color: appTheme.blueGray90001,
                        borderRadius: BorderRadius.circular(
                          8.h,
                        ))
                    : BoxDecoration(
                        color: appTheme.teal2007f01,
                        borderRadius: BorderRadius.circular(
                          8.h,
                        ),
                      ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.h,
                    vertical: 32.h,
                  ),
                  child: Text(
                    "lbl173".tr,
                  ),
                ),
              ),
            ),
            Tab(
              height: 56,
              child: Container(
                alignment: Alignment.center,
                decoration: controller.tabIndex.value == 3
                    ? BoxDecoration(
                        color: appTheme.blueGray90001,
                        borderRadius: BorderRadius.circular(
                          8.h,
                        ))
                    : BoxDecoration(
                        color: appTheme.teal2007f01,
                        borderRadius: BorderRadius.circular(
                          8.h,
                        ),
                      ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.h,
                    vertical: 32.h,
                  ),
                  child: Text(
                    "lbl217".tr,
                  ),
                ),
              ),
            ),
            Tab(
              height: 56,
              child: Container(
                alignment: Alignment.center,
                decoration: controller.tabIndex.value == 4
                    ? BoxDecoration(
                        color: appTheme.blueGray90001,
                        borderRadius: BorderRadius.circular(
                          8.h,
                        ))
                    : BoxDecoration(
                        color: appTheme.teal2007f01,
                        borderRadius: BorderRadius.circular(
                          8.h,
                        ),
                      ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.h,
                    vertical: 32.h,
                  ),
                  child: Text(
                    "lbl218".tr,
                  ),
                ),
              ),
            ),
            Tab(
              height: 56,
              child: Container(
                alignment: Alignment.center,
                decoration: controller.tabIndex.value == 5
                    ? BoxDecoration(
                        color: appTheme.blueGray90001,
                        borderRadius: BorderRadius.circular(
                          8.h,
                        ))
                    : BoxDecoration(
                        color: appTheme.teal2007f01,
                        borderRadius: BorderRadius.circular(
                          8.h,
                        ),
                      ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.h,
                    vertical: 32.h,
                  ),
                  child: Text(
                    "lbl220".tr,
                  ),
                ),
              ),
            )
          ],
          indicatorColor: Colors.transparent,
          onTap: (index) {
            controller.tabIndex.value = index;
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStackunionone() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 90.h,
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
