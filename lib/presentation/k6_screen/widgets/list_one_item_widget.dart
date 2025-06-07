import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k6_controller.dart';
import '../models/list_one_item_model.dart';

// ignore_for_file: must_be_immutable
class ListOneItemWidget extends StatelessWidget {
  ListOneItemWidget(this.listOneItemModelObj, {Key? key}) : super(key: key);

  ListOneItemModel listOneItemModelObj;

  var controller = Get.find<K6Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.v),
      decoration: AppDecoration.outlineGray,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 左側圖示
          Padding(
            padding: EdgeInsets.only(left: 8.h, top: 4.v),
            child: CustomImageView(
              imagePath: listOneItemModelObj.one!,
              height: 48.h,
              width: 48.h,
            ),
          ),
          SizedBox(width: 8.h),

          // 右側文字區塊
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 第一列：類別 + 時間
                Row(
                  children: [
                    Text(
                      listOneItemModelObj.two!,
                      style: CustomTextStyles.titleSmallErrorContainer,
                    ),
                    SizedBox(width: 12.h),
                    Text(
                      listOneItemModelObj.time!,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
                SizedBox(height: 4.v),

                // 第二列：三個資料欄位
                Row(
                  children: [
                    // 距離
                    Text(
                      listOneItemModelObj.m130kcaltwo!,
                      style: CustomTextStyles.titleMediumPrimary_1,
                    ),

                    SizedBox(width: 2.h),
                    Text(
                      listOneItemModelObj.m130kcaltwo1!,
                      style: CustomTextStyles.bodySmallPrimaryContainer_4,
                    ),

                    SizedBox(width: 16.h),

                    // 卡路里
                    Text(
                      listOneItemModelObj.m30kcaltwo2!,
                      style: CustomTextStyles.titleMediumPrimary_1,
                    ),

                    SizedBox(width: 2.h),
                    Text(
                      listOneItemModelObj.m30kcaltwo3!,
                      style: CustomTextStyles.bodySmallPrimaryContainer_4,
                    ),

                    SizedBox(width: 16.h),

                    // 時長
                    Text(
                      listOneItemModelObj.m0kcaltwo4!,
                      style: CustomTextStyles.titleMediumPrimary_1,
                    ),

                    SizedBox(width: 2.h),
                    Text(
                      listOneItemModelObj.m0kcaltwo5!,
                      style: CustomTextStyles.bodySmallPrimaryContainer_4,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
