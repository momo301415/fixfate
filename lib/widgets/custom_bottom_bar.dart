import 'package:flutter/material.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/chat_screen_controller.dart';
import '../core/app_export.dart';

enum BottomBarEnum { tf }

// ignore_for_file: must_be_immutable
class CustomBottomBar extends StatelessWidget {
  CustomBottomBar({Key? key, this.onChanged})
      : super(
          key: key,
        );

  RxInt selectedIndex = 2.obs; // 改為 2，對應 K29Page (我的按鈕)
  final gc = Get.find<GlobalController>();
  final cc = Get.find<ChatScreenController>();

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgNavPrimary24x24,
      activeIcon: ImageConstant.imgNavPrimary24x24,
      title: "lbl68".tr,
      type: BottomBarEnum.tf,
    ),
    BottomMenuModel(
      icon: ImageConstant.record,
      activeIcon: ImageConstant.record,
      title: "lbl158".tr,
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
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          height: 64.h, // 從55.h增加到70.h
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // 白色背景容器
              _buildBackgroundContainer(),

              // 左右按鈕區域
              _buildLeftRightButtons(),

              // 中間浮動按鈕
              _buildFloatingCenterButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// 建立白色背景容器
  Widget _buildBackgroundContainer() {
    return Container(
      margin: EdgeInsets.only(
        top: 6.h,
        left: 54.h,
        right: 54.h,
        bottom: 6.h,
      ),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(32.h),
        boxShadow: [
          BoxShadow(
            color: appTheme.gray6004c,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(0, 4),
          )
        ],
      ),
    );
  }

  /// 建立左右按鈕區域
  Widget _buildLeftRightButtons() {
    return Positioned(
      top: 6.h, // 對應背景容器的 top margin
      left: 54.h, // 對應背景容器的 left margin
      right: 54.h, // 對應背景容器的 right margin
      bottom: 6.h, // 對應背景容器的 bottom margin
      child: Row(
        children: [
          // 左側按鈕：健康
          Expanded(
            child: _buildCustomButton(0),
          ),

          // 中間空白區域
          Expanded(
            child: SizedBox(), // 空白，讓浮動按鈕佔用
          ),

          // 右側按鈕：我的
          Expanded(
            child: _buildCustomButton(2),
          ),
        ],
      ),
    );
  }

  /// 建立自定義按鈕（保持原樣式）
  Widget _buildCustomButton(int index) {
    return Obx(() {
      // 修改選中狀態判斷邏輯
      bool isSelected;
      switch (index) {
        case 0:
          // 健康按鈕：當 bottomBarIndex == 0 且 K19Screen 未顯示時選中
          isSelected = gc.bottomBarIndex.value == 0 && !cc.isK19Visible.value;
          break;
        case 1:
          // 諮詢按鈕：當 K19Screen 顯示時選中
          isSelected = cc.isK19Visible.value;
          break;
        case 2:
          // 我的按鈕：當 bottomBarIndex == 1 且 K19Screen 未顯示時選中
          isSelected = gc.bottomBarIndex.value == 1 && !cc.isK19Visible.value;
          break;
        default:
          isSelected = false;
      }

      final menuItem = bottomMenuList[index];

      return GestureDetector(
        onTap: () => _onButtonTap(index),
        child: Container(
          height: 58.h, // 調整為適合新白色容器的高度 (70-6-6=58)
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: isSelected ? menuItem.activeIcon : menuItem.icon,
                height: 24.h,
                width: 24.h,
                color:
                    isSelected ? theme.colorScheme.primary : appTheme.gray500,
              ),
              SizedBox(height: 4.h),
              Text(
                menuItem.title ?? "",
                style: TextStyle(
                  color:
                      isSelected ? theme.colorScheme.primary : appTheme.gray500,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  /// 建立浮動中間按鈕
  Widget _buildFloatingCenterButton() {
    return Positioned(
      top: -30, // 向上浮動
      left: 0,
      right: 0,
      child: Center(
        child: GestureDetector(
          onTap: () => _onButtonTap(1),
          child: CustomImageView(
            imagePath: ImageConstant.record,
            height: 80.h,
            width: 80.h,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  /// 按鈕點擊事件處理
  void _onButtonTap(int index) {
    print('🔘 CustomBottomBar._onButtonTap: index = $index');

    // 更新本地選中狀態
    selectedIndex.value = index;

    // 諮詢按鈕不直接改變 bottomBarIndex，交由 HomeController 處理
    if (index != 1) {
      gc.bottomBarIndex.value = index == 2 ? 1 : index;
    }

    // 呼叫外部回調
    onChanged?.call(index);
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
