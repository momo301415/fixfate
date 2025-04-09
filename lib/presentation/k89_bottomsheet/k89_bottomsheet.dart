import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k89_controller.dart';
import 'models/gridframe_item_model.dart';
import 'widgets/gridframe_item_widget.dart';

// ignore_for_file: must_be_immutable
class K89Bottomsheet extends StatelessWidget {
  K89Bottomsheet(this.controller, {Key? key})
      : super(
          key: key,
        );

  K89Controller controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 36.h,
        vertical: 32.h,
      ),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL12,
      ),
      child: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "lbl_2025".tr,
                  style: CustomTextStyles.titleLargeErrorContainer,
                ),
                Spacer(
                  flex: 85,
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgArrowLeftErrorcontainer,
                  height: 16.h,
                  width: 10.h,
                ),
                Spacer(
                  flex: 14,
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgArrowRightErrorcontainer,
                  height: 16.h,
                  width: 10.h,
                )
              ],
            ),
          ),
          Obx(
            () => ResponsiveGridListBuilder(
              minItemWidth: 1,
              minItemsPerRow: 3,
              maxItemsPerRow: 3,
              horizontalGridSpacing: 4.h,
              verticalGridSpacing: 4.h,
              builder: (context, items) => ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                children: items,
              ),
              gridItems: List.generate(
                controller.k89ModelObj.value.gridframeItemList.value.length,
                (index) {
                  GridframeItemModel model = controller
                      .k89ModelObj.value.gridframeItemList.value[index];
                  return GridframeItemWidget(
                    model,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    height: 56.h,
                    text: "lbl50".tr,
                    buttonStyle: CustomButtonStyles.fillGrayTL8,
                    buttonTextStyle: CustomTextStyles.bodyLargeGray500_1,
                  ),
                ),
                Expanded(
                  child: CustomElevatedButton(
                    height: 56.h,
                    text: "lbl51".tr,
                    buttonStyle: CustomButtonStyles.fillPrimary,
                    buttonTextStyle: CustomTextStyles.bodyLargeWhiteA700_1,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 16.h)
        ],
      ),
    );
  }
}
