import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/success_modal_controller.dart'; // ignore_for_file: must_be_immutable

class SuccessModalScreen extends GetWidget<SuccessModalController> {
  const SuccessModalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.blueGray50,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 62.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(flex: 59),
              _buildConfirmationMessage(),
              Spacer(flex: 40),
              CustomElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                },
                text: "lbl_scan_another2".tr,
                leftIcon: Container(
                  margin: EdgeInsets.only(right: 16.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgTelevision,
                    height: 18.h,
                    width: 18.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 26.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgAngleLeftPrimary,
                    height: 24.h,
                    width: 24.h,
                  ),
                  GestureDetector(
                    onTap: () => Get.offAllNamed(AppRoutes.homeScreen),
                    child: Text(
                      "lbl_back_to_home".tr,
                      style: CustomTextStyles.titleMediumPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildConfirmationMessage() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      child: Column(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgCheck1,
            height: 100.h,
            width: 102.h,
          ),
          SizedBox(height: 34.h),
          Text("msg_congratulations".tr, style: theme.textTheme.headlineLarge),
          SizedBox(height: 14.h),
          Text(
            "msg_all_set_your".tr,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge!.copyWith(height: 1.38),
          ),
        ],
      ),
    );
  }
}
