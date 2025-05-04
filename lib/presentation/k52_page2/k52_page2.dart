import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/k52_page2/controller/k52_controller2.dart';
import 'package:pulsedevice/presentation/k52_page2/models/list_item_model2.dart';
import 'package:pulsedevice/presentation/k52_page2/widgets/list_item_widget2.dart';
import '../../core/app_export.dart';

/// 警報紀錄-tab-統計
class K52Page2 extends StatelessWidget {
  K52Page2({Key? key}) : super(key: key);

  final K52Controller2 controller = Get.put(K52Controller2());

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
                  ListItemWidget2(ListItemModel2()),
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
      onTap: () => controller.selectHistoryDate(),
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
                      controller.pickDate.value,
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
}
