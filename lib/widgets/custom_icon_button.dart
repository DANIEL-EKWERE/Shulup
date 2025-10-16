import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get outlineBlack => BoxDecoration(
    color: appTheme.whiteA700.withValues(alpha: 0.6),
    borderRadius: BorderRadius.circular(18.h),
    boxShadow: [
      BoxShadow(
        color: appTheme.black900.withValues(alpha: 0.08),
        spreadRadius: 2.h,
        blurRadius: 2.h,
        offset: Offset(0, 4),
      ),
    ],
  );
  static BoxDecoration get none => BoxDecoration();
}

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    Key? key,
    this.alignment,
    this.height,
    this.width,
    this.decoration,
    this.padding,
    this.onTap,
    this.child,
  }) : super(key: key);

  final Alignment? alignment;

  final double? height;

  final double? width;

  final BoxDecoration? decoration;

  final EdgeInsetsGeometry? padding;

  final VoidCallback? onTap;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
          alignment: alignment ?? Alignment.center,
          child: iconButtonWidget,
        )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
    height: height ?? 0,
    width: width ?? 0,
    child: DecoratedBox(
      decoration:
          decoration ??
          BoxDecoration(
            color: appTheme.whiteA700,
            borderRadius: BorderRadius.circular(16.h),
            boxShadow: [
              BoxShadow(
                color: appTheme.black900.withValues(alpha: 0.08),
                spreadRadius: 2.h,
                blurRadius: 2.h,
                offset: Offset(0, 4),
              ),
            ],
          ),
      child: IconButton(
        padding: padding ?? EdgeInsets.zero,
        onPressed: onTap,
        icon: child ?? Container(),
      ),
    ),
  );
}
