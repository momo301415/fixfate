import 'package:flutter/material.dart';

/// 封裝的睡眠階段條狀圖 Widget
/// 封裝 CustomPaint 的睡眠時間軸橫條圖元件
class SleepTimelineBarChartWidget extends StatelessWidget {
  final List<SleepSegment> segments;
  final double barHeight;
  final Map<SleepStage, Color>? stageColors;

  const SleepTimelineBarChartWidget({
    Key? key,
    required this.segments,
    this.barHeight = 20.0,
    this.stageColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final totalMinutes = segments.fold<int>(
      0,
      (sum, segment) => sum + segment.duration.inMinutes,
    );

    final pixelsPerMinute = totalMinutes > 0 ? screenWidth / totalMinutes : 1.0;
    final clampedPixelsPerMinute = pixelsPerMinute.clamp(1.0, 10.0);
    final totalWidth = totalMinutes * clampedPixelsPerMinute;

    return SizedBox(
      width: totalWidth,
      height: barHeight * 4,
      child: CustomPaint(
        painter: SleepTimelinePainter(
          segments: segments,
          barHeight: barHeight,
          totalWidth: totalWidth,
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
  final double totalWidth;
  final Map<SleepStage, Color> stageColor;

  SleepTimelinePainter({
    required this.segments,
    required this.barHeight,
    required this.totalWidth,
    Map<SleepStage, Color>? customStageColor,
  }) : stageColor = customStageColor ??
            {
              SleepStage.awake: Color(0xFF90E0EF),
              SleepStage.rem: Color(0xFF3DDCFF),
              SleepStage.light: Color(0xFF219EBC),
              SleepStage.deep: Color(0xFF123E48),
            };

  @override
  void paint(Canvas canvas, Size size) {
    final totalMinutes = segments.fold<int>(
      0,
      (sum, segment) => sum + segment.duration.inMinutes,
    );

    double xOffset = 0;
    final paint = Paint()..style = PaintingStyle.fill;

    for (var seg in segments) {
      paint.color = stageColor[seg.stage] ?? Colors.blue;
      final width = (seg.duration.inMinutes / totalMinutes) * totalWidth;

      double yOffset;
      switch (seg.stage) {
        case SleepStage.awake:
          yOffset = 0;
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

      final rect = Rect.fromLTWH(xOffset, yOffset, width, barHeight);
      canvas.drawRect(rect, paint);
      xOffset += width;
    }
  }

  @override
  bool shouldRepaint(covariant SleepTimelinePainter oldDelegate) {
    return oldDelegate.segments != segments ||
        oldDelegate.totalWidth != totalWidth ||
        oldDelegate.barHeight != barHeight;
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
