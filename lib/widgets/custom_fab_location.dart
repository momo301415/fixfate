import 'package:flutter/material.dart';

class CustomFABLocation extends FloatingActionButtonLocation {
  final double bottom;
  final double right;

  CustomFABLocation({required this.bottom, required this.right});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry layout) {
    return Offset(
      layout.scaffoldSize.width - right - layout.floatingActionButtonSize.width,
      layout.scaffoldSize.height -
          bottom -
          layout.floatingActionButtonSize.height,
    );
  }
}
