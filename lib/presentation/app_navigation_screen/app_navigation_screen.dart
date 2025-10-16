import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../change_school_code_dialog/change_school_code_dialog.dart';
import '../change_school_code_dialog/controller/change_school_code_controller.dart';
import '../drop_off_scan_success_modal_dialog/controller/drop_off_scan_success_modal_controller.dart';
import '../drop_off_scan_success_modal_dialog/drop_off_scan_success_modal_dialog.dart';
import 'controller/app_navigation_controller.dart'; // ignore_for_file: must_be_immutable

class AppNavigationScreen extends GetWidget<AppNavigationController> {
  const AppNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFFFFFF),
      body: SafeArea(
        child: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Color(0XFFFFFFFF)),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Text(
                        "App Navigation",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0XFF000000),
                          fontSize: 20.fSize,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.only(left: 20.h),
                      child: Text(
                        "Check your app's UI from the below demo screens of your app.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0XFF888888),
                          fontSize: 16.fSize,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Divider(
                      height: 1.h,
                      thickness: 1.h,
                      color: Color(0XFF000000),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(color: Color(0XFFFFFFFF)),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          screenTitle: "Login screen",
                          onTapScreenTitle:
                              () => onTapScreenTitle(AppRoutes.loginScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "Register card",
                          onTapScreenTitle:
                              () => onTapScreenTitle(
                                AppRoutes.registerCardScreen,
                              ),
                        ),
                        _buildScreenTitle(
                          screenTitle: "scanned card",
                          onTapScreenTitle:
                              () =>
                                  onTapScreenTitle(AppRoutes.scannedCardScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "Success modal",
                          onTapScreenTitle:
                              () => onTapScreenTitle(
                                AppRoutes.successModalScreen,
                              ),
                        ),
                        _buildScreenTitle(
                          screenTitle: "Home",
                          onTapScreenTitle:
                              () => onTapScreenTitle(AppRoutes.homeScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "Drop off scan",
                          onTapScreenTitle:
                              () =>
                                  onTapScreenTitle(AppRoutes.dropOffScanScreen),
                        ),
                        // _buildScreenTitle(
                        //   screenTitle: "Drop off scan success modal - Dialog",
                        //   onTapScreenTitle:
                        //       () => onTapDialogTitle(
                        //         context,
                        //         DropOffScanSuccessModalDialog(
                        //           Get.put(DropOffScanSuccessModalController()) ,'',() => null
                        //         ),
                        //       ),
                        // ),
                        // _buildScreenTitle(
                        //   screenTitle: "Attendance Log",
                        //   onTapScreenTitle:
                        //       () => onTapScreenTitle(
                        //         AppRoutes.attendanceLogScreen,
                        //       ),
                        // ),
                        _buildScreenTitle(
                          screenTitle: "Change School code - Dialog",
                          onTapScreenTitle:
                              () => onTapDialogTitle(
                                context,
                                ChangeSchoolCodeDialog(
                                  Get.put(ChangeSchoolCodeController()),
                                ),
                              ),
                        ),
                        _buildScreenTitle(
                          screenTitle: "Success modal One",
                          onTapScreenTitle:
                              () => onTapScreenTitle(
                                AppRoutes.successModalOneScreen,
                              ),
                        ),
                        _buildScreenTitle(
                          screenTitle: "Change School code One",
                          onTapScreenTitle:
                              () => onTapScreenTitle(
                                AppRoutes.changeSchoolCodeOneScreen,
                              ),
                        ),
                        _buildScreenTitle(
                          screenTitle: "Home One",
                          onTapScreenTitle:
                              () => onTapScreenTitle(AppRoutes.homeOneScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "iPhone 13 & 14 - Five",
                          onTapScreenTitle:
                              () => onTapScreenTitle(
                                AppRoutes.iphone1314FiveScreen,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Common click event for dialog
  void onTapDialogTitle(BuildContext context, Widget className) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: className,
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
        );
      },
    );
  }

  /// Common widget
  Widget _buildScreenTitle({
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle?.call();
      },
      child: Container(
        decoration: BoxDecoration(color: Color(0XFFFFFFFF)),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                screenTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(height: 5.h),
            Divider(height: 1.h, thickness: 1.h, color: Color(0XFF888888)),
          ],
        ),
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(String routeName) {
    Get.toNamed(routeName);
  }
}
