import 'package:flutter/material.dart';
import 'package:schulup/presentation/iphone_13_14_five_screen/controller/iphone_13_14_five_controller.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image_one.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/app_bar/appbar_subtitle_three.dart';
import '../../widgets/app_bar/appbar_trailing_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';


class Iphone1314FiveScreen extends GetWidget<Iphone1314FiveController> {
  const Iphone1314FiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFD7E14),
      body: Center(
        child: Image.asset(
          ImageConstant.imgSchulupLogo1,
          height: 100.h,
          width: 100.h,
          fit: BoxFit.cover,
        ),
      ),
      // body: SafeArea(
      //   child: Container(
      //     height: double.infinity,
      //     width: double.infinity,
      //     color: Color(0XFFFD7E14),
          
      //   ),
      // ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: 52.h,
      leadingWidth: 52.h,
      leading: AppbarLeadingImageOne(
        imagePath: ImageConstant.imgEllipse1,
        height: 36.h,
        width: 36.h,
        margin: EdgeInsets.only(left: 16.h, top: 8.h, bottom: 8.h),
      ),
      centerTitle: true,
      title: Column(
        children: [
          AppbarSubtitleThree(
            text: "lbl_your_location".tr,
            margin: EdgeInsets.only(left: 22.h, right: 21.h),
          ),
          AppbarSubtitleOne(text: "msg_juma_mall_ikeja".tr),
        ],
      ),
      actions: [
        AppbarTrailingIconbutton(
          imagePath: ImageConstant.imgApps1Primary,
          margin: EdgeInsets.only(top: 10.h, right: 16.h, bottom: 10.h),
        ),
      ],
      styleType: Style.bgShadowBlack900,
    );
  }

  /// Navigates to the previous screen.
  onTapBtnArrowleftone() {
    Get.back();
  }
}
