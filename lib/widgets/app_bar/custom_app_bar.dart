import 'package:flutter/material.dart';
import '../../core/app_export.dart';

enum Style { bgOutlineGray200, bgFillOnPrimary }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {Key? key,
      this.height,
      this.shape,
      this.styleType,
      this.leadingWidth,
      this.leading,
      this.title,
      this.centerTitle,
      this.actions})
      : super(
          key: key,
        );

  final double? height;

  final ShapeBorder? shape;

  final Style? styleType;

  final double? leadingWidth;

  final Widget? leading;

  final Widget? title;

  final bool? centerTitle;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      shape: shape,
      toolbarHeight: height ?? 28.h,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        SizeUtils.width,
        height ?? 28.h,
      );
  _getStyle() {
    switch (styleType) {
      case Style.bgOutlineGray200:
        return Container(
          height: 40.h,
          width: 310.h,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: appTheme.gray200,
                width: 1.h,
              ),
            ),
          ),
        );
      case Style.bgFillOnPrimary:
        return Container(
          height: 56.h,
          width: 374.h,
          decoration: BoxDecoration(color: theme.colorScheme.onPrimary),
        );
      default:
        return null;
    }
  }
}
