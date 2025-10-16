import 'package:flutter/material.dart';
import 'package:schulup/presentation/change_school_code_dialog/change_school_code_dialog.dart';
import 'package:schulup/presentation/change_school_code_dialog/controller/change_school_code_controller.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/change_school_code_one_controller.dart'; // ignore_for_file: must_be_immutable

ChangeSchoolCodeController controller1 = Get.put(ChangeSchoolCodeController());

class ChangeSchoolCodeOneScreen
    extends GetWidget<ChangeSchoolCodeOneController> {
  const ChangeSchoolCodeOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appTheme.whiteA700,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 18.h),
          child: Column(
            children: [
              Text(
                "msg_enter_your_new_school".tr,
                style: CustomTextStyles.headlineSmallInterTight,
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: 252.h,
                child: Text(
                  "msg_this_helps_us_connect".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium!.copyWith(height: 1.57),
                ),
              ),
              SizedBox(height: 34.h),
              Padding(
                padding: EdgeInsets.only(left: 8.h),
                child: CustomTextFormField(
                  controller: controller1.schoolCodeController,
                  hintText: "lbl_e_g_sc12345".tr,
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
              Spacer(flex: 55),
              CustomElevatedButton(
                onPressed: () {
                  print("school code ==============");
                  Get.dialog(
                    AlertDialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: EdgeInsets.zero,
                      contentPadding: EdgeInsets.zero,
                      content: ChangeSchoolCodeDialog(
                        Get.put(ChangeSchoolCodeController()),
                      ),
                    ),
                  );
                },
                text: "lbl_continue".tr,
              ),
              Spacer(flex: 44),
            ],
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
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeft,
        height: 38.h,
        width: 38.h,
        margin: EdgeInsets.only(left: 21.h, top: 4.h, bottom: 8.h),
        onTap: () {
          onTapArrowleftone();
        },
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
