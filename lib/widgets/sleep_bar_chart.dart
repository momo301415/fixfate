import 'package:flutter/material.dart';

/// 封裝的睡眠階段條狀圖 Widget
/// 封裝 CustomPaint 的睡眠時間軸橫條圖元件
class SleepTimelineBarChartWidget extends StatelessWidget {
  final List<SleepSegment> segments;
  final double barHeight;
  final double pixelsPerMinute;
  final Map<SleepStage, Color>? stageColors; // 可選的自訂顏色映射

  const SleepTimelineBarChartWidget({
    Key? key,
    required this.segments,
    this.barHeight = 20.0,
    this.pixelsPerMinute = 3.0,
    this.stageColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 計算總持續時間（分鐘）
    int totalMinutes =
        segments.map((seg) => seg.duration.inMinutes).fold(0, (a, b) => a + b);
    // 根據總分鐘數計算繪圖需要的總寬度
    double totalWidth = totalMinutes * pixelsPerMinute;

    return SizedBox(
      width: totalWidth,
      height: barHeight * 4, // 四個階段的垂直總高度 (清醒、REM、淺睡、深睡)
      child: CustomPaint(
        size: Size(totalWidth, barHeight * 4),
        painter: SleepTimelinePainter(
          segments: segments,
          barHeight: barHeight,
          pixelsPerMinute: pixelsPerMinute,
          customStageColor: stageColors,
        ),
      ),
    );
  }
}

/// 自訂畫家，用於繪製睡眠時間軸橫條圖
class SleepTimelinePainter extends CustomPainter {
  final List<SleepSegment> segments;
  final double barHeight;
  final double pixelsPerMinute;
  final Map<SleepStage, Color> stageColor;

  SleepTimelinePainter({
    required this.segments,
    this.barHeight = 20.0,
    this.pixelsPerMinute = 3.0,
    Map<SleepStage, Color>? customStageColor,
  }) : stageColor = customStageColor ??
            {
              // 預設藍色系配色，可自訂
              SleepStage.awake: Color(0xFF90E0EF), // 淡藍 (清醒)
              SleepStage.rem: Color(0xFF3DDCFF), // 亮藍 (快速動眼期)
              SleepStage.light: Color(0xFF219EBC), // 藍色 (淺睡)
              SleepStage.deep: Color(0xFF123E48), // 深藍 (深睡)
            };

  @override
  void paint(Canvas canvas, Size size) {
    double xOffset = 0.0;
    final Paint paint = Paint()..style = PaintingStyle.fill;

    // 繪製每個睡眠階段的矩形區塊
    for (var segment in segments) {
      // 決定此段的顏色
      paint.color = stageColor[segment.stage] ?? Colors.blue;
      // 計算此段的寬度（分鐘數 * 每分鐘像素比例）
      double segmentWidth = segment.duration.inMinutes * pixelsPerMinute;

      // 計算此段的垂直位置 (依睡眠階段決定列的位置)
      double yOffset;
      switch (segment.stage) {
        case SleepStage.awake:
          yOffset = 0.0;
          break;
        case SleepStage.rem:
          yOffset = barHeight;
          break;
        case SleepStage.light:
          yOffset = barHeight * 2;
          break;
        case SleepStage.deep:
          yOffset = barHeight * 3;
          break;
      }

      // 繪製代表該睡眠區段的矩形
      Rect rect = Rect.fromLTWH(xOffset, yOffset, segmentWidth, barHeight);
      canvas.drawRect(rect, paint);

      // 水平位移累加，緊接畫下一個區段
      xOffset += segmentWidth;
    }
  }

  @override
  bool shouldRepaint(covariant SleepTimelinePainter oldDelegate) {
    // 當資料列表或相關參數改變時才重繪
    return oldDelegate.segments != segments ||
        oldDelegate.barHeight != barHeight ||
        oldDelegate.pixelsPerMinute != pixelsPerMinute ||
        oldDelegate.stageColor != stageColor;
  }
}

/// 睡眠階段類型列舉
enum SleepStage {
  awake, // 清醒
  rem, // 快速動眼期
  light, // 淺睡
  deep // 深睡
}

/// 單一睡眠階段區段的資料模型
class SleepSegment {
  final SleepStage stage; // 此區段的睡眠階段類型
  final Duration duration; // 此區段持續時間

  SleepSegment({
    required this.stage,
    required this.duration,
  });
}
