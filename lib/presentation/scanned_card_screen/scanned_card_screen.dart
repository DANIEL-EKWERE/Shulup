import 'package:flutter/material.dart';
import 'package:schulup/presentation/register_card_screen/controller/register_card_controller.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton_one.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_trailing_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/scanned_card_controller.dart'; // ignore_for_file: must_be_immutable

RegisterCardController controllerx = Get.put(RegisterCardController());

class ScannedCardScreen extends GetWidget<ScannedCardController> {
  const ScannedCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String cardId = Get.arguments.toString();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appTheme.blueGray50,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(left: 16.h, top: 140.h, right: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildAccessCodeSection(cardId),
              SizedBox(height: 54.h),
              SizedBox(
                width: double.maxFinite,
                child: Text(
                  "msg_this_card_can_now".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge!.copyWith(height: 1.38),
                ),
              ),
              SizedBox(height: 14.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.h),
                child: CustomTextFormField(
                  controller: controller.studentoneoneController,
                  hintText: "msg_student_admission".tr,
                  textInputAction: TextInputAction.done,
                  prefix: Container(
                    margin: EdgeInsets.fromLTRB(18.h, 16.h, 20.h, 16.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgStudent1,
                      height: 16.h,
                      width: 16.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  prefixConstraints: BoxConstraints(maxHeight: 50.h),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 18.h,
                    vertical: 16.h,
                  ),
                ),
              ),
              SizedBox(height: 34.h),
              _buildActionButtonsRow(cardId),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 60.h,
      leading: AppbarLeadingIconbuttonOne(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 28.h, top: 12.h, bottom: 12.h),
        onTap: () {
          onTapArrowleftone();
        },
      ),
      centerTitle: true,
      title: AppbarSubtitle(text: "msg_let_s_set_up_your".tr),
      actions: [
        AppbarTrailingIconbutton(
          imagePath: ImageConstant.imgApps1,
          margin: EdgeInsets.only(top: 12.h, right: 15.h, bottom: 12.h),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildAccessCodeSection(String cardId) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 4.h),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: AppDecoration.fillBlue.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        spacing: 20,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("lbl_access_code".tr, style: theme.textTheme.headlineSmall),
          Text(
            cardId.isEmpty ? "lbl_2345_6789".tr : cardId,
            style: theme.textTheme.headlineLarge,
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildActionButtonsRow(String cardId) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        children: [
          Expanded(
            child: CustomElevatedButton(
              onPressed: () => controller.registerCard(cardId),
              height: 40.h,
              text: "lbl_continue".tr,
              buttonStyle: CustomButtonStyles.fillPrimaryTL20,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: CustomOutlinedButton(
              onPressed: () {
                print('going back now');
                controllerx.stopScan();
                Get.back();
              },
              height: 42.h,
              text: "lbl_cancel".tr,
              buttonTextStyle: CustomTextStyles.titleMediumGray600,
            ),
          ),
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
