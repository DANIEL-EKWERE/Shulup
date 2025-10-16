import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import 'controller/change_school_code_controller.dart';

// ignore_for_file: must_be_immutable
class ChangeSchoolCodeDialog extends StatelessWidget {
  ChangeSchoolCodeDialog(this.controller, {Key? key}) : super(key: key);

  ChangeSchoolCodeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 30.h),
            decoration: AppDecoration.fillWhiteA.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "msg_switching_to_a_new".tr,
                  style: CustomTextStyles.titleLargeInterTight,
                ),
                SizedBox(height: 10.h),
                Text(
                  "msg_you_re_about_to".tr,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodySmall12.copyWith(height: 1.67),
                ),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomOutlinedButton(
                      onPressed: () => Get.back(),
                      height: 42.h,
                      width: 112.h,
                      text: "lbl_cancel".tr,
                      buttonTextStyle: CustomTextStyles.titleSmallGray600,
                    ),
                    Spacer(),
                    CustomElevatedButton(
                      onPressed: () =>  controller.logout(),   //controller.secondLogin(),
                      height: 46.h,
                      width: 148.h,
                      text: "lbl_yes_continue".tr,
                      buttonTextStyle: theme.textTheme.titleSmall!,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
