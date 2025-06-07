import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k5_controller.dart';
import '../models/listeightysix_item_model.dart';

// ignore_for_file: must_be_immutable
class ListeightysixItemWidget extends StatelessWidget {
  ListeightysixItemWidget({Key? key}) : super(key: key);

  var controller = Get.find<K5Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 16.v),
      decoration: BoxDecoration(
        color: appTheme.teal900,
        borderRadius: BorderRadius.circular(8.h),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4.h,
            spreadRadius: 1.h,
            offset: Offset(0, 2.v),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 心率 (直接傳 RxInt)
          Expanded(
            child: _StatColumn(
              imagePath: ImageConstant.imgFavoriteWhiteA700,
              valueRx: controller.bpm, // RxInt
              unit: 'lbl_bpm'.tr,
            ),
          ),
          Container(
            width: 1.h,
            height: 48.v,
            color: Colors.white24,
          ),
          // 距離 (傳 RxInt)
          Expanded(
            child: _StatColumn(
              imagePath: ImageConstant.imgURulerWhiteA700,
              valueRx: controller.distance, // RxInt
              unit: 'lbl193'.tr,
              formatWithComma: true, // 如果要千分位逗號
            ),
          ),
          Container(
            width: 1.h,
            height: 48.v,
            color: Colors.white24,
          ),
          // 步數 (傳 RxInt)
          Expanded(
            child: _StatColumn(
              imagePath: ImageConstant.imgSettings,
              valueRx: controller.steps, // RxInt
              unit: 'lbl187'.tr,
              formatWithComma: true,
            ),
          ),
        ],
      ),
    );
  }
}

/// 單一 stat 項目：Icon + 數字 + 單位
class _StatColumn extends StatelessWidget {
  final String imagePath;
  final RxInt valueRx;
  final String unit;
  final bool formatWithComma;

  const _StatColumn({
    Key? key,
    required this.imagePath,
    required this.valueRx,
    required this.unit,
    this.formatWithComma = false, // 是否要做千分位格式
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomImageView(
          imagePath: imagePath,
          color: appTheme.whiteA700,
        ),
        SizedBox(height: 8.v),
        Obx(() {
          String valStr = valueRx.value.toString();
          if (formatWithComma) {
            valStr = _formatWithComma(valueRx.value);
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                valStr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.fSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 4.h),
              Text(
                unit,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12.fSize,
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}

/// 千分符函式
String _formatWithComma(int val) {
  final str = val.toString();
  final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
  return str.replaceAllMapped(reg, (match) => ',');
}
