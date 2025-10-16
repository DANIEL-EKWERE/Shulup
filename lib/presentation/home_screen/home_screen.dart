import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:schulup/presentation/change_school_code_dialog/change_school_code_dialog.dart';
import 'package:schulup/presentation/change_school_code_dialog/controller/change_school_code_controller.dart';
import 'package:schulup/presentation/drop_off_scan_screen/check_in_scan_screen.dart';
import 'package:schulup/presentation/drop_off_scan_screen/check_out_scan_screen.dart';
import 'package:schulup/presentation/drop_off_scan_screen/pick_up_scan_screen.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle_two.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'controller/home_controller.dart';
import 'models/actiongrid_item_model.dart';
import 'widgets/actiongrid_item_widget.dart'; // ignore_for_file: must_be_immutable

HomeController controller = Get.put(HomeController());

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Add at the top of each screen's build method
SystemChrome.setSystemUIOverlayStyle(
  const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ),
);
    return Scaffold(
      backgroundColor: appTheme.blueGray50,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(left: 14.h, top: 16.h, right: 14.h),
          child: Column(
            spacing: 60,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "msg_what_would_you_like".tr,
                style: theme.textTheme.bodyLarge,
              ),
              _buildHeroImage(),
              _buildActionGrid(),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      centerTitle: true,
      leadingWidth: 58.h,
      leading: Obx(
        () => AppbarLeadingImage(
          imagePath:
              controller.logo.value.isEmpty
                  ? ImageConstant.imgSchulupLogo1
                  : controller.logo.value,
          margin: EdgeInsets.only(left: 28.h),
        ),
      ),
      title: Obx(
        () => AppbarSubtitleTwo(
          text:
              controller.userName.value.isEmpty
                  ? "msg_hi_blessing_anthony".tr
                  : "Hi, ${controller.userName.value}! 👋🏽",
        ),
      ),
      actions: [
        PopupMenuButton<int>(
          icon: SvgPicture.asset(ImageConstant.imgApps1), //Icon(Icons.menu),
          itemBuilder:
              (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: [
                      Text('View Logs'),
                      Spacer(),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      Text('Register Card'),
                      Spacer(),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Row(
                    children: [
                      Text('Change School Code'),
                      Spacer(),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 3,
                  child: Center(
                    child: Text('Log Out', style: TextStyle(color: Colors.red)),
                  ),
                ),
              ],
          onSelected: (value) {
            // Handle menu selection
            print(value);
            if (value == 0) {
              Get.toNamed(AppRoutes.attendanceLogScreen);
            } else if (value == 1) {
              Get.toNamed(AppRoutes.registerCardScreen);
            } else if (value == 2) {
              // Get.toNamed(AppRoutes.changeSchoolCodeOneScreen);
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
            } else {
              showDialog(
                context: Get.context!,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirm Logout"),
                    content: Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.logout();
                        },
                        child: Text("Logout"),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
        // AppbarTrailingImage(
        //   onTap: () {

        //   },
        //   imagePath: ImageConstant.imgMenuBurger2,
        //   height: 20.h,
        //   width: 20.h,
        //   margin: EdgeInsets.only(right: 15.h),
        // ),
      ],
    );
  }

  /// Section Widget
  Widget _buildHeroImage() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 14.h),
      padding: EdgeInsets.symmetric(horizontal: 34.h),
      decoration: AppDecoration.fillPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgConfidentYoung,
            height: 364.h,
            width: double.maxFinite,
            margin: EdgeInsets.only(left: 8.h),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildActionGrid() {
    return Padding(
      padding: EdgeInsets.only(left: 8.h),
      child: Obx(
        () => ResponsiveGridListBuilder(
          minItemWidth: 1,
          minItemsPerRow: 2,
          maxItemsPerRow: 2,
          horizontalGridSpacing: 14.h,
          verticalGridSpacing: 14.h,
          builder:
              (context, items) => ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                children: items,
              ),
          gridItems: List.generate(
            controller.homeModelObj.value.actiongridItemList.value.length,
            (index) {
              if (index == 0) {}
              print(index);
              ActiongridItemModel model =
                  controller.homeModelObj.value.actiongridItemList.value[index];
              return ActiongridItemWidget(
                model,
                onTapRowdropoffone: () {
                  //onTapRowdropoffone(String model);
                  if (model.id!.value == '1') {
                    //Get.to(() => )
                    Get.toNamed(AppRoutes.dropOffScanScreen);
                  } else if (model.id!.value == '2') {
                    Get.to(() => PickUpScanScreen());
                  } else if (model.id!.value == '3') {
                    Get.to(() => ChecInkScanScreen());
                  } else {
                    Get.to(() => CheckOutScanScreen());
                  }
                  print("here ================ ${model.id!.value}");
                  print("here ================ ${model.dropOffOne!.value}");
                },
              );
            },
          ),
        ),
      ),
    );
  }

  /// Navigates to the dropOffScanScreen when the action is triggered.
  onTapRowdropoffone(id) {
    Get.toNamed(AppRoutes.dropOffScanScreen);
  }
}
