import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/k52_controller.dart';
import 'models/k52_model.dart';
import 'models/list_item_model.dart';
import 'widgets/list_item_widget.dart';

// ignore_for_file: must_be_immutable
class K52Page extends StatelessWidget {
  K52Page({Key? key})
      : super(
          key: key,
        );

  K52Controller controller = Get.put(K52Controller(K52Model().obs));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 18.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.all(8.h),
                  decoration: AppDecoration.fillWhiteA.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder24,
                  ),
                  child: Column(
                    spacing: 4,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _buildRow202508(),
                      _buildList(),
                      SizedBox(height: 16.h)
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
  Widget _buildRow202508() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14.h,
        vertical: 12.h,
      ),
      decoration: AppDecoration.fillGray30066.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "lbl_2025_08".tr,
              style: CustomTextStyles.bodyMediumPrimaryContainer_1,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgArrowDownPrimarycontainer16x16,
            height: 16.h,
            width: 18.h,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildList() {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.k52ModelObj.value.listItemList.value.length,
          itemBuilder: (context, index) {
            ListItemModel model =
                controller.k52ModelObj.value.listItemList.value[index];
            return ListItemWidget(
              model,
            );
          },
        ),
      ),
    );
  }
}
