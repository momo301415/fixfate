import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_radio_button.dart';
import '../../widgets/custom_search_view.dart';
import 'controller/one11_controller.dart';
import 'models/gridview_item_model.dart';
import 'widgets/gridview_item_widget.dart'; // ignore_for_file: must_be_immutable

class One11Screen extends GetWidget<One11Controller> {
  const One11Screen({Key? key})
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
                  height: 788.h,
                  width: double.maxFinite,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(
                          left: 14.h,
                          right: 6.h,
                          bottom: 60.h,
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
                            _buildGridview()
                          ],
                        ),
                      ),
                      _buildStackunionone()
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
  Widget _buildColumnone() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 8.h),
      padding: EdgeInsets.symmetric(
        horizontal: 40.h,
        vertical: 16.h,
      ),
      decoration: AppDecoration.fillOnPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Obx(
              () => Row(
                children: [
                  CustomRadioButton(
                    text: "lbl227".tr,
                    value: "lbl227".tr,
                    groupValue: controller.radioGroup.value,
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    onChange: (value) {
                      controller.radioGroup.value = value;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: CustomRadioButton(
                      text: "lbl204".tr,
                      value: "lbl204".tr,
                      groupValue: controller.radioGroup.value,
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      onChange: (value) {
                        controller.radioGroup.value = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: CustomRadioButton(
                      text: "lbl205".tr,
                      value: "lbl205".tr,
                      groupValue: controller.radioGroup.value,
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      onChange: (value) {
                        controller.radioGroup.value = value;
                      },
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
  Widget _buildGridview() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 8.h),
        child: Obx(
          () => ResponsiveGridListBuilder(
            minItemWidth: 1,
            minItemsPerRow: 2,
            maxItemsPerRow: 2,
            horizontalGridSpacing: 16.h,
            verticalGridSpacing: 16.h,
            builder: (context, items) => ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              children: items,
            ),
            gridItems: List.generate(
              controller.one11ModelObj.value.gridviewItemList.value.length,
              (index) {
                GridviewItemModel model = controller
                    .one11ModelObj.value.gridviewItemList.value[index];
                return GridviewItemWidget(
                  model,
                );
              },
            ),
          ),
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
