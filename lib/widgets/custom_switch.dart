import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable

class CustomSwitch extends StatelessWidget {
  CustomSwitch({
    Key? key,
    required this.onChange,
    this.alignment,
    this.value,
    this.width,
    this.height,
    this.margin,
  }) : super(key: key);

  final Alignment? alignment;
  final bool? value;
  final Function(bool) onChange;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 31,
      width: width ?? 51,
      margin: margin,
      child: alignment != null
          ? Align(
              alignment: alignment ?? Alignment.center,
              child: switchWidget,
            )
          : switchWidget,
    );
  }

  Widget get switchWidget => CupertinoSwitch(
        value: value ?? false,
        onChanged: onChange,
        activeTrackColor: const Color(0xFF25A9B6), // 開啟背景
        inactiveTrackColor: const Color(0xFFD8D8D8), // 關閉背景
      );
}
