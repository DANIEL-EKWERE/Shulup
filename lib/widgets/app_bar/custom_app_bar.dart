import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/app_export.dart';

enum Style { bgShadowBlack900 }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.height,
    this.shape,
    this.styleType,
    this.leadingWidth,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
  }) : super(key: key);

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
    // Add this at the top of your custom AppBar's build method
SystemChrome.setSystemUIOverlayStyle(
  const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ),
);
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ),

      foregroundColor: Colors.black,
      elevation: 0,
      shape: shape,
      toolbarHeight: height ?? 56.h,
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
  Size get preferredSize => Size(SizeUtils.width, height ?? 56.h);
  _getStyle() {
    switch (styleType) {
      case Style.bgShadowBlack900:
        return Container(
          height: 52.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: appTheme.whiteA700,
            boxShadow: [
              BoxShadow(
                color: appTheme.black900.withValues(alpha: 0.08),
                spreadRadius: 2.h,
                blurRadius: 2.h,
                offset: Offset(0, 4),
              ),
            ],
          ),
        );
      default:
        return null;
    }
  }
}
