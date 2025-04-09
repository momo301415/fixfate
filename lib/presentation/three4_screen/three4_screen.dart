import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import 'controller/three4_controller.dart';
import 'three_initial_page.dart'; // ignore_for_file: must_be_immutable

class Three4Screen extends GetWidget<Three4Controller> {
  const Three4Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appTheme.teal50,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillTeal,
          child: Column(
            children: [
              Expanded(
                child: Navigator(
                  key: Get.nestedKey(1),
                  initialRoute: AppRoutes.threeInitialPage,
                  onGenerateRoute: (routeSetting) => GetPageRoute(
                    page: () => getCurrentPage(routeSetting.name!),
                    transition: Transition.noTransition,
                  ),
                ),
              ),
              SizedBox(height: 20.h)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(
          left: 54.h,
          right: 54.h,
          bottom: 20.h,
        ),
        child: _buildBottombar(),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottombar() {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        onChanged: (BottomBarEnum type) {
          Get.toNamed(getCurrentRoute(type), id: 1);
        },
      ),
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.tf:
        return AppRoutes.threeInitialPage;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.threeInitialPage:
        return ThreeInitialPage();
      default:
        return DefaultWidget();
    }
  }
}
