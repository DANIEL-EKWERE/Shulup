import 'package:flutter/material.dart';
import 'package:scanning_effect/scanning_effect.dart';
import 'package:schulup/presentation/drop_off_scan_screen/controller/drop_off_scan_controller.dart';
import 'package:schulup/presentation/home_screen/controller/home_controller.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton_one.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_trailing_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/register_card_controller.dart'; // ignore_for_file: must_be_immutable

HomeController textController = Get.put(HomeController());
DropOffScanController dfController = Get.put(DropOffScanController());

class RegisterCardScreen extends GetWidget<RegisterCardController> {
  const RegisterCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.blueGray50,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: Obx(() {
          return textController.availabilityNFC.value
              ? Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 62.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.only(right: 4.h),
                      child: Text(
                        "msg_scan_your_card_and".tr,
                        style: CustomTextStyles.bodyMedium15,
                      ),
                    ),
                    Spacer(flex: 42),
                    Obx(() {
                      return controller.isScanning.value
                          ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              width: double.infinity,
                              height: 200,
                              child: ScanningEffect(
                                scanningColor: Color(0xffFF9741),
                                borderLineColor: Colors.transparent,
                                delay: Duration(seconds: 1),
                                duration: Duration(seconds: 2),
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgGroup3x,
                                  height: 172.h,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          )
                          : CustomImageView(
                            imagePath: ImageConstant.imgGroup3,
                            height: 172.h,
                            width: 290.h,
                            margin: EdgeInsets.only(right: 24.h),
                          );
                    }),

                    // Center(
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(12)
                    //     ),
                    //     width: double.infinity,
                    //     height: 200,
                    //     child: ScanningEffect(
                    //         scanningColor: Color(0xffFF9741),
                    //         borderLineColor: Colors.transparent,
                    //         delay: Duration(seconds: 1),
                    //         duration: Duration(seconds: 2),
                    //         child: Container(
                    //           width: 50,
                    //           height: 50,
                    //         )
                    //       ),
                    //   ),
                    // ),
                    Spacer(flex: 57),
                    CustomElevatedButton(
                      text: "lbl_register_card".tr,
                      margin: EdgeInsets.only(left: 10.h),
                      onPressed: () {
                        onTapRegistercard();
                      },
                    ),
                    SizedBox(height: 78.h),
                    _buildNavigationRow(),
                  ],
                ),
              )
              : Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 62.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.only(right: 4.h),
                      child: Text(
                        "msg_scan_your_card_and".tr,
                        style: CustomTextStyles.bodyMedium15,
                      ),
                    ),

                    Opacity(
                      opacity: 0.0,
                      child: TextField(
                        focusNode: dfController.focusNode,
                        controller: dfController.textController5,
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.transparent),
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    Spacer(flex: 42),
                    Obx(() {
                      return dfController.isRegisterCardScanning.value
                          ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              width: double.infinity,
                              height: 200,
                              child: ScanningEffect(
                                scanningColor: Color(0xffFF9741),
                                borderLineColor: Colors.transparent,
                                delay: Duration(seconds: 1),
                                duration: Duration(seconds: 2),
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgGroup3x,
                                  height: 172.h,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          )
                          : CustomImageView(
                            imagePath: ImageConstant.imgGroup3,
                            height: 172.h,
                            width: 290.h,
                            margin: EdgeInsets.only(right: 24.h),
                          );
                    }),

                    // Center(
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(12)
                    //     ),
                    //     width: double.infinity,
                    //     height: 200,
                    //     child: ScanningEffect(
                    //         scanningColor: Color(0xffFF9741),
                    //         borderLineColor: Colors.transparent,
                    //         delay: Duration(seconds: 1),
                    //         duration: Duration(seconds: 2),
                    //         child: Container(
                    //           width: 50,
                    //           height: 50,
                    //         )
                    //       ),
                    //   ),
                    // ),
                    Spacer(flex: 57),
                    CustomElevatedButton(
                      text: "lbl_register_card".tr,
                      margin: EdgeInsets.only(left: 10.h),
                      onPressed: () {
                        print('object');
                        //onTapRegistercard();
                        dfController.isRegisterCardScanning.value = true;
                        dfController.focusNode.requestFocus();
                      },
                    ),
                    SizedBox(height: 78.h),
                    _buildNavigationRow(),
                  ],
                ),
              );
        }),
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
      // actions: [
      //   AppbarTrailingIconbutton(
      //     imagePath: ImageConstant.imgApps1,
      //     margin: EdgeInsets.only(top: 12.h, right: 15.h, bottom: 12.h),
      //   ),
      // ],
    );
  }

  /// Section Widget
  Widget _buildNavigationRow() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgAngleLeft,
            height: 24.h,
            width: 26.h,
          ),
          GestureDetector(
            onTap: () => Get.back(),
            child: Padding(
              padding: EdgeInsets.only(left: 10.h),
              child: Text(
                "lbl_go_home".tr,
                style: CustomTextStyles.titleMediumBlack900_1,
              ),
            ),
          ),
          Spacer(flex: 73),
          Text(
            "lbl_scan_another".tr,
            style: CustomTextStyles.titleMediumPrimary,
          ),
          Spacer(flex: 26),
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }

  /// Navigates to the successModalScreen when the action is triggered.
  onTapRegistercard() {
    // Get.toNamed(AppRoutes.scannedCardScreen);
    //Get.toNamed(AppRoutes.successModalScreen);
    controller.scanCard();
  }
}
