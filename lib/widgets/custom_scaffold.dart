import 'package:flutter/material.dart';
import 'package:pulsedevice/core/app_export.dart';
import 'package:pulsedevice/widgets/app_bar/appbar_leading_image.dart';
import 'package:pulsedevice/widgets/app_bar/appbar_subtitle.dart';
import 'package:pulsedevice/widgets/custom_search_view.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? customAppBar;
  final List<Widget>? actions;
  final String? title;
  final bool? extendBody;
  final bool? extendBodyBehindAppBar;
  const BaseScaffold(
      {Key? key,
      required this.body,
      this.bottomNavigationBar,
      this.customAppBar,
      this.actions,
      this.extendBody,
      this.extendBodyBehindAppBar,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: extendBody ?? false,
      extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
      appBar: customAppBar ??
          (title != null || actions != null
              ? AppBar(
                  title: title != null ? Text(title!) : null,
                  actions: actions,
                )
              : null),
      body: body,
      bottomNavigationBar: bottomNavigationBar ?? null,
    );
  }
}

class BaseScaffoldImageHeader extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? bottomNavigationBar;
  final double headerHeight;
  final String backgroundImage;
  final List<Widget>? actions;
  final Function()? onBack;

  const BaseScaffoldImageHeader({
    Key? key,
    required this.title,
    required this.child,
    this.bottomNavigationBar,
    this.headerHeight = 100,
    this.backgroundImage = 'assets/images/img_header_curved.png',
    this.actions,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.teal50,
      body: Column(
        children: [
          SizedBox(
            height: headerHeight.h,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  ImageConstant.imgUnionBg2,
                  width: double.infinity,
                  height: headerHeight.h,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  top: 48.h,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppbarLeadingImage(
                          imagePath: ImageConstant.imgArrowLeft,
                          onTap: onBack ??
                              () {
                                Get.back();
                              },
                        ),
                        SizedBox(width: 8.h),
                        Expanded(
                          child: Center(
                            child: AppbarSubtitle(text: title),
                          ),
                        ),
                        if (actions != null) ...actions!,
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: child,
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class BaseScaffoldImageHeaderQr extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? bottomNavigationBar;
  final double headerHeight;
  final String backgroundImage;
  final List<Widget>? actions;

  const BaseScaffoldImageHeaderQr({
    Key? key,
    required this.title,
    required this.child,
    this.bottomNavigationBar,
    this.headerHeight = 100,
    this.backgroundImage = 'assets/images/background.png', // 頁面背景
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 全頁背景圖
          Positioned.fill(
            child: Image.asset(
              ImageConstant.imgQrBg,
              fit: BoxFit.cover,
            ),
          ),

          // 主內容 + Header 疊層
          Column(
            children: [
              // Header 圖片 + 標題 + 返回鍵
              SizedBox(
                height: headerHeight.h,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      ImageConstant.imgUnionBg2, // 這是 Header 圖片
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      top: 48.h,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppbarLeadingImage(
                              imagePath: ImageConstant.imgArrowLeft,
                              onTap: () => Get.back(),
                            ),
                            SizedBox(width: 8.h),
                            Expanded(
                              child: Center(
                                child: AppbarSubtitle(text: title),
                              ),
                            ),
                            if (actions != null) ...actions!,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 主內容
              Expanded(
                child: child,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class BaseChatScaffold extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final TextEditingController? controller;
  final Widget? bottomNavigationBar;
  BaseChatScaffold({
    Key? key,
    required this.child,
    this.padding,
    this.controller,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.teal50,
      body: Column(
        children: [
          SizedBox(
            height: 168.h,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  ImageConstant.imgUnionBg2,
                  width: double.infinity,
                  height: 168.h,
                  fit: BoxFit.fill,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: 18.h),
                    padding: EdgeInsets.symmetric(horizontal: 14.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: Text(
                            "lbl224".tr,
                            style: CustomTextStyles.bodyLargeWhiteA700,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: Text(
                            "lbl225".tr,
                            style: CustomTextStyles.bodyMediumWhiteA700,
                          ),
                        ),
                        SizedBox(height: 14.h),
                        CustomSearchView(
                          controller: controller,
                          hintText: "lbl226".tr,
                          contentPadding:
                              EdgeInsets.fromLTRB(16.h, 12.h, 12.h, 12.h),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 8.h),
              child: child,
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
