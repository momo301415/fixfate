import 'package:flutter/material.dart';
import 'package:pulsedevice/core/utils/snackbar_helper.dart';
import 'package:pulsedevice/presentation/k5_screen/controller/countdown_controller.dart';
import 'package:pulsedevice/presentation/k5_screen/k5_2_page.dart';
import 'package:pulsedevice/presentation/k5_screen/widgets/full_screen_countdown.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'controller/k5_controller.dart';
import 'k5_1_page.dart'; // ignore_for_file: must_be_immutable

/// 開始運動頁面
class K5Screen extends GetWidget<K5Controller> {
  const K5Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: Container(
          height: 740.h,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Obx(() => CustomImageView(
                    imagePath: controller.tabIndex.value == 0
                        ? ImageConstant.imgVector286x374
                        : ImageConstant.imgFrame87012,
                    height: 286.h,
                    width: double.maxFinite,
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 66.h),
                  )),
              SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _buildTabview(),
                    Expanded(
                      child: Container(
                        child: TabBarView(
                          controller: controller.tabviewController,
                          children: [
                            K5_1Page(
                              onStartPressed: () async {
                                var res = await YcProductPlugin()
                                    .queryDeviceBasicInfo();
                                if (res != null && res.statusCode == 0) {
                                  _showCountdownThenStart(context);
                                } else {
                                  SnackbarHelper.showBlueSnackbar(
                                      message: "請先連接藍牙裝置");
                                }
                              },
                            ),
                            K5_2Page(
                              onStartPressed: () async {
                                var res = await YcProductPlugin()
                                    .queryDeviceBasicInfo();
                                if (res != null && res.statusCode == 0) {
                                  _showCountdownThenStart(context);
                                } else {
                                  SnackbarHelper.showBlueSnackbar(
                                      message: "請先連接藍牙裝置");
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: 56.h,
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 16.h),
        onTap: () {
          onTapArrowleftone();
        },
      ),
      centerTitle: true,
      title: AppbarSubtitle(text: "lbl267".tr),
      styleType: Style.bgFillOnPrimary,
    );
  }

  Widget _buildTabview() {
    return SizedBox(
      width: double.infinity,
      child: Obx(() {
        // 當 tabIndex 變動時重新建構
        final int selectedIndex = controller.tabIndex.value;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.h),
          decoration: BoxDecoration(
            color: appTheme.whiteA700, // 背景白色
            borderRadius: BorderRadius.circular(22.h), // 整體圓角
            boxShadow: [
              BoxShadow(
                color: appTheme.teal2007f,
                spreadRadius: 2.h,
                blurRadius: 2.h,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22.h),
            child: TabBar(
              controller: controller.tabviewController,
              // 移除 TabBar 本身的內建指標
              indicatorColor: Colors.transparent,
              // 點擊時同時修改 RxInt 狀態
              onTap: (index) {
                controller.switchMode(index);
              },
              // 文字樣式，選中 / 未選中都為相同 fontSize / fontWeight
              labelStyle: TextStyle(
                fontSize: 15.fSize,
                fontFamily: 'PingFang TC',
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 15.fSize,
                fontFamily: 'PingFang TC',
                fontWeight: FontWeight.w500,
              ),
              // 文字顏色不需要在此設定，會靠 container 中的 Text 決定
              labelColor: Colors.transparent,
              unselectedLabelColor: Colors.transparent,
              tabs: [
                // ── Tab 0 ──
                Tab(
                  height: 45.v,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: EdgeInsets.only(right: 6.h, top: 2.h, bottom: 2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.h),
                      // 如果目前選中 index == 0，則套用漸層背景，否則純白
                      gradient: selectedIndex == 0
                          ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                appTheme.cyan700,
                                theme.colorScheme.onErrorContainer,
                              ],
                            )
                          : null,
                      color: selectedIndex == 0 ? null : appTheme.whiteA700,
                    ),
                    child: Text(
                      "lbl253".tr, // 「有氧」或對應文字
                      style: TextStyle(
                        fontSize: 15.fSize,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w500,
                        // 選中時文字全白，未選中時文字深色
                        color: selectedIndex == 0
                            ? appTheme.whiteA700
                            : appTheme.blueGray400,
                      ),
                    ),
                  ),
                ),
                // ── Tab 1 ──
                Tab(
                  height: 45.v,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 6.h, top: 2.h, bottom: 2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.h),
                      gradient: selectedIndex == 1
                          ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                appTheme.cyan700,
                                theme.colorScheme.onErrorContainer,
                              ],
                            )
                          : null,
                      color: selectedIndex == 1 ? null : appTheme.whiteA700,
                    ),
                    child: Text(
                      "lbl255".tr, // 「重訓」或對應文字
                      style: TextStyle(
                        fontSize: 15.fSize,
                        fontFamily: 'PingFang TC',
                        fontWeight: FontWeight.w500,
                        color: selectedIndex == 1
                            ? appTheme.whiteA700
                            : appTheme.blueGray400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  /// 全螢幕倒數後才呼叫 startSport，並且把運動類別傳進 Controller
  void _showCountdownThenStart(BuildContext context) {
    // 保險做法：刪除舊的 Controller
    if (Get.isRegistered<CountdownController>(tag: 'k5_sport_countdown')) {
      Get.delete<CountdownController>(tag: 'k5_sport_countdown');
    }

    Get.put<CountdownController>(
      CountdownController(
        initialCount: 3,
        onFinish: () {
          if (Get.isDialogOpen == true) {
            Get.back();
          }
          controller.startSport();
        },
      ),
      tag: 'k5_sport_countdown',
    );

    Get.dialog(
      const FullscreenCountdown(),
      barrierDismissible: false,
      useSafeArea: false,
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    controller.stopSport();
    Get.back();
  }
}
