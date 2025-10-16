import 'package:flutter/material.dart';
import '../core/app_export.dart';

class AppDecoration {
  // Elevation decorations
  static BoxDecoration get elevation1 => BoxDecoration(
    color: theme.colorScheme.primary,
    boxShadow: [
      BoxShadow(
        color: appTheme.black900.withValues(alpha: 0.08),
        spreadRadius: 2.h,
        blurRadius: 2.h,
        offset: Offset(0, 4),
      ),
    ],
  );
  // Fill decorations
  static BoxDecoration get fillBlack =>
      BoxDecoration(color: appTheme.black900.withValues(alpha: 0.15));
  static BoxDecoration get fillBlue => BoxDecoration(color: appTheme.blue200);
  static BoxDecoration get fillBlueGray =>
      BoxDecoration(color: appTheme.blueGray50);
  static BoxDecoration get fillPrimary =>
      BoxDecoration(color: theme.colorScheme.primary.withValues(alpha: 0.1));
  static BoxDecoration get fillPrimary1 =>
      BoxDecoration(color: theme.colorScheme.primary.withValues(alpha: 0.2));
      static BoxDecoration get fillPrimaryx =>
      BoxDecoration(color: theme.colorScheme.primary.withValues(alpha: 1));
  static BoxDecoration get fillWhiteA =>
      BoxDecoration(color: appTheme.whiteA700);
  // Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration(
    color: appTheme.whiteA700,
    boxShadow: [
      BoxShadow(
        color: appTheme.black900.withValues(alpha: 0.08),
        spreadRadius: 2.h,
        blurRadius: 2.h,
        offset: Offset(0, 4),
      ),
    ],
  );
  static BoxDecoration get outlineGray => BoxDecoration(
    color: appTheme.whiteA700,
    border: Border(right: BorderSide(color: appTheme.gray30001, width: 1.h)),
  );
  static BoxDecoration get outlinePrimary => BoxDecoration(
    border: Border.all(
      color: theme.colorScheme.primary.withValues(alpha: 0.5),
      width: 1.h,
    ),
  );
  // Column decorations
  static BoxDecoration get column9 => BoxDecoration(
    image: DecorationImage(
      image: AssetImage(ImageConstant.imgLandmarks),
      fit: BoxFit.fill,
    ),
  );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder38 => BorderRadius.circular(38.h);
  // Custom borders
  static BorderRadius get customBorderLR4 =>
      BorderRadius.only(topRight: Radius.circular(4.h));
  static BorderRadius get customBorderTL4 =>
      BorderRadius.vertical(top: Radius.circular(4.h));
  static BorderRadius get customBorderTL41 =>
      BorderRadius.only(topLeft: Radius.circular(4.h));
  // Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(10.h);
  static BorderRadius get roundedBorder16 => BorderRadius.circular(16.h);
  static BorderRadius get roundedBorder6 => BorderRadius.circular(6.h);
}
