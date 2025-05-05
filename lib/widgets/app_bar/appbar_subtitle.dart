import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class AppbarSubtitle extends StatelessWidget {
  final String text;
  final Function? onTap;
  final EdgeInsetsGeometry? margin;

  const AppbarSubtitle({
    Key? key,
    required this.text,
    this.onTap,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: () => onTap?.call(),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium!.copyWith(
            color: appTheme.whiteA700,
          ),
        ),
      ),
    );
  }
}
