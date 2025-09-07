import 'package:flutter/material.dart';
import '../core/app_export.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // The current app theme
  var _appTheme = PrefUtils().getThemeData();

// A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    PrefUtils().setThemeData(_newTheme);
    Get.forceAppUpdate();
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.h),
          ),
          shadowColor: colorScheme.secondaryContainer,
          elevation: 4,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: colorScheme.primary,
            width: 1.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return Colors.transparent;
        }),
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.gray300,
      ),
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: colorScheme.errorContainer,
          fontSize: 17.fSize,
          fontFamily: 'PingFang TC',
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: colorScheme.errorContainer,
          fontSize: 14.fSize,
          fontFamily: 'PingFang TC',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: colorScheme.errorContainer,
          fontSize: 12.fSize,
          fontFamily: 'PingFang TC',
          fontWeight: FontWeight.w400,
        ),
        displaySmall: TextStyle(
          color: colorScheme.errorContainer,
          fontSize: 36.fSize,
          fontFamily: 'PingFang TC',
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: TextStyle(
          color: colorScheme.errorContainer,
          fontSize: 32.fSize,
          fontFamily: 'PingFang TC',
          fontWeight: FontWeight.w500,
        ),
        headlineMedium: TextStyle(
          color: colorScheme.errorContainer,
          fontSize: 28.fSize,
          fontFamily: 'PingFang TC',
          fontWeight: FontWeight.w500,
        ),
        labelLarge: TextStyle(
          color: colorScheme.errorContainer,
          fontSize: 12.fSize,
          fontFamily: 'PingFang TC',
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: appTheme.gray500,
          fontSize: 10.fSize,
          fontFamily: 'PingFang TC',
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          color: colorScheme.primary,
          fontSize: 21.fSize,
          fontFamily: 'PingFang TC',
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 18.fSize,
          fontFamily: 'PingFang TC',
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: colorScheme.primaryContainer,
          fontSize: 15.fSize,
          fontFamily: 'PingFang TC',
          fontWeight: FontWeight.w500,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light(
    primary: Color(0XFF26A5BB),
    primaryContainer: Color(0XFF262626),
    secondaryContainer: Color(0X4C26A5BB),
    errorContainer: Color(0XFF525252),
    onError: Color(0XFFEA6839),
    onErrorContainer: Color(0XFF00161A),
    onPrimary: Color(0XFF00171B),
    onPrimaryContainer: Color(0XFFD8D9E0),
  );
}

/// Class containing custom colors for a lightCode theme.
class LightCodeColors {
  // Black
  Color get black900 => Color(0XFF000000);
// BlueGray
  Color get blueGray100 => Color(0XFFCFCFCF);
  Color get blueGray10001 => Color(0XFFCCCCCC);
  Color get blueGray200 => Color(0XFFABADB6);
  Color get blueGray400 => Color(0XFF878787);
  Color get blueGray900 => Color(0XFF333333);
  Color get blueGray90001 => Color(0XFF0D3238);
  Color get gray90066 => Color(0X660A2226);
// Cyan
  Color get cyan300 => Color(0XFF61CCDF);
  Color get cyan30001 => Color(0XFF4CD4EB);
  Color get cyan50 => Color(0XFFE8FAFC);
  Color get cyan700 => Color(0XFF1892A7);
  Color get cyan8007e => Color(0X7E1F8598);
  Color get cyan900 => Color(0XFF0F5966);
  Color get cyan90001 => Color(0XFF236874);
  Color get cyan90002 => Color(0XFF135D6A);
  Color get cyanA100 => Color(0XFF91EFFF);
  Color get cyan70001 => Color(0XFF1693A9);
// DeepOrange
  Color get deepOrangeA200 => Color(0XFFEA6939);
// Gray
  Color get gray200 => Color(0XFFF0F0F0);
  Color get teal5001 => Color(0XFFD2EAEE);
  Color get gray20001 => Color(0XFFEEEEEE);
  Color get gray300 => Color(0XFFE5E5E5);
  Color get gray30001 => Color(0XFFE3E4E8);
  Color get gray30066 => Color(0X66E3E3E3);
  Color get gray300C0 => Color(0XC0E6E6E6);
  Color get gray500 => Color(0XFFA3A3A3);
  Color get gray50001 => Color(0XFF999999);
  Color get gray50002 => Color(0XFFAAAAAA);
  Color get gray600 => Color(0XFF757575);
  Color get gray60028 => Color(0X28787880);
  Color get gray6004c => Color(0X4C7A7A7A);
  Color get gray700 => Color(0XFF666666);
  Color get gray800 => Color(0XFF4C4C4C);
  Color get gray900 => Color(0XFF052328);
  Color get gray80032 => Color(0X323B3838);
// Indigo
  Color get indigoA200 => Color(0XFF5277F7);
// LightBlue
  Color get lightBlue50 => Color(0XFFEAFBFF);
  Color get blue50 => Color(0XFFEAF5FB);
// Red
  Color get redA200 => Color(0XFFFF5757);
// Teal
  Color get teal100 => Color(0XFFB1D1D6);
  Color get teal900 => Color(0XFF0E434D);
  Color get teal2007f => Color(0X7F82C1BB);
  Color get teal2007f01 => Color(0X7F79C0CC);
  Color get teal3007f => Color(0X7F4EB6C8);
  Color get teal400 => Color(0XFF11AF9C);
  Color get teal4007e => Color(0X7E208698);
  Color get teal50 => Color(0XFFD2EAED);
   Color get teal5003 => Color(0XFFD2EDF1);
// White
  Color get whiteA700 => Color(0XFFFFFFFF);
// Yellow
  Color get yellow700 => Color(0XFFF2C939);
}
