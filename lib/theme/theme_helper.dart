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
    'lightCode': LightCodeColors(),
  };

  // A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme,
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
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.h),
          ),
          elevation: 0,
          visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(color: appTheme.gray600, width: 1.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.h),
          ),
          visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
          padding: EdgeInsets.zero,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return Colors.transparent;
        }),
        side: BorderSide(color: appTheme.gray300, width: 1),
        visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
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
      color: appTheme.black900,
      fontSize: 16.fSize,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      color: appTheme.black900,
      fontSize: 14.fSize,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: appTheme.black900,
      fontSize: 9.fSize,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: TextStyle(
      color: appTheme.black900,
      fontSize: 32.fSize,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      color: appTheme.black900,
      fontSize: 24.fSize,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
    ),
    labelLarge: TextStyle(
      color: appTheme.black900.withValues(alpha: 0.5),
      fontSize: 12.fSize,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      color: appTheme.black900,
      fontSize: 11.fSize,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      color: appTheme.black900,
      fontSize: 20.fSize,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      color: appTheme.whiteA700,
      fontSize: 16.fSize,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      color: appTheme.whiteA700,
      fontSize: 14.fSize,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
    ),
  );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light(
    primary: Color(0XFFFF9741),
    secondaryContainer: Color(0X33007BFF),
    onPrimary: Color(0XFF1E1E1E),
  );
}

/// Class containing custom colors for a lightCode theme.
class LightCodeColors {
  // Black
  Color get black900 => Color(0XFF000000);
  // Blue
  Color get blue200 => Color(0XFFA3D0FF);
  // BlueGray
  Color get blueGray40026 => Color(0X268F8A86);
  Color get blueGray50 => Color(0XFFEEF1F0);
  // Gray
  Color get gray300 => Color(0XFFE3E4E8);
  Color get gray30001 => Color(0XFFE0E2E0);
  Color get gray600 => Color(0XFF808080);
  // Green
  Color get green600 => Color(0XFF28A745);
  // Red
  Color get red600 => Color(0XFFDC3545);
  // White
  Color get whiteA700 => Color(0XFFFFFFFF);
  // Yellow
  Color get yellow900 => Color(0XFFFD7E14);
}
