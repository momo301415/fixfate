import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'controller/k29_controller.dart';
import 'models/k29_model.dart';
import 'models/list_one_item_model.dart';
import 'widgets/list_one_item_widget.dart';

// ignore_for_file: must_be_immutable
class K29Page extends StatelessWidget {
  K29Page({Key? key})
      : super(
          key: key,
        );

  K29Controller controller = Get.put(K29Controller(K29Model().obs));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.teal50,
      body: SafeArea(
        child: Container(
          height: 713.h,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              _buildStackunionone(),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(
                  left: 14.h,
                  top: 70.h,
                  right: 6.h,
                ),
                child: Column(
                  spacing: 16,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildListone(),
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(right: 8.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.h,
                        vertical: 4.h,
                      ),
                      decoration: AppDecoration.fillWhiteA.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildRow(),
                          _buildRow1(),
                          _buildRowuslidersv(),
                          _buildRow2(),
                          _buildRowushieldcheck(),
                          _buildRow3(),
                          SizedBox(height: 16.h),
                          Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(horizontal: 16.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.imgFrame2,
                                  height: 20.h,
                                  width: 22.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.h),
                                  child: Text(
                                    "lbl67".tr,
                                    style: CustomTextStyles.bodyMedium15,
                                  ),
                                ),
                                Spacer(),
                                CustomImageView(
                                  imagePath: ImageConstant.imgArrowRight,
                                  height: 16.h,
                                  width: 18.h,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h)
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStackunionone() {
    return Container(
      height: 90.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgUnion90x374,
            height: 90.h,
            width: double.maxFinite,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CustomAppBar(
              centerTitle: true,
              title: AppbarSubtitle(
                text: "lbl57".tr,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildListone() {
    return Container(
      margin: EdgeInsets.only(right: 8.h),
      width: double.maxFinite,
      child: Obx(
        () => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 16.h,
            children: List.generate(
              controller.k29ModelObj.value.listOneItemList.value.length,
              (index) {
                ListOneItemModel model =
                    controller.k29ModelObj.value.listOneItemList.value[index];
                return ListOneItemWidget(
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
  Widget _buildRow() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.outlineGray,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgFrameErrorcontainer20x20,
            height: 20.h,
            width: 22.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              "lbl61".tr,
              style: CustomTextStyles.bodyMedium15,
            ),
          ),
          Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgArrowRight,
            height: 16.h,
            width: 18.h,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRow1() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.outlineGray,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgFrame20x20,
            height: 20.h,
            width: 22.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              "lbl62".tr,
              style: CustomTextStyles.bodyMedium15,
            ),
          ),
          Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgArrowRight,
            height: 16.h,
            width: 18.h,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowuslidersv() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.outlineGray,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgUSlidersV,
            height: 20.h,
            width: 22.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              "lbl63".tr,
              style: CustomTextStyles.bodyMedium15,
            ),
          ),
          Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgArrowRight,
            height: 16.h,
            width: 18.h,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRow2() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.outlineGray,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgFrame1,
            height: 20.h,
            width: 22.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              "lbl64".tr,
              style: CustomTextStyles.bodyMedium15,
            ),
          ),
          Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgArrowRight,
            height: 16.h,
            width: 18.h,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowushieldcheck() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.outlineGray,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgUShieldCheck,
            height: 20.h,
            width: 22.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              "lbl65".tr,
              style: CustomTextStyles.bodyMedium15,
            ),
          ),
          Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgArrowRight,
            height: 16.h,
            width: 18.h,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRow3() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.outlineGray,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgFrame,
            height: 20.h,
            width: 22.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              "lbl66".tr,
              style: CustomTextStyles.bodyMedium15,
            ),
          ),
          Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgArrowRight,
            height: 16.h,
            width: 18.h,
          )
        ],
      ),
    );
  }
}
