import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../k52_page/k52_page.dart';
import 'controller/k53_controller.dart';
import 'in_tab_page.dart'; // ignore_for_file: must_be_immutable

class K53Screen extends GetWidget<K53Controller> {
  const K53Screen({Key? key})
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
                    _buildStackunionone(),
                    SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTabview(),
                          Expanded(
                            child: Container(
                              child: TabBarView(
                                controller: controller.tabviewController,
                                children: [InTabPage(), K52Page()],
                              ),
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
                leadingWidth: 55.h,
                leading: AppbarLeadingImage(
                  imagePath: ImageConstant.imgArrowLeft,
                  margin: EdgeInsets.only(left: 31.h),
                  onTap: () {
                    onTapArrowleftone();
                  },
                ),
                centerTitle: true,
                title: AppbarSubtitle(
                  text: "lbl59".tr,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTabview() {
    return SizedBox(
      width: double.maxFinite,
      child: Obx(
        () => Container(
          margin: EdgeInsets.symmetric(horizontal: 16.h),
          decoration: BoxDecoration(
            color: appTheme.whiteA700,
            borderRadius: BorderRadius.circular(
              22.h,
            ),
            boxShadow: [
              BoxShadow(
                color: appTheme.teal2007f,
                spreadRadius: 2.h,
                blurRadius: 2.h,
                offset: Offset(
                  0,
                  0,
                ),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              22.h,
            ),
            child: TabBar(
              controller: controller.tabviewController,
              labelPadding: EdgeInsets.zero,
              labelColor: appTheme.blueGray400,
              labelStyle: TextStyle(
                fontSize: 15.fSize,
                fontFamily: 'PingFang TC',
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelColor: appTheme.whiteA700,
              unselectedLabelStyle: TextStyle(
                fontSize: 15.fSize,
                fontFamily: 'PingFang TC',
                fontWeight: FontWeight.w500,
              ),
              tabs: [
                Tab(
                  height: 36,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    margin: EdgeInsets.only(right: 6.h),
                    decoration: controller.tabIndex.value == 0
                        ? BoxDecoration(
                            color: appTheme.whiteA700,
                            borderRadius: BorderRadius.circular(
                              18.h,
                            ))
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              18.h,
                            ),
                            gradient: LinearGradient(
                              begin: Alignment(0, 0),
                              end: Alignment(0.99, 0.92),
                              colors: [
                                appTheme.cyan700,
                                theme.colorScheme.onErrorContainer
                              ],
                            ),
                          ),
                    child: Text(
                      "lbl158".tr,
                    ),
                  ),
                ),
                Tab(
                  height: 36,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    margin: EdgeInsets.only(left: 6.h),
                    decoration: controller.tabIndex.value == 1
                        ? BoxDecoration(
                            color: appTheme.whiteA700,
                            borderRadius: BorderRadius.circular(
                              18.h,
                            ))
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              18.h,
                            ),
                            gradient: LinearGradient(
                              begin: Alignment(0, 0),
                              end: Alignment(0.99, 0.92),
                              colors: [
                                appTheme.cyan700,
                                theme.colorScheme.onErrorContainer
                              ],
                            ),
                          ),
                    child: Text(
                      "lbl159".tr,
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
        ),
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
