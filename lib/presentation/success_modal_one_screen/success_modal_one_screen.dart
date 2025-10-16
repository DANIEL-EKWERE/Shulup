import 'package:flutter/material.dart';
import 'package:schulup/presentation/success_modal_one_screen/controller/success_modal_one_controller.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
// import '../success_model_one_screen/controller/success_modal_one_controller.dart'; // ignore_for_file: must_be_immutable

class SuccessModalOneScreen extends GetWidget<SuccessModalOneController> {
  const SuccessModalOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.blueGray50,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 62.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(flex: 59),
              CustomImageView(
                imagePath: ImageConstant.imgCheck1,
                height: 100.h,
                width: 102.h,
              ),
              SizedBox(height: 42.h),
              Text(
                "msg_school_code_updated".tr,
                style: CustomTextStyles.titleMediumBlack900_1,
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.maxFinite,
                child: Text(
                  "msg_you_re_now_connected".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge!.copyWith(height: 1.38),
                ),
              ),
              Spacer(flex: 40),
              CustomElevatedButton(text: "lbl_continue".tr),
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
                  Text(
                    "lbl_go_to_login".tr,
                    style: CustomTextStyles.titleMediumPrimary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
