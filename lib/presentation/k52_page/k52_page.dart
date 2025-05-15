import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/k52_controller.dart';
import 'widgets/list_item_widget.dart';

/// 警報紀錄-tab-紀錄
class K52Page extends StatelessWidget {
  K52Page({Key? key}) : super(key: key);

  final K52Controller controller = Get.put(K52Controller());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 18.h),
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.h),
              decoration: AppDecoration.fillWhiteA.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder24,
              ),
              child: Column(
                children: [
                  _buildRow202508(),
                  SizedBox(height: 8.v),
                  _buildList(),
                  SizedBox(height: 16.v),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRow202508() {
    return GestureDetector(
      onTap: () => controller.k53c.selectHistoryDate(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 12.h),
        decoration: AppDecoration.fillGray30066.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder24,
        ),
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 4.h),
                child: Obx(
                  () {
                    return Text(
                      controller.formattedPickDate,
                      style: CustomTextStyles.bodyMediumPrimaryContainer_1,
                    );
                  },
                )),
            CustomImageView(
              imagePath: ImageConstant.imgArrowDownPrimarycontainer16x16,
              height: 16.h,
              width: 18.h,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.k52ModelObj.value.listItemList.value.length,
          itemBuilder: (context, index) {
            final model =
                controller.k52ModelObj.value.listItemList.value[index];
            return ListItemWidget(model);
          },
        ),
      ),
    );
  }
}
