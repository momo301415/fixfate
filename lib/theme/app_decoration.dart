import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import '../core/app_export.dart';

class AppDecoration {
  // F decorations
  static BoxDecoration get ff => BoxDecoration(
        color: theme.colorScheme.primary,
      );
  static BoxDecoration get ffff => BoxDecoration(
        color: theme.colorScheme.primary,
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 1.h,
        ),
      );
// Fill decorations
  static BoxDecoration get fillDeepOrangeA => BoxDecoration(
        color: appTheme.deepOrangeA200,
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray800,
      );
  static BoxDecoration get fillGray30066 => BoxDecoration(
        color: appTheme.gray30066,
      );
  static BoxDecoration get fillOnError => BoxDecoration(
        color: theme.colorScheme.onError,
      );
  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary,
      );
  static BoxDecoration get fillTeal => BoxDecoration(
        color: appTheme.teal50,
      );
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );
  static BoxDecoration get fillBlueGray =>
      BoxDecoration(color: appTheme.blueGray90001);
// Gradient decorations，splash page
  static BoxDecoration get gradientCyanToOnErrorContainer => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [appTheme.cyan900, theme.colorScheme.onErrorContainer],
        ),
        image: DecorationImage(
          image: AssetImage(
            ImageConstant.imgVector,
          ),
          fit: BoxFit.cover,
        ),
      );
  static BoxDecoration get gradientLightBlueToOnErrorContainer => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            appTheme.lightBlue50,
            appTheme.cyan700,
            theme.colorScheme.onErrorContainer
          ],
        ),
        // image: DecorationImage(
        //   image: AssetImage(
        //     ImageConstant.img0x0,
        //   ),
        //   fit: BoxFit.fill,
        // ),
      );
// Gray decorations
  static BoxDecoration get gray100 => BoxDecoration(
        color: appTheme.gray200,
      );
  static BoxDecoration get gray50 => BoxDecoration(
        color: appTheme.whiteA700,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withValues(
              alpha: 0.15,
            ),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          )
        ],
      );
  static BoxDecoration get gray50FF => BoxDecoration(
        color: theme.colorScheme.primary,
        border: Border.all(
          color: appTheme.whiteA700,
          width: 1.h,
        ),
      );
  static BoxDecoration get gray600 => BoxDecoration(
        color: theme.colorScheme.errorContainer,
      );
// Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration(
        color: appTheme.gray200,
        border: Border.all(
          color: appTheme.black900.withValues(
            alpha: 0.1,
          ),
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineBlueGray => BoxDecoration(
        border: Border.all(
          color: appTheme.blueGray100,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineGray => BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appTheme.gray200,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineGray200 => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          bottom: BorderSide(
            color: appTheme.gray200,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineGray20001 => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border.all(
          color: appTheme.gray20001,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineGray90066 => BoxDecoration(
        boxShadow: [
          BoxShadow(color: appTheme.gray90066),
          BoxShadow(
            color: appTheme.whiteA700,
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      );
  static BoxDecoration get outlineGrayC => BoxDecoration(
        color: appTheme.whiteA700,
        boxShadow: [
          BoxShadow(
            color: appTheme.gray300C0,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          )
        ],
      );
// Column decorations
  static BoxDecoration get column10 => BoxDecoration(
        image: DecorationImage(
          image: fs.Svg(
            ImageConstant.imgUnion,
          ),
          fit: BoxFit.fill,
        ),
      );
  static BoxDecoration get column11 => BoxDecoration(
        image: DecorationImage(
          image: fs.Svg(
            ImageConstant.imgUnion,
          ),
          fit: BoxFit.fill,
        ),
      );
  static BoxDecoration get column14 => BoxDecoration(
        image: DecorationImage(
          image: fs.Svg(
            ImageConstant.imgUnion,
          ),
          fit: BoxFit.fill,
        ),
      );
  static BoxDecoration get column15 => BoxDecoration(
        image: DecorationImage(
          image: fs.Svg(
            ImageConstant.imgUnionWhiteA700157x180,
          ),
          fit: BoxFit.fill,
        ),
      );
  static BoxDecoration get column16 => BoxDecoration(
        image: DecorationImage(
          image: fs.Svg(
            ImageConstant.imgUnionWhiteA700157x180,
          ),
          fit: BoxFit.fill,
        ),
      );
  static BoxDecoration get column17 => BoxDecoration(
        image: DecorationImage(
          image: fs.Svg(
            ImageConstant.imgUnionWhiteA700157x180,
          ),
          fit: BoxFit.fill,
        ),
      );
  static BoxDecoration get column18 => BoxDecoration(
        image: DecorationImage(
          image: fs.Svg(
            ImageConstant.imgUnionWhiteA700157x180,
          ),
          fit: BoxFit.fill,
        ),
      );
  static BoxDecoration get column19 => BoxDecoration(
        image: DecorationImage(
          image: fs.Svg(
            ImageConstant.imgUnion,
          ),
          fit: BoxFit.fill,
        ),
      );
  static BoxDecoration get column26 => BoxDecoration(
        image: DecorationImage(
          image: fs.Svg(
            ImageConstant.imgUnion,
          ),
          fit: BoxFit.fill,
        ),
      );
  static BoxDecoration get column3 => BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ImageConstant.imgUnionWhiteA700,
          ),
          fit: BoxFit.fill,
        ),
      );
  static BoxDecoration get column31 => BoxDecoration(
        image: DecorationImage(
          image: fs.Svg(
            ImageConstant.imgSubtract,
          ),
          fit: BoxFit.fill,
        ),
      );
  static BoxDecoration get column4 => BoxDecoration(
        image: DecorationImage(
          image: fs.Svg(
            ImageConstant.imgUnion,
          ),
          fit: BoxFit.fill,
        ),
      );
  static BoxDecoration get column5 => BoxDecoration(
        image: DecorationImage(
          image: fs.Svg(
            ImageConstant.imgUnion,
          ),
          fit: BoxFit.fill,
        ),
      );
  static BoxDecoration get column7 => BoxDecoration(
        image: DecorationImage(
          image: fs.Svg(
            ImageConstant.imgUnion,
          ),
          fit: BoxFit.fill,
        ),
      );
  static BoxDecoration get column9 => BoxDecoration(
        image: DecorationImage(
          image: fs.Svg(
            ImageConstant.imgUnion,
          ),
          fit: BoxFit.fill,
        ),
      );
  static BoxDecoration get outlineGray2001 => BoxDecoration(
        border: Border(
          right: BorderSide(
            color: appTheme.gray200.withValues(alpha: 0.3),
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineBlack900 => BoxDecoration(
        color: appTheme.teal900,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withValues(alpha: 0.3),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(0, 4),
          ),
        ],
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder12 => BorderRadius.circular(
        12.h,
      );
  static BorderRadius get circleBorder2 => BorderRadius.circular(
        2.h,
      );
  static BorderRadius get circleBorder20 => BorderRadius.circular(
        20.h,
      );
  static BorderRadius get circleBorder32 => BorderRadius.circular(32.h);
  static BorderRadius get circleBorder48 => BorderRadius.circular(
        48.h,
      );
// Custom borders
  static BorderRadius get customBorderTL12 => BorderRadius.vertical(
        top: Radius.circular(12.h),
      );
  static BorderRadius get customBorderTL161 => BorderRadius.only(
        topLeft: Radius.circular(16.h),
        topRight: Radius.circular(16.h),
        bottomRight: Radius.circular(16.h),
      );
// Rounded borders
  static BorderRadius get roundedBorder16 => BorderRadius.circular(
        16.h,
      );
  static BorderRadius get roundedBorder24 => BorderRadius.circular(
        24.h,
      );
  static BorderRadius get roundedBorder8 => BorderRadius.circular(
        8.h,
      );
}
