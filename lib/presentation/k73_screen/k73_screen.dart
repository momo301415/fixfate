import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/k73_screen/models/family_item_model.dart';
import 'package:pulsedevice/presentation/k73_screen/widgets/family_item_widget.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import 'controller/k73_controller.dart';
import 'widgets/listview_item_widget.dart'; // ignore_for_file: must_be_immutable
// 首頁
/// 健康資料主頁面
class K73Screen extends GetWidget<K73Controller> {
  const K73Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BaseChatScaffold(
      controller: controller.searchController,
      enableScroll: false,
      snedChatEvent: () {
        FocusScope.of(context).unfocus();
        controller.onSendPressed();
      },
      onEvent: () {
        print("k73 screen onEvent");
        Future.delayed(const Duration(milliseconds: 500), () {
          controller.getFamilyData();
          controller.getHealthData(
              familyId: controller.gc.familyId.value,
              familyName: controller.gc.familyName.value);
          ;
        });
      },
      child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 120.h),
        children: [
          _buildColumnone(),
          SizedBox(height: 12.h),
          Obx(() => Text(
                "msg_update_time".tr + " : " + controller.loadDataTime.value,
                style: CustomTextStyles.bodySmall10,
                textAlign: TextAlign.center,
              )),
          SizedBox(height: 12.h),
          _buildListview(),
          // _buildRowviewtwo() // 註解掉，功能已整合到Grid中
        ],
      ),
    );
  }
  // 首頁gridView
  /// Section Widget
  Widget _buildListview() {
    return Obx(() {
      final items = controller.k73ModelObj.value.listviewItemList.value;

      return GridView.builder(
        itemCount: items.length + 1, // +1 為垂直功能按鈕組
        shrinkWrap: true,
        physics:
            NeverScrollableScrollPhysics(), // ❗讓父層 SingleChildScrollView 控制滾動
        padding: EdgeInsets.only(bottom: 4.h), // ✅ 增加底部空間，避免遮擋按鈕
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 3.h,
          mainAxisSpacing: 6.h,
          childAspectRatio: 1.6,
        ),
        itemBuilder: (context, index) {
          if (index < items.length) {
            final item = items[index];
            return GestureDetector(
              onTap: () {
                controller.gok76Screen(index);
                print("點擊了${item.label}");
              },
              child: ListviewItemWidget(model: item),
            );
          } else {
            // 最後一個位置顯示垂直功能按鈕組
            return _buildVerticalFunctionButtons();
          }
        },
      );
    });
  }

  /// 垂直排列的功能按鈕組 (填補Grid空格)
  Widget _buildVerticalFunctionButtons() {
    return Column(
      children: [
        // 第一個功能按鈕 - Stack設計，圖標超出背景
        Expanded(
          child: GestureDetector(
            onTap: () {
              controller.gok5Screen();
            },
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 4.h),
              padding: EdgeInsets.symmetric(horizontal: 8.h),
              height: 50.h,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // 白色背景
                  Container(
                    height: 40.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: appTheme.whiteA700,
                      borderRadius: BorderRadius.circular(8.h),
                    ),
                  ),
                  // 圖標和文字
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.h),
                                child: _buildRowiconsportrun(
                                  iconsportrun: ImageConstant.imgIconSportRun,
                                  one: "lbl223".tr,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

        // 第二個功能按鈕 - Stack設計，圖標超出背景
        Expanded(
          child: GestureDetector(
            onTap: () {
              controller.goK40Screen();
            },
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 4.h),
              padding: EdgeInsets.symmetric(horizontal: 8.h),
              height: 50.h,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // 白色背景
                  Container(
                    height: 40.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: appTheme.whiteA700,
                      borderRadius: BorderRadius.circular(8.h),
                    ),
                  ),
                  // 圖標和文字
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.h),
                                child: _buildRowiconsportrun(
                                  iconsportrun: ImageConstant.img2411,
                                  one: "lbl222".tr,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 已註解：原本的水平排列功能按鈕，現已整合到Grid中作為垂直排列
  // /// Section Widget
  // Widget _buildRowviewtwo() {
  //   return Container(
  //     width: double.maxFinite,
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: GestureDetector(
  //               onTap: () {
  //                 controller.goK40Screen();
  //               },
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 8.h),
  //                 height: 50.h,
  //                 child: Stack(
  //                   alignment: Alignment.bottomCenter,
  //                   children: [
  //                     Container(
  //                       height: 40.h,
  //                       width: 162.h,
  //                       decoration: BoxDecoration(
  //                         color: appTheme.whiteA700,
  //                         borderRadius: BorderRadius.circular(
  //                           8.h,
  //                         ),
  //                       ),
  //                     ),
  //                     Align(
  //                       alignment: Alignment.topCenter,
  //                       child: SizedBox(
  //                         width: double.maxFinite,
  //                         child: Column(
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: [
  //                             SizedBox(
  //                               width: double.maxFinite,
  //                               child: Align(
  //                                 alignment: Alignment.topCenter,
  //                                 child: Padding(
  //                                   padding:
  //                                       EdgeInsets.symmetric(horizontal: 8.h),
  //                                   child: _buildRowiconsportrun(
  //                                     iconsportrun: ImageConstant.img2411,
  //                                     one: "lbl222".tr,
  //                                   ),
  //                                 ),
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               )),
  //         ),
  //         SizedBox(width: 0.h),
  //         Expanded(
  //           child: GestureDetector(
  //               onTap: () {
  //                 controller.gok5Screen();
  //               },
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 8.h),
  //                 height: 50.h,
  //                 child: Stack(
  //                   alignment: Alignment.bottomCenter,
  //                   children: [
  //                     Container(
  //                       height: 40.h,
  //                       width: 162.h,
  //                       decoration: BoxDecoration(
  //                         color: appTheme.whiteA700,
  //                         borderRadius: BorderRadius.circular(
  //                           8.h,
  //                         ),
  //                       ),
  //                     ),
  //                     Align(
  //                       alignment: Alignment.topCenter,
  //                       child: SizedBox(
  //                         width: double.maxFinite,
  //                         child: Column(
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: [
  //                             SizedBox(
  //                               width: double.maxFinite,
  //                               child: Align(
  //                                 alignment: Alignment.topCenter,
  //                                 child: Padding(
  //                                   padding:
  //                                       EdgeInsets.symmetric(horizontal: 8.h),
  //                                   child: _buildRowiconsportrun(
  //                                     iconsportrun:
  //                                         ImageConstant.imgIconSportRun,
  //                                     one: "lbl223".tr,
  //                                   ),
  //                                 ),
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               )),
  //         )
  //       ],
  //     ),
  //   );
  // }

  /// Common widget
  Widget _buildRowiconsportrun({
    required String iconsportrun,
    required String one,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomImageView(
          imagePath: iconsportrun,
          height: 40.h,
          width: 42.h,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(right: 20.h, top: 15.v),
            child: Center(
                child: Text(
              one,
              style: CustomTextStyles.bodyMediumPrimaryContainer_2.copyWith(
                color: theme.colorScheme.primaryContainer.withValues(
                  alpha: 0.8,
                ),
              ),
            )),
          ),
        )
      ],
    );
  }

  Widget _buildColumnone() {
    return Obx(() {
      final list = controller.k73ModelObj.value.familyItemList.value;

      if (list.isEmpty) {
        return Container(); // 或顯示提示文字也行
      }
      return Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(right: 8.h),
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: AppDecoration.fillOnPrimary.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Obx(
                () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 22.h,
                    children: List.generate(
                      controller.k73ModelObj.value.familyItemList.value.length,
                      (index) {
                        FamilyItemModel model = controller
                            .k73ModelObj.value.familyItemList.value[index];
                        return GestureDetector(
                            onTap: () {
                              print(model);
                              // controller.goTow7Screen(controller.selectFamily[index]);
                            },
                            child: FamilyItemWidget(
                              model,
                              index: index,
                            ));
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
