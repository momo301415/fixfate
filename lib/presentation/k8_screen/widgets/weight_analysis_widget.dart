import 'package:flutter/material.dart';
import 'package:pulsedevice/core/app_export.dart';
import '../models/weight_analysis_model.dart';

class WeightAnalysisWidget extends StatelessWidget {
  final WeightAnalysisModel data;
  final double outerRadius;
  final double innerRadius;
  final double strokeWidth;

  const WeightAnalysisWidget({
    Key? key,
    required this.data,
    this.outerRadius = 70.0,
    this.innerRadius = 58.0,
    this.strokeWidth = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      // margin: EdgeInsets.only(
      //   left: 22.h,
      //   right: 16.h,
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircularChart(),
          _buildDataSection(),
        ],
      ),
    );
  }

  Widget _buildCircularChart() {
    return SizedBox(
      height: (outerRadius * 2).h,
      width: (outerRadius * 2 + 2).h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 多层圆环图表
          SizedBox(
            height: (outerRadius * 2).h,
            width: (outerRadius * 2).h,
            child: CustomPaint(
              painter: WeightChartPainter(
                data: data,
                strokeWidth: strokeWidth.h,
              ),
            ),
          ),
          // 中心显示体重
          SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "體重",
                  style: CustomTextStyles.bodySmall10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data.weight.toStringAsFixed(1),
                      style: CustomTextStyles.headlineSmallErrorContainer,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Text(
                          data.weightUnit,
                          style: CustomTextStyles.bodySmall8,
                        ),
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

  Widget _buildDataSection() {
    return SizedBox(
      width: 124.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 更新时间
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              data.updateTime,
              style: CustomTextStyles.bodySmall10,
            ),
          ),
          SizedBox(height: 12.h),
          // BMI行
          _buildDataRow(
            label: "BMI",
            value: data.bmi.toStringAsFixed(1),
            unit: data.bmiUnit,
            labelStyle: CustomTextStyles.labelLargePrimary_2,
            valueStyle: CustomTextStyles.labelMediumErrorContainer,
          ),
          SizedBox(height: 4.h),
          // 数据列表
          _buildDataList(),
        ],
      ),
    );
  }

  Widget _buildDataRow({
    required String label,
    required String value,
    required String unit,
    TextStyle? labelStyle,
    TextStyle? valueStyle,
  }) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        children: [
          Text(
            label,
            style: labelStyle ?? CustomTextStyles.labelLargePrimary_2,
          ),
          Spacer(),
          Text(
            value,
            style: valueStyle ?? CustomTextStyles.labelMediumErrorContainer,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              unit,
              style: CustomTextStyles.pingFangTC4ErrorContainerRegular,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataList() {
    final items = [
      _DataItem(
        color: Color(0xFF4ECDC4), // 体脂肪重颜色
        label: "體脂肪重",
        value: data.bodyFat.toStringAsFixed(1),
        unit: "公斤",
      ),
      _DataItem(
        color: Color(0xFF95E1D3), // 身体总水重颜色
        label: "身體總水重",
        value: data.bodyWater.toStringAsFixed(1),
        unit: "公斤",
      ),
      _DataItem(
        color: Color(0xFFB8E6B8), // 蛋白质量颜色
        label: "蛋白質量",
        value: data.protein.toStringAsFixed(1),
        unit: "公斤",
      ),
      _DataItem(
        color: Color(0xFFD3D3D3), // 矿物质量颜色
        label: "礦物質量",
        value: data.mineral.toStringAsFixed(1),
        unit: "公斤",
      ),
    ];

    return Column(
      children: items.map((item) => _buildDataListItem(item)).toList(),
    );
  }

  Widget _buildDataListItem(_DataItem item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          // 颜色指示器
          Container(
            width: 8.h,
            height: 8.h,
            decoration: BoxDecoration(
              color: item.color,
              shape: BoxShape.rectangle,
            ),
          ),
          SizedBox(width: 8.h),
          // 标签
          Expanded(
            child: Text(
              item.label,
              style: CustomTextStyles.bodySmall10,
            ),
          ),
          // 数值
          Text(
            "${item.value} ${item.unit}",
            style: CustomTextStyles.bodySmall10,
          ),
        ],
      ),
    );
  }
}

class _DataItem {
  final Color color;
  final String label;
  final String value;
  final String unit;

  const _DataItem({
    required this.color,
    required this.label,
    required this.value,
    required this.unit,
  });
}

class WeightChartPainter extends CustomPainter {
  final WeightAnalysisModel data;
  final double strokeWidth;

  WeightChartPainter({
    required this.data,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // 定义颜色
    final colors = [
      Color(0xFF4ECDC4), // 体脂肪重
      Color(0xFF95E1D3), // 身体总水重
      Color(0xFFB8E6B8), // 蛋白质量
      Color(0xFFD3D3D3), // 矿物质量
    ];

    // 计算各部分的角度
    final percentages = [
      data.bodyFatPercentage,
      data.bodyWaterPercentage,
      data.proteinPercentage,
      data.mineralPercentage,
    ];

    double startAngle = -90 * (3.14159 / 180); // 从顶部开始

    for (int i = 0; i < percentages.length; i++) {
      final sweepAngle = percentages[i] * 2 * 3.14159;
      
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.square;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}