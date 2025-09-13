import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

/// 自定義圓環進度組件
class CustomCircularProgress extends StatelessWidget {
  final double size; // 整體大小
  final double outerRadius; // 外環半徑
  final double innerRadius; // 內環半徑
  final double currentValue; // 已攝取量
  final double totalValue; // 總攝取量
  final String centerLabel; // 中心標籤
  final String centerValue; // 中心數值
  final String centerUnit; // 中心單位
  final Color progressColor; // 進度條顏色
  final Color backgroundColor; // 背景顏色

  const CustomCircularProgress({
    Key? key,
    required this.size,
    required this.outerRadius,
    required this.innerRadius,
    required this.currentValue,
    required this.totalValue,
    required this.centerLabel,
    required this.centerValue,
    required this.centerUnit,
    this.progressColor = const Color(0xFF26A69A),
    this.backgroundColor = const Color(0xFFE0F2F1),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = totalValue > 0 ? (currentValue / totalValue).clamp(0.0, 1.0) : 0.0;
    
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 圓環進度條
          SizedBox(
            height: outerRadius * 2,
            width: outerRadius * 2,
            child: CircularProgressIndicator(
              value: progress,
              backgroundColor: backgroundColor,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              strokeWidth: outerRadius - innerRadius,
            ),
          ),
          // 中心內容
          SizedBox(
            width: innerRadius * 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  centerLabel,
                  style: CustomTextStyles.bodySmall10,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      centerValue,
                      style: CustomTextStyles.headlineSmallErrorContainer,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Text(
                        centerUnit,
                        style: CustomTextStyles.bodySmall8,
                      ),
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