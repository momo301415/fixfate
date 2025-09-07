import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_text_form_field.dart';
import '../../core/app_export.dart';
import 'controller/three_controller.dart';

// ignore_for_file: must_be_immutable
class ThreeBottomsheet extends StatelessWidget {
  ThreeBottomsheet(this.controller, {Key? key}) : super(key: key);
  ThreeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 28.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "lbl378".tr,
            style: CustomTextStyles.titleMediumErrorContainerSemiBold,
          ),
          SizedBox(height: 20.h),
          _buildOptionItem(context, "營養素"),
          SizedBox(height: 32.h),
          _buildOptionItem(context, "碳水化合物"),
          SizedBox(height: 32.h),
          _buildOptionItem(context, "醣類"),
          SizedBox(height: 32.h),
          _buildOptionItem(context, "蛋白質"),
          SizedBox(height: 32.h),
          _buildOptionItem(context, "飽和脂肪"),
          SizedBox(height: 32.h),
          _buildOptionItem(context, "反式脂肪"),
          SizedBox(height: 32.h),
          _buildOptionItem(context, "膳食纖維"),
          SizedBox(height: 32.h),
          _buildOptionItem(context, "鈉"),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: Divider(color: appTheme.gray200),
          ),
          SizedBox(height: 16.h),
          InkWell(
            onTap: ()=>Get.back(),
            child: Text("lbl50".tr, style: CustomTextStyles.bodyLargeGray500_1)
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget _buildOptionItem(BuildContext context, String text) {
    return GestureDetector(
      onTap: () {
        // 返回点击的文本值
        Get.back(result: text);
      },
      child: Text(
        text,
        style: _getTextStyle(text), // 根据文本内容获取对应的样式
      ),
    );
  }

  TextStyle _getTextStyle(String text) {
    // 根据文本内容返回对应的样式
    if (text == "lbl378".tr) {
      return CustomTextStyles.titleMediumErrorContainerSemiBold;
    } else if (text == "lbl359".tr || text == "lbl50".tr) {
      return CustomTextStyles.bodyLargeGray500_1;
    } else {
      return theme.textTheme.bodyLarge!;
    }
  }
}
