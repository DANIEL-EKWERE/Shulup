import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle_two.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../change_school_code_dialog/change_school_code_dialog.dart';
import '../change_school_code_dialog/controller/change_school_code_controller.dart';
import 'controller/home_one_controller.dart';
import 'models/actiongrid_item_model.dart';
import 'widgets/actiongrid_item_widget.dart'; // ignore_for_file: must_be_immutable

class HomeOneScreen extends GetWidget<HomeOneController> {
  const HomeOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.black900.withValues(alpha: 0.15),
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 14.h),
          child: Column(
            spacing: 70,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 466.h,
                width: double.maxFinite,
                margin: EdgeInsets.only(left: 8.h),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: Text(
                          "msg_what_would_you_like".tr,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    _buildMainContent(),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 182.h,
                        padding: EdgeInsets.all(16.h),
                        decoration: AppDecoration.outlineBlack.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder6,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              child: _buildChangeSchoolCodeRow(
                                changeschool: "lbl_view_logs".tr,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            _buildChangeSchoolCodeRow(
                              changeschool: "msg_change_school_code".tr,
                            ),
                            SizedBox(height: 8.h),
                            SizedBox(
                              width: double.maxFinite,
                              child: _buildChangeSchoolCodeRow(
                                changeschool: "lbl_register_card2".tr,
                              ),
                            ),
                            SizedBox(height: 36.h),
                            Text(
                              "lbl_log_out".tr,
                              style: CustomTextStyles.bodySmallRed600,
                            ),
                            SizedBox(height: 14.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
      height: 30.h,
      leadingWidth: 58.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgSchulupLogo1,
        margin: EdgeInsets.only(left: 28.h),
      ),
      title: AppbarSubtitleTwo(text: "msg_hi_blessing_anthony".tr),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgMenuBurger2,
          height: 20.h,
          width: 20.h,
          margin: EdgeInsets.only(right: 15.h),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildMainContent() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 4.h),
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
            controller.homeOneModelObj.value.actiongridItemList.value.length,
            (index) {
              ActiongridItemModel model =
                  controller
                      .homeOneModelObj
                      .value
                      .actiongridItemList
                      .value[index];
              return ActiongridItemWidget(model);
            },
          ),
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildChangeSchoolCodeRow({required String changeschool}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          changeschool,
          style: CustomTextStyles.bodySmall12.copyWith(
            color: appTheme.black900,
          ),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgArrowRight,
          height: 18.h,
          width: 18.h,
        ),
      ],
    );
  }

  @override
  void navigateToChangeSchoolCode() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        content: ChangeSchoolCodeDialog(Get.put(ChangeSchoolCodeController())),
      ),
    );
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        content: ChangeSchoolCodeDialog(Get.put(ChangeSchoolCodeController())),
      ),
    );
  }
}
