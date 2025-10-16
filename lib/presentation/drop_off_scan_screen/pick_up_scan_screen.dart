import 'package:flutter/material.dart';
import 'package:scanning_effect/scanning_effect.dart';
import 'package:schulup/presentation/home_screen/controller/home_controller.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton_one.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../drop_off_scan_success_modal_dialog/controller/drop_off_scan_success_modal_controller.dart';
import '../drop_off_scan_success_modal_dialog/drop_off_scan_success_modal_dialog.dart';
import 'controller/drop_off_scan_controller.dart'; // ignore_for_file: must_be_immutable

DropOffScanController controller = Get.put(DropOffScanController());
HomeController homeController = Get.put(HomeController());

class PickUpScanScreen extends GetWidget<DropOffScanController> {
  const PickUpScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.blueGray50,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: Obx(() {
          return homeController.availabilityNFC.value
              ? Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 74.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 54.h),
                    Text(
                      "msg_scan_your_card_info".tr,
                      style: theme.textTheme.titleLarge,
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 42.h),
                        child: Text(
                          "msg_hold_your_card_near".tr,
                          style: CustomTextStyles.titleMediumBlack900_1,
                        ),
                      ),
                    ),
                    Spacer(flex: 42),
                    // CustomImageView(
                    //   imagePath: ImageConstant.imgGroup3,
                    //   height: 172.h,
                    //   width: double.maxFinite,
                    //   margin: EdgeInsets.only(left: 38.h, right: 34.h),
                    // ),
                    Obx(() {
                      return controller.isPickUpScanning.value
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
                            // margin: EdgeInsets.only(right: 24.h),
                          );
                    }),
                    Spacer(flex: 57),
                    CustomElevatedButton(
                      text: "lbl_scan".tr,
                      margin: EdgeInsets.only(left: 12.h),
                      leftIcon: Container(
                        margin: EdgeInsets.only(right: 16.h),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgTelevision,
                          height: 18.h,
                          width: 18.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                      onPressed: () {
                        onTapScan();
                      },
                    ),
                  ],
                ),
              )
              : Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 74.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Opacity(
                      opacity: 0.0,
                      child: TextField(
                        focusNode: controller.focusNode,
                        controller: controller.textController2,

                        autofocus: true,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.transparent),
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(height: 0.h),
                    Text(
                      "msg_scan_your_card_info".tr,
                      style: theme.textTheme.titleLarge,
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 42.h),
                        child: Text(
                          "msg_hold_your_card_near".tr,
                          style: CustomTextStyles.titleMediumBlack900_1,
                        ),
                      ),
                    ),
                    Spacer(flex: 42),
                    // CustomImageView(
                    //   imagePath: ImageConstant.imgGroup3,
                    //   height: 172.h,
                    //   width: double.maxFinite,
                    //   margin: EdgeInsets.only(left: 38.h, right: 34.h),
                    // ),
                    Obx(() {
                      return controller.isPickUpScanning.value
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
                            // margin: EdgeInsets.only(right: 24.h),
                          );
                    }),
                    Spacer(flex: 57),
                    CustomElevatedButton(
                      text: "lbl_scan".tr,
                      margin: EdgeInsets.only(left: 12.h),
                      leftIcon: Container(
                        margin: EdgeInsets.only(right: 16.h),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgTelevision,
                          height: 18.h,
                          width: 18.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                      onPressed: () {
                        //onTapScan();
                        controller.isPickUpScanning.value = true;
                        controller.focusNode.requestFocus();
                      },
                    ),
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
      title: AppbarTitle(text: "lbl_pick_up".tr),
      // actions: [
      //   AppbarTrailingIconbutton(
      //     imagePath: ImageConstant.imgApps1,
      //     margin: EdgeInsets.only(top: 12.h, right: 8.h, bottom: 12.h),
      //   ),
      // ],
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }

  /// Displays a dialog with the [DropOffScanSuccessModalDialog] content.
  onTapScan() {
    controller.scanCardPickup();
  }
}
