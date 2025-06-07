import 'package:flutter/material.dart';
import 'package:pulsedevice/core/global_controller.dart';
import '../core/app_export.dart';

enum BottomBarEnum { tf }

// ignore_for_file: must_be_immutable
class CustomBottomBar extends StatelessWidget {
  CustomBottomBar({Key? key, this.onChanged})
      : super(
          key: key,
        );

  RxInt selectedIndex = 2.obs;
  final gc = Get.find<GlobalController>();

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgNavPrimary24x24,
      activeIcon: ImageConstant.imgNavPrimary24x24,
      title: "lbl68".tr,
      type: BottomBarEnum.tf,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNav,
      activeIcon: ImageConstant.imgNav,
      title: "lbl69".tr,
      type: BottomBarEnum.tf,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavGray50024x24,
      activeIcon: ImageConstant.imgNavGray50024x24,
      title: "lbl70".tr,
      type: BottomBarEnum.tf,
    )
  ];

  Function(int)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
            height: 72.h,
            child: Container(
              margin: EdgeInsets.only(
                left: 54.h,
                right: 54.h,
                bottom: 20.h,
              ),
              decoration: BoxDecoration(
                color: appTheme.whiteA700,
                borderRadius: BorderRadius.circular(
                  32.h,
                ),
                boxShadow: [
                  BoxShadow(
                    color: appTheme.gray6004c,
                    spreadRadius: 2.h,
                    blurRadius: 2.h,
                    offset: Offset(
                      0,
                      4,
                    ),
                  )
                ],
              ),
              child: Obx(
                () => BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  selectedFontSize: 0,
                  elevation: 0,
                  currentIndex: gc.bottomBarIndex.value,
                  type: BottomNavigationBarType.fixed,
                  items: List.generate(bottomMenuList.length, (index) {
                    return BottomNavigationBarItem(
                      icon: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomImageView(
                            imagePath: bottomMenuList[index].icon,
                            height: 24.h,
                            width: 24.h,
                            color: appTheme.gray500,
                          ),
                          Text(
                            bottomMenuList[index].title ?? "",
                            style: theme.textTheme.labelMedium!.copyWith(
                              color: appTheme.gray500,
                            ),
                          )
                        ],
                      ),
                      activeIcon: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomImageView(
                            imagePath: bottomMenuList[index].activeIcon,
                            height: 24.h,
                            width: 24.h,
                            color: theme.colorScheme.primary,
                          ),
                          Text(
                            bottomMenuList[index].title ?? "",
                            style: CustomTextStyles.labelMediumPrimary.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          )
                        ],
                      ),
                      label: '',
                    );
                  }),
                  onTap: (index) {
                    selectedIndex.value = index;
                    gc.bottomBarIndex.value = index;
                    onChanged?.call(index);
                  },
                ),
              ),
            )));
  }
}

// ignore_for_file: must_be_immutable
class BottomMenuModel {
  BottomMenuModel(
      {required this.icon,
      required this.activeIcon,
      this.title,
      required this.type});

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
