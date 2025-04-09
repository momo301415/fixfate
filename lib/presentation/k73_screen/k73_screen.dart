import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_search_view.dart';
import 'controller/k73_controller.dart';
import 'models/listview_item_model.dart';
import 'widgets/listview_item_widget.dart'; // ignore_for_file: must_be_immutable

class K73Screen extends GetWidget<K73Controller> {
  const K73Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appTheme.teal50,
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    height: 732.h,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(
                            left: 14.h,
                            right: 6.h,
                            bottom: 80.h,
                          ),
                          child: Column(
                            spacing: 12,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "msg_2025_03_29".tr,
                                style: CustomTextStyles.bodySmall10,
                              ),
                              _buildListview(),
                              _buildRowviewtwo()
                            ],
                          ),
                        ),
                        _buildStacksbgone()
                      ],
                    ),
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
  Widget _buildListview() {
    return Padding(
      padding: EdgeInsets.only(right: 8.h),
      child: Obx(
        () => ListView.separated(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 16.h,
            );
          },
          itemCount: controller.k73ModelObj.value.listviewItemList.value.length,
          itemBuilder: (context, index) {
            ListviewItemModel model =
                controller.k73ModelObj.value.listviewItemList.value[index];
            return ListviewItemWidget(
              model,
            );
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowviewtwo() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50.h,
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
          Expanded(
            child: Container(
              height: 50.h,
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
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildStacksbgone() {
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
              alignment: Alignment.topCenter,
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: 8.h),
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
                      controller: controller.searchController,
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
            padding: EdgeInsets.only(right: 20.h),
            child: Text(
              one,
              style: CustomTextStyles.bodyMediumPrimaryContainer_2.copyWith(
                color: theme.colorScheme.primaryContainer.withValues(
                  alpha: 0.8,
                ),
              ),
            ),
          ),
        )
      ],
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
}
