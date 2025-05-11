import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/app_export.dart';

/// 支援 GetX 流程並可動態啟用/停用滑動
class RulerPicker extends StatefulWidget {
  /// 外部使用 RxDouble 綁定值
  final RxDouble initialValue;

  /// 外部使用 RxBool 控制是否可滑動
  final RxBool enabled;
  final double min;
  final double max;
  final double step; // 每格增量，可設 1.0 或 0.1
  final ValueChanged<double>? onValueChanged;
  final double height;
  final double unitWidth;

  const RulerPicker({
    Key? key,
    required this.initialValue,
    required this.enabled,
    required this.min,
    required this.max,
    this.step = 1.0,
    this.onValueChanged,
    this.height = 60.0,
    this.unitWidth = 8.0,
  }) : super(key: key);

  @override
  _RulerPickerState createState() => _RulerPickerState();
}

class _RulerPickerState extends State<RulerPicker> {
  late final ScrollController _controller;
  late double _currentValue;
  late bool _enabled;
  late final StreamSubscription<double> _valueSub;
  late final StreamSubscription<bool> _enabledSub;
  late double _viewWidth;

  @override
  void initState() {
    super.initState();
    _enabled = widget.enabled.value;
    _controller = ScrollController();
    _controller.addListener(_onScroll);

    // 初始對齊到外部 value
    _currentValue = _align(widget.initialValue.value);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _jumpTo(_currentValue);
    });

    // 當外部 value 變動時自動跳定位
    _valueSub = widget.initialValue.listen((v) {
      final aligned = _align(v);
      if (aligned != _currentValue) {
        _currentValue = aligned;
        _jumpTo(aligned);
      }
    });

    // 當 enabled 變動時更新本地狀態
    _enabledSub = widget.enabled.listen((e) {
      setState(() {
        _enabled = e;
      });
    });
  }

  double _align(double v) {
    final clamped = v.clamp(widget.min, widget.max);
    final idx = ((clamped - widget.min) / widget.step).round();
    return double.parse((widget.min + idx * widget.step).toStringAsFixed(1));
  }

  void _jumpTo(double v) {
    final idx = ((v - widget.min) / widget.step).round();
    final offset = idx * widget.unitWidth;
    _controller.jumpTo(offset);
  }

  void _onScroll() {
    if (!_enabled) return;
    final idx = (_controller.offset / widget.unitWidth).round();
    double val = widget.min + idx * widget.step;
    val = _align(val);
    if (val != _currentValue) {
      setState(() => _currentValue = val);
      widget.initialValue.value = val;
      widget.onValueChanged?.call(val);
    }
  }

  void _snapToTick() {
    if (!_enabled) return;
    final idx = ((_currentValue - widget.min) / widget.step).round();
    final target = idx * widget.unitWidth;
    _controller
        .animateTo(
      target,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    )
        .then((_) {
      // 滑動結束後可視狀態更新（如需）
    });
  }

  @override
  void dispose() {
    _valueSub.cancel();
    _enabledSub.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, cs) {
      _viewWidth = cs.maxWidth;
      final sidePad = _viewWidth / 2;
      final total = ((widget.max - widget.min) / widget.step).round();
      final width = total * widget.unitWidth;

      return GestureDetector(
        onPanEnd: (_) => _snapToTick(),
        child: ClipRRect(
          child: Container(
            color: Colors.white,
            height: widget.height + 20,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SingleChildScrollView(
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    physics: _enabled
                        ? const ClampingScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: sidePad),
                      child: CustomPaint(
                        size: Size(width, widget.height),
                        painter: _DecimalRulerPainter(
                          min: widget.min,
                          max: widget.max,
                          step: widget.step,
                          spacing: widget.unitWidth,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: CustomPaint(
                    size: const Size(12, 6),
                    painter: _TrianglePainter(color: const Color(0xFF45B3C5)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

/// 刻度畫家 (同原版)
class _DecimalRulerPainter extends CustomPainter {
  final double min, max, step, spacing;
  _DecimalRulerPainter({
    required this.min,
    required this.max,
    required this.step,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFFF2F2F2),
    );
    final tickPaint = Paint()..color = Colors.grey.shade600;
    final total = ((max - min) / step).round();
    final major = step < 1.0 ? (1.0 / step).round() : 10;
    final mid = major ~/ 2;
    for (int i = 0; i <= total; i++) {
      final x = i * spacing;
      final val = min + i * step;
      double h, w;
      if (i % major == 0) {
        h = 21.v;
        w = 2.0;
      } else if (i % mid == 0) {
        h = 14.v;
        w = 1.5;
      } else {
        h = 8.v;
        w = 1.0;
      }
      tickPaint.strokeWidth = w;
      canvas.drawLine(Offset(x, 0), Offset(x, h), tickPaint);
      if (i % major == 0) {
        final text =
            step < 1.0 ? val.toStringAsFixed(1) : val.toStringAsFixed(0);
        final tp = TextPainter(
          text: TextSpan(
            text: text,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        tp.paint(canvas, Offset(x - tp.width / 2, h + 4));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = color;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
