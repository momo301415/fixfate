import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_subtitle_three.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_search_view.dart';
import 'controller/two8_controller.dart';
import 'models/list_one_item_model.dart';
import 'models/listview_item_model.dart';
import 'widgets/list_one_item_widget.dart';
import 'widgets/listview_item_widget.dart'; // ignore_for_file: must_be_immutable

class Two8Screen extends GetWidget<Two8Controller> {
  const Two8Screen({Key? key})
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
                child: SizedBox(
                  height: 738.h,
                  width: double.maxFinite,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      _buildStackunionone(),
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(
                          left: 14.h,
                          right: 6.h,
                          bottom: 56.h,
                        ),
                        child: Column(
                          spacing: 8,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            _buildColumnone(),
                            Text(
                              "msg_2025_03_29".tr,
                              style: CustomTextStyles.bodySmall10,
                            ),
                            _buildListview()
                          ],
                        ),
                      )
                    ],
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
  Widget _buildColumnone() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 8.h),
      padding: EdgeInsets.symmetric(vertical: 16.h),
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
                    controller.two8ModelObj.value.listOneItemList.value.length,
                    (index) {
                      ListOneItemModel model = controller
                          .two8ModelObj.value.listOneItemList.value[index];
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
    );
  }

  /// Section Widget
  Widget _buildListview() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 8.h),
        child: Obx(
          () => ListView.separated(
            padding: EdgeInsets.zero,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 16.h,
              );
            },
            itemCount:
                controller.two8ModelObj.value.listviewItemList.value.length,
            itemBuilder: (context, index) {
              ListviewItemModel model =
                  controller.two8ModelObj.value.listviewItemList.value[index];
              return ListviewItemWidget(
                model,
              );
            },
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottombar() {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        onChanged: (int index) {
          // Get.toNamed(getCurrentRoute(type), id: 1);
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
}
