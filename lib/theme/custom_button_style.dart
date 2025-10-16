import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillPrimaryTL20 => ElevatedButton.styleFrom(
    backgroundColor: theme.colorScheme.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.h)),
    elevation: 0,
    padding: EdgeInsets.zero,
  );
  static ButtonStyle get fillSecondaryContainer => ElevatedButton.styleFrom(
    backgroundColor: theme.colorScheme.secondaryContainer,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    elevation: 0,
    padding: EdgeInsets.zero,
  );
  // Outline button style
  static ButtonStyle get outlineBlack => ElevatedButton.styleFrom(
    backgroundColor: theme.colorScheme.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.h)),
    shadowColor: appTheme.black900.withValues(alpha: 0.08),
    elevation: 4,
    padding: EdgeInsets.zero,
  );
  // text button style
  static ButtonStyle get none => ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
    elevation: WidgetStateProperty.all<double>(0),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
    side: WidgetStateProperty.all<BorderSide>(
      BorderSide(color: Colors.transparent),
    ),
  );
}
