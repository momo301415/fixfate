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

                    // ── ❷ 時長：直接 RichText
                    buildDurationText(
                      seconds:
                          int.parse(listOneItemModelObj.m0kcaltwo4!), // ✅ 你的秒數
                      numberStyle: CustomTextStyles.titleMediumPrimary_1,
                      unitStyle: CustomTextStyles.bodySmallPrimaryContainer_4,
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

  /// 將「秒」轉成中文時間 + RichText
  RichText buildDurationText({
    required int seconds,
    required TextStyle numberStyle, // 藍色
    required TextStyle unitStyle, // 黑色
  }) {
    // 先把秒數換成想要的字串 ─ 例如 3661 ➜ 1小時1分鐘1秒
    String _format(int sec) {
      if (sec <= 0) return '0秒';
      final h = sec ~/ 3600;
      final m = (sec % 3600) ~/ 60;
      final s = sec % 60;

      final parts = <String>[];
      if (h > 0) parts.add('$h小時');
      if (m > 0) parts.add('$m分鐘');
      if (s > 0) parts.add('$s秒');
      return parts.join('');
    }

    final str = _format(seconds);

    // 用 RegExp 把「數值」與「中文字單位」拆開
    final spans = <TextSpan>[];
    final reg = RegExp(r'(\d+|[^0-9]+)'); // 抓連續數字或連續非數字
    for (final m in reg.allMatches(str)) {
      final txt = m.group(0)!;
      final isNum = RegExp(r'^\d+$').hasMatch(txt); // 純數字？
      spans.add(TextSpan(text: txt, style: isNum ? numberStyle : unitStyle));
    }

    return RichText(text: TextSpan(children: spans));
  }
}
