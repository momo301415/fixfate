import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_icon_button.dart';
import 'controller/k5_controller.dart';

import 'widgets/listeightysix_item_widget.dart';

/// 重訓運動tab頁面
// ignore_for_file: must_be_immutable
class K5_2Page extends StatelessWidget {
  K5_2Page({Key? key, required this.onStartPressed}) : super(key: key);
  final VoidCallback onStartPressed;
  final controller = Get.find<K5Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 24.h),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  spacing: 40,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgIcon12,
                      height: 160.h,
                      width: 160.h,
                    ),
                    Container(
                      // 容器總高度大約 94v，可依 Figma 微調
                      height: 124.v,
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 62.h), // 左右各留 62h
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 「上次」文字
                          Text(
                            '上次', // 或用 "lbl266".tr
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.fSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8.v),
                          // 深色圓角方塊框，裡面放三組數字＋冒號
                          Obx(() {
                            final h = controller.lastHours.value
                                .toString()
                                .padLeft(2, '0');
                            final m = controller.lastMinutes.value
                                .toString()
                                .padLeft(2, '0');
                            final s = controller.lastSeconds.value
                                .toString()
                                .padLeft(2, '0');
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // 1) 深色方塊，包含「01 : 23 : 42」
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.h, vertical: 8.v),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.circular(8.h), // 圓角 8h
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // 第一個時間盒：01
                                      Container(
                                        width: 48.h,
                                        height: 48.h,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF1F3941),
                                          borderRadius:
                                              BorderRadius.circular(8.h),
                                        ),
                                        child: Text(
                                          h,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24.fSize,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 6.h),
                                      // 冒號
                                      Text(
                                        ':',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24.fSize,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 6.h),
                                      // 第二個時間盒：23
                                      Container(
                                        width: 48.h,
                                        height: 48.h,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF1F3941),
                                          borderRadius:
                                              BorderRadius.circular(8.h),
                                        ),
                                        child: Text(
                                          m,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24.fSize,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 6.h),
                                      // 冒號
                                      Text(
                                        ':',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24.fSize,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 6.h),
                                      // 第三個時間盒：42
                                      Container(
                                        width: 48.h,
                                        height: 48.h,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF1F3941),
                                          borderRadius:
                                              BorderRadius.circular(8.h),
                                        ),
                                        child: Text(
                                          s,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24.fSize,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4.v),
                                // 2) 三個圖示之下的「時」「分」「秒」標籤
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // 時
                                    SizedBox(
                                      width: 48.h,
                                      child: Center(
                                        child: Text(
                                          '時', // 或 "lbl_hours".tr
                                          style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 16.fSize,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            6.h + 12.h), // 冒號及空間 (6h 左 + 6h 右)
                                    // 分
                                    SizedBox(
                                      width: 48.h,
                                      child: Center(
                                        child: Text(
                                          '分', // 或 "lbl_minutes".tr
                                          style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 16.fSize,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 6.h + 12.h),
                                    // 秒
                                    SizedBox(
                                      width: 48.h,
                                      child: Center(
                                        child: Text(
                                          '秒', // 或 "lbl_seconds".tr
                                          style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 16.fSize,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                    Obx(() => Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(horizontal: 28.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomIconButton(
                                height: 90.h,
                                width: 90.h,
                                padding: EdgeInsets.all(28.h),
                                decoration: IconButtonStyleHelper.outlineGray,
                                child: CustomImageView(
                                  imagePath: controller.isStart.value
                                      ? ImageConstant.imgThumbsUp
                                      : ImageConstant.imgPrimary,
                                ),
                                onTap: () {
                                  var isStart = controller.isStart.value;
                                  if (isStart) {
                                    controller.stopSport();
                                  } else {
                                    onStartPressed();
                                  }
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 48.h),
                                child: CustomIconButton(
                                  height: 48.h,
                                  width: 48.h,
                                  padding: EdgeInsets.all(12.h),
                                  decoration:
                                      IconButtonStyleHelper.outlineGrayTL24,
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgGray500,
                                  ),
                                  onTap: () {
                                    controller
                                        .goK6Screen(controller.tabIndex.value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        )),
                    ListeightysixItemWidget(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
