import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_subtitle_three.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_search_view.dart';
import 'controller/three4_controller.dart';
import 'models/list_one_item_model.dart';
import 'models/listview_item_model.dart';
import 'models/three_initial_model.dart';
import 'widgets/list_one_item_widget.dart';
import 'widgets/listview_item_widget.dart';

// ignore_for_file: must_be_immutable
class ThreeInitialPage extends StatelessWidget {
  ThreeInitialPage({Key? key})
      : super(
          key: key,
        );

  Three4Controller controller = Get.put(Three4Controller());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 732.h,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _buildStackunionone(),
            _buildStackone(),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [_buildRowviewten()],
                ),
              ),
            ),
            _buildListview(),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 50.h,
                width: 164.h,
                margin: EdgeInsets.only(
                  left: 16.h,
                  bottom: 32.h,
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 40.h,
                      width: 162.h,
                      decoration: BoxDecoration(
                        color: appTheme.whiteA700,
                        borderRadius: BorderRadius.circular(
                          8.h,
                        ),
                      ),
                    ),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 34.h,
                                        child: Column(
                                          children: [
                                            CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgUnion1,
                                              height: 34.h,
                                              width: double.maxFinite,
                                            ),
                                            SizedBox(
                                              width: double.maxFinite,
                                              child: Opacity(
                                                opacity: 0.4,
                                                child: Container(
                                                  height: 8.h,
                                                  width: 32.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      16.h,
                                                    ),
                                                    gradient: LinearGradient(
                                                      begin:
                                                          Alignment(0.5, 0.5),
                                                      end: Alignment(1, 0.5),
                                                      colors: [
                                                        appTheme.cyan8007e,
                                                        appTheme.teal4007e
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 16.h),
                                          child: Text(
                                            "lbl222".tr,
                                            style: CustomTextStyles
                                                .bodyMediumPrimaryContainer_2,
                                          ),
                                        ),
                                      )
                                    ],
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
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 40.h,
                width: 162.h,
                margin: EdgeInsets.only(
                  right: 16.h,
                  bottom: 32.h,
                ),
                decoration: BoxDecoration(
                  color: appTheme.whiteA700,
                  borderRadius: BorderRadius.circular(
                    8.h,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 284.h,
                  margin: EdgeInsets.only(bottom: 44.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 38.h,
                        width: 36.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Opacity(
                              opacity: 0.4,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 6.h,
                                  width: 12.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      6.h,
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment(0.5, 0.5),
                                      end: Alignment(1, 0.5),
                                      colors: [
                                        appTheme.cyan8007e,
                                        appTheme.teal4007e
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Opacity(
                              opacity: 0.2,
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  height: 6.h,
                                  width: 16.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      8.h,
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment(0.5, 0.5),
                                      end: Alignment(1, 0.5),
                                      colors: [
                                        appTheme.cyan8007e.withValues(
                                          alpha: 0.42,
                                        ),
                                        appTheme.teal4007e.withValues(
                                          alpha: 0.42,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgUnion36x32,
                              height: 36.h,
                              width: double.maxFinite,
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(left: 30.h),
                          child: Text(
                            "lbl223".tr,
                            style:
                                CustomTextStyles.bodyMediumPrimaryContainer_2,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 436.h,
                width: 4.h,
                margin: EdgeInsets.only(
                  right: 8.h,
                  bottom: 50.h,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStackunionone() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 168.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgSBg,
              height: 168.h,
              width: double.maxFinite,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(
                  left: 14.h,
                  top: 8.h,
                ),
                child: Column(
                  spacing: 14,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 6.h),
                      width: double.maxFinite,
                      child: CustomAppBar(
                        height: 46.h,
                        title: Padding(
                          padding: EdgeInsets.only(left: 17.h),
                          child: Column(
                            children: [
                              AppbarTitle(
                                text: "lbl224".tr,
                              ),
                              AppbarSubtitleThree(
                                text: "lbl225".tr,
                                margin: EdgeInsets.only(right: 108.h),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 14.h),
                      child: CustomSearchView(
                        controller: controller.searchController,
                        hintText: "lbl226".tr,
                        contentPadding:
                            EdgeInsets.fromLTRB(16.h, 12.h, 12.h, 12.h),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStackone() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 90.h,
        margin: EdgeInsets.only(
          left: 14.h,
          top: 148.h,
          right: 6.h,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(right: 8.h),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: AppDecoration.fillOnPrimary.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 24.h),
                    width: double.maxFinite,
                    child: Obx(
                      () => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 22.h,
                          children: List.generate(
                            controller.threeInitialModelObj.value
                                .listOneItemList.value.length,
                            (index) {
                              ListOneItemModel model = controller
                                  .threeInitialModelObj
                                  .value
                                  .listOneItemList
                                  .value[index];
                              return ListOneItemWidget(
                                model,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 26.h),
                child: Text(
                  "msg_2025_03_29".tr,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodySmall10,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowviewten() {
    return SizedBox(
      width: double.maxFinite,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(top: 222.h),
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 84.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 74.h,
                          width: 162.h,
                          decoration: BoxDecoration(
                            color: appTheme.whiteA700,
                            borderRadius: BorderRadius.circular(
                              8.h,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 82.h,
                        margin: EdgeInsets.only(
                          left: 10.h,
                          right: 8.h,
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Opacity(
                                          opacity: 0.4,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: 8.h,
                                              width: 32.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  16.h,
                                                ),
                                                gradient: LinearGradient(
                                                  begin: Alignment(0.5, 0.5),
                                                  end: Alignment(1, 0.5),
                                                  colors: [
                                                    appTheme.cyan8007e,
                                                    appTheme.teal4007e
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "lbl_1".tr,
                                          style:
                                              CustomTextStyles.bodySmallPrimary,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    margin: EdgeInsets.only(left: 2.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "lbl171".tr,
                                          style: CustomTextStyles
                                              .bodyMediumPrimaryContainer_2,
                                        ),
                                        Spacer(),
                                        Text(
                                          "lbl_792".tr,
                                          style: theme.textTheme.headlineMedium,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: 4.h,
                                              bottom: 8.h,
                                            ),
                                            child: Text(
                                              "lbl177".tr,
                                              style: theme.textTheme.bodySmall,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgVectorWhiteA700,
                              height: 30.h,
                              width: 36.h,
                              alignment: Alignment.topLeft,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 86.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 74.h,
                          width: 162.h,
                          decoration: BoxDecoration(
                            color: appTheme.whiteA700,
                            borderRadius: BorderRadius.circular(
                              8.h,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 84.h,
                        margin: EdgeInsets.symmetric(horizontal: 8.h),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Opacity(
                                          opacity: 0.4,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: 8.h,
                                              width: 28.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  14.h,
                                                ),
                                                gradient: LinearGradient(
                                                  begin: Alignment(0.5, 0.5),
                                                  end: Alignment(1, 0.5),
                                                  colors: [
                                                    appTheme.cyan8007e,
                                                    appTheme.teal4007e
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "lbl_1".tr,
                                          style:
                                              CustomTextStyles.bodySmallPrimary,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 4.h),
                                          child: Text(
                                            "lbl172".tr,
                                            style: CustomTextStyles
                                                .bodyMediumPrimaryContainer_2,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "lbl_982".tr,
                                          style: theme.textTheme.headlineMedium,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: 4.h,
                                              bottom: 8.h,
                                            ),
                                            child: Text(
                                              "lbl182".tr,
                                              style: theme.textTheme.bodySmall,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomImageView(
                                              imagePath: ImageConstant.img34x36,
                                              height: 34.h,
                                              width: 38.h,
                                              alignment: Alignment.center,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 4.h),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10.h,
                                                vertical: 2.h,
                                              ),
                                              decoration: AppDecoration
                                                  .fillOnError
                                                  .copyWith(
                                                borderRadius: BorderRadiusStyle
                                                    .roundedBorder8,
                                              ),
                                              child: Text(
                                                "lbl216".tr,
                                                textAlign: TextAlign.center,
                                                style: CustomTextStyles
                                                    .labelMediumWhiteA700,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
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
    );
  }

  /// Section Widget
  Widget _buildListview() {
    return Padding(
      padding: EdgeInsets.only(
        left: 14.h,
        right: 6.h,
        bottom: 100.h,
      ),
      child: Obx(
        () => ListView.separated(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 14.h,
            );
          },
          itemCount: controller
              .threeInitialModelObj.value.listviewItemList.value.length,
          itemBuilder: (context, index) {
            ListviewItemModel model = controller
                .threeInitialModelObj.value.listviewItemList.value[index];
            return ListviewItemWidget(
              model,
            );
          },
        ),
      ),
    );
  }
}
