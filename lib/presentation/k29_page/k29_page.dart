import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import 'controller/k29_controller.dart';
import 'models/list_one_item_model.dart';
import 'widgets/list_one_item_widget.dart';
import '../../widgets/custom_bottom_bar.dart';

/// 個人中心
class K29Page extends GetWidget<K29Controller> {
  const K29Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      title: "lbl57".tr,
      bottomNavigationBar: CustomBottomBar(
        onChanged: (type) {},
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopFeatureList(),
          SizedBox(height: 24.h),
          _buildMenuCard(),
          SizedBox(height: 80.h),
        ],
      ),
    );
  }

  Widget _buildTopFeatureList() {
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            controller.k29ModelObj.value.listOneItemList.value.length,
            (index) {
              ListOneItemModel model =
                  controller.k29ModelObj.value.listOneItemList.value[index];
              return Padding(
                padding: EdgeInsets.only(right: 16.h),
                child: GestureDetector(
                  onTap: () {
                    switch (index) {
                      case 0:
                        controller.goK48Screen();
                        break;
                    }
                    print('Tapped ${model.id}');
                  },
                  child: ListOneItemWidget(model),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        children: [
          _buildMenuItem("lbl61".tr, ImageConstant.imgFrameErrorcontainer20x20,
              () {
            controller.goK30Screen();
          }),
          _buildMenuItem("lbl62".tr, ImageConstant.imgFrame20x20, () {}),
          _buildMenuItem("lbl63".tr, ImageConstant.imgUSlidersV, () {}),
          _buildMenuItem("lbl64".tr, ImageConstant.imgFrame1, () {}),
          _buildMenuItem("lbl65".tr, ImageConstant.imgUShieldCheck, () {}),
          _buildMenuItem("lbl66".tr, ImageConstant.imgFrame, () {}),
          _buildMenuItem("lbl67".tr, ImageConstant.imgFrame2, () {}),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, String iconPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.h),
        decoration: AppDecoration.outlineGray,
        width: double.infinity,
        child: Row(
          children: [
            CustomImageView(imagePath: iconPath, height: 20.h, width: 22.h),
            SizedBox(width: 8.h),
            Text(title, style: CustomTextStyles.bodyMedium15),
            const Spacer(),
            CustomImageView(
              imagePath: ImageConstant.imgArrowRight,
              height: 16.h,
              width: 18.h,
            ),
          ],
        ),
      ),
    );
  }
}
