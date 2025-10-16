import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import 'controller/drop_off_scan_success_modal_controller.dart';

// ignore_for_file: must_be_immutable
class DropOffScanSuccessModalDialog extends StatelessWidget {
  DropOffScanSuccessModalDialog(
    this.controller,
    this.cardId,
    this.action, {
    Key? key,
  }) : super(key: key);

  String cardId;
  DropOffScanSuccessModalController controller;
  Future<void> Function() action;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 32.h),
          decoration: AppDecoration.fillWhiteA.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "msg_scan_successfull".tr,
                style: theme.textTheme.headlineSmall,
              ),
              SizedBox(height: 16.h),
              CustomElevatedButton(
                height: 48.h,
                text: cardId.isEmpty ? "lbl_2345_6789_ab".tr : cardId,
                buttonStyle: CustomButtonStyles.fillSecondaryContainer,
                buttonTextStyle: theme.textTheme.headlineLarge!,
              ),
              // SizedBox(height: 4.h),
              // Text(
              //   "lbl_id_12345".tr,
              //   style: CustomTextStyles.titleMediumBlack900,
              // ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.maxFinite,
                child: Text(
                  "msg_we_ve_captured_your".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge!.copyWith(height: 1.38),
                ),
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomElevatedButton(
                    onPressed:action,
                    //  () {
                    //   print('calling method===============');
                    //   action;
                    // },
                    height: 40.h,
                    width: 134.h,
                    text: "lbl_continue".tr,
                    buttonStyle: CustomButtonStyles.fillPrimaryTL20,
                  ),
                  Spacer(),
                  CustomOutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    height: 42.h,
                    width: 118.h,
                    text: "lbl_cancel".tr,
                    buttonTextStyle: CustomTextStyles.titleMediumGray600,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
