import 'package:flutter/material.dart';
import 'package:pulsedevice/core/app_export.dart';
import 'package:pulsedevice/widgets/app_bar/appbar_leading_image.dart';
import 'package:pulsedevice/widgets/app_bar/appbar_subtitle.dart';

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

  const BaseScaffoldImageHeader({
    Key? key,
    required this.title,
    required this.child,
    this.bottomNavigationBar,
    this.headerHeight = 100,
    this.backgroundImage = 'assets/images/img_header_curved.png',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.teal50,
      body: Column(
        children: [
          /// ✅ 精準 Header 區域：不再多加 Padding，統一垂直置中
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
                  top: 48.h, // <- 控制垂直位置
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppbarLeadingImage(
                          imagePath: ImageConstant.imgArrowLeft,
                          onTap: () => Get.back(),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 1,
                          child: AppbarSubtitle(text: title),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          /// ✅ 主內容區塊
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
              child: child,
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
