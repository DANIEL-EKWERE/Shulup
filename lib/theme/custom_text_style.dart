import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension on TextStyle {
  TextStyle get interTight {
    return copyWith(fontFamily: 'Inter Tight');
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
  // Body text style
  static TextStyle get bodyMedium15 =>
      theme.textTheme.bodyMedium!.copyWith(fontSize: 15.fSize);
  static TextStyle get bodyMediumBlack900 => theme.textTheme.bodyMedium!
      .copyWith(color: appTheme.black900.withValues(alpha: 0.24));
  static TextStyle get bodySmall12 =>
      theme.textTheme.bodySmall!.copyWith(fontSize: 12.fSize);
  static TextStyle get bodySmallGreen600 =>
      theme.textTheme.bodySmall!.copyWith(color: appTheme.green600);
  static TextStyle get bodySmallRed600 => theme.textTheme.bodySmall!.copyWith(
    color: appTheme.red600,
    fontSize: 12.fSize,
  );
  static TextStyle get bodySmallRed600_1 =>
      theme.textTheme.bodySmall!.copyWith(color: appTheme.red600);
  static TextStyle get bodySmallSecondaryContainer =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.secondaryContainer.withValues(alpha: 1),
      );
  static TextStyle get bodySmallYellow900 =>
      theme.textTheme.bodySmall!.copyWith(color: appTheme.yellow900);

  static TextStyle get bodySmallBlue900 =>
      theme.textTheme.bodySmall!.copyWith(color: Colors.blue);    
  static TextStyle get bodySmallRed900 =>
      theme.textTheme.bodySmall!.copyWith(color: appTheme.red600);  
  static TextStyle get bodySmallGreen900 =>
      theme.textTheme.bodySmall!.copyWith(color: appTheme.green600);              
  // Headline style
  static get headlineLargeInterTight =>
      theme.textTheme.headlineLarge!.interTight;
  static get headlineSmallInterTight =>
      theme.textTheme.headlineSmall!.interTight;
  // Label text style
  static TextStyle get labelLargeBlack900 =>
      theme.textTheme.labelLarge!.copyWith(color: appTheme.black900);
  static TextStyle get labelLargeBlack900SemiBold => theme.textTheme.labelLarge!
      .copyWith(color: appTheme.black900, fontWeight: FontWeight.w600);
  // Title style
  static get titleLargeInterTight => theme.textTheme.titleLarge!.interTight;
  static TextStyle get titleLargeOnPrimary =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get titleMediumBlack900 => theme.textTheme.titleMedium!
      .copyWith(color: appTheme.black900, fontWeight: FontWeight.w700);
  static TextStyle get titleMediumBlack900_1 =>
      theme.textTheme.titleMedium!.copyWith(color: appTheme.black900);
  static TextStyle get titleMediumGray600 =>
      theme.textTheme.titleMedium!.copyWith(color: appTheme.gray600);
  static TextStyle get titleMediumPrimary =>
      theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.primary);
  static TextStyle get titleSmallBlack900 =>
      theme.textTheme.titleSmall!.copyWith(color: appTheme.black900);
  static TextStyle get titleSmallGray600 =>
      theme.textTheme.titleSmall!.copyWith(color: appTheme.gray600);
      static TextStyle get titleSmallwhiteA700 =>
      theme.textTheme.titleSmall!.copyWith(color: appTheme.whiteA700);
  static TextStyle get titleSmallPrimary =>
      theme.textTheme.titleSmall!.copyWith(color: theme.colorScheme.primary);
}
