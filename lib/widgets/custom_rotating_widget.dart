import 'package:flutter/material.dart';

class CustomRotatingWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const CustomRotatingWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  _CustomRotatingWidgetState createState() => _CustomRotatingWidgetState();
}

class _CustomRotatingWidgetState extends State<CustomRotatingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }
}