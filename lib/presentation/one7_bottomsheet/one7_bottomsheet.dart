import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/one7_controller.dart';
import 'models/gridmonth_item_model.dart';
import 'widgets/gridmonth_item_widget.dart';

// ignore_for_file: must_be_immutable
class One7Bottomsheet extends StatelessWidget {
  One7Bottomsheet(this.controller, {Key? key})
      : super(
          key: key,
        );

  One7Controller controller;

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
          Obx(
            () => ResponsiveGridListBuilder(
              minItemWidth: 1,
              minItemsPerRow: 2,
              maxItemsPerRow: 2,
              horizontalGridSpacing: 182.h,
              verticalGridSpacing: 182.h,
              builder: (context, items) => ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                children: items,
              ),
              gridItems: List.generate(
                controller.one7ModelObj.value.gridmonthItemList.value.length,
                (index) {
                  GridmonthItemModel model = controller
                      .one7ModelObj.value.gridmonthItemList.value[index];
                  return GridmonthItemWidget(
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
