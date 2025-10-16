import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_checkbox_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/login_controller.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends GetWidget<LoginController> {
  LoginScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appTheme.whiteA700,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 14.h, top: 24.h, right: 14.h),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "lbl_hey_there".tr,
                  style: CustomTextStyles.headlineLargeInterTight,
                ),
                SizedBox(height: 10.h),
                Text(
                  "msg_sign_in_to_begin".tr,
                  style: theme.textTheme.bodyMedium,
                ),
                SizedBox(height: 58.h),
                _buildLoginForm(),
                // SizedBox(height: 24.h),
                // _buildRememberMeRow(),
                SizedBox(height: 72.h),
                _buildLoginButton(),
                // SizedBox(height: 28.h),
                // RichText(
                //   text: TextSpan(
                //     children: [
                //       TextSpan(
                //         text: "msg_don_t_have_an_account".tr,
                //         style: theme.textTheme.bodyMedium,
                //       ),
                //       TextSpan(
                //         text: "lbl_sign_up_here".tr,
                //         style: CustomTextStyles.titleSmallPrimary,
                //       ),
                //     ],
                //   ),
                //   textAlign: TextAlign.left,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: 50.h,
      leadingWidth: 59.h,
      // leading: AppbarLeadingIconbutton(
      //   imagePath: ImageConstant.imgArrowLeft,
      //   height: 38.h,
      //   width: 38.h,
      //   margin: EdgeInsets.only(left: 21.h, top: 4.h, bottom: 8.h),
      //   onTap: () {
      //     onTapArrowleftone();
      //   },
      // ),
    );
  }

  /// Section Widget
  Widget _buildSchoolCodeInput() {
    return CustomTextFormField(
      controller: controller.schoolCodeInputController,
      hintText: "lbl_school_code".tr,
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
      contentPadding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 16.h),
    );
  }

  /// Section Widget
  Widget _buildUsernameInput() {
    return CustomTextFormField(
      controller: controller.usernameInputController,
      hintText: "lbl_username".tr,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(18.h, 16.h, 20.h, 16.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgUser11,
          height: 16.h,
          width: 16.h,
          fit: BoxFit.contain,
        ),
      ),
      prefixConstraints: BoxConstraints(maxHeight: 50.h),
      contentPadding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 16.h),
      validator: (value) {
        if (!isText(value)) {
          return "err_msg_please_enter_valid_text".tr;
        }
        return null;
      },
    );
  }

  /// Section Widget
  Widget _buildPasswordInput() {
    return Obx(
      () => CustomTextFormField(
        controller: controller.passwordInputController,
        hintText: "lbl_password".tr,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        prefix: Container(
          margin: EdgeInsets.fromLTRB(18.h, 16.h, 20.h, 16.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgLock1,
            height: 16.h,
            width: 18.h,
            fit: BoxFit.contain,
          ),
        ),
        prefixConstraints: BoxConstraints(maxHeight: 50.h),
        suffix: InkWell(
          onTap: () {
            controller.isShowPassword.value = !controller.isShowPassword.value;
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(16.h, 16.h, 18.h, 16.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgEyecrossed1,
              height: 16.h,
              width: 20.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
        suffixConstraints: BoxConstraints(maxHeight: 50.h),
        obscureText: controller.isShowPassword.value,
        contentPadding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 16.h),
        validator: (value) {
          if (value == null || (!isValidPassword(value, isRequired: true))) {
            return "err_msg_please_enter_valid_password".tr;
          }
          return null;
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildLoginForm() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 8.h),
      child: Column(
        spacing: 24,
        children: [
          _buildSchoolCodeInput(),
          _buildUsernameInput(),
          _buildPasswordInput(),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRememberMeRow() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => CustomCheckboxButton(
              text: "lbl_remember_me".tr,
              value: controller.remembermeone.value,
              onChange: (value) {
                controller.remembermeone.value = value;
              },
            ),
          ),
          Text("lbl_forgot_password".tr, style: theme.textTheme.labelMedium),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildLoginButton() {
    return CustomElevatedButton(
      onPressed:
          ()
          //{
          // print("${controller.passwordInputController.text}");
          // print("${controller.usernameInputController.text}");
          // print("${controller.schoolCodeInputController.text}");
          //},
          => controller.firstLogin(),
      height: 50.h,
      text: "lbl_login".tr,
      margin: EdgeInsets.only(right: 6.h),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
