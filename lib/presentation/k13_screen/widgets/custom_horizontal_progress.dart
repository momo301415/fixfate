import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

/// 自定義水平進度條組件
class CustomHorizontalProgress extends StatelessWidget {
  final String label; // 標籤名稱
  final double currentValue; // 當前值
  final double targetValue; // 目標值
  final String unit; // 單位
  final Color progressColor; // 進度條顏色
  final Color backgroundColor; // 背景顏色
  final double height; // 進度條高度
  final double width; // 進度條寬度

  const CustomHorizontalProgress({
    Key? key,
    required this.label,
    required this.currentValue,
    required this.targetValue,
    required this.unit,
    this.progressColor = const Color(0xFF26A69A),
    this.backgroundColor = const Color(0xFFE0F2F1),
    this.height = 8.0,
    this.width = 122.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = targetValue > 0 ? (currentValue / targetValue).clamp(0.0, 1.0) : 0.0;
    
    return SizedBox(
      width: width,
      child: Column(
        children: [
          // 標籤和數值行
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: CustomTextStyles.bodySmall8.copyWith(
                  color: theme.colorScheme.errorContainer,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${currentValue.toInt()}/${targetValue.toInt()}',
                    style: CustomTextStyles.pingFangTC4ErrorContainer.copyWith(
                      color: theme.colorScheme.errorContainer,
                    ),
                  ),
                  Text(
                    unit,
                    style: CustomTextStyles.pingFangTC4ErrorContainerRegular6.copyWith(
                      color: theme.colorScheme.errorContainer,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 4.h),
          // 進度條
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(height / 2),
            ),
            child: Stack(
              children: [
                Container(
                  width: width * progress,
                  height: height,
                  decoration: BoxDecoration(
                    color: progressColor,
                    borderRadius: BorderRadius.circular(height / 2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}