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
    this.headerHeight = 120,
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
                // 背景圖：不包 SafeArea，保留圓角
                Image.asset(
                  ImageConstant.imgUnionBg2,
                  fit: BoxFit.fill,
                ),

                // 標題與功能鍵內容：SafeArea 處理瀏海擠壓
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.h),
                    child: SizedBox(
                      height: 40.h,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: AppbarSubtitle(text: title),
                          ),
                          Positioned(
                            left: 0,
                            child: AppbarLeadingImage(
                              imagePath: ImageConstant.imgArrowLeft,
                              onTap: onBack ?? () => Get.back(),
                            ),
                          ),
                          if (actions != null)
                            Positioned(
                              right: 0,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: actions!,
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

          // 內容區
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

class BaseChatScaffold extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final TextEditingController? controller;
  final Widget? bottomNavigationBar;
  final VoidCallback? onEvent;

  const BaseChatScaffold({
    Key? key,
    required this.child,
    this.padding,
    this.controller,
    this.bottomNavigationBar,
    this.onEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.teal50,
      body: Column(
        children: [
          // Header 區塊
          SizedBox(
            height: 178.h,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // 背景圖片，不要包 SafeArea，保留弧形
                Image.asset(
                  ImageConstant.imgUnionBg2,
                  fit: BoxFit.fill,
                ),
                // SafeArea 處理瀏海 + 文字內容
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.only(top: 0.h),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "lbl224".tr,
                                      style:
                                          CustomTextStyles.bodyLargeWhiteA700,
                                    ),
                                    Text(
                                      "lbl225".tr,
                                      style:
                                          CustomTextStyles.bodyMediumWhiteA700,
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.refresh, color: Colors.white),
                                onPressed: onEvent,
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Expanded(
                                child: CustomSearchView(
                                  controller: controller,
                                  hintText: "lbl226".tr,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      16.h, 12.h, 12.h, 12.h),
                                ),
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Scrollable Content
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
