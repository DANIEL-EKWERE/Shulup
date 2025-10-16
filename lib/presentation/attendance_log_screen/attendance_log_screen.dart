import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schulup/presentation/home_screen/controller/home_controller.dart';
import 'package:schulup/widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../core/app_export.dart';
import '../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle_two.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_search_view.dart';
import 'controller/attendance_log_controller.dart';
import 'models/attendanceloglist_item_model.dart';
import 'widgets/attendanceloglist_item_model.dart'; // ignore_for_file: must_be_immutable

HomeController controllerx = Get.put(HomeController());

class AttendanceLogScreen extends GetWidget<AttendanceLogController> {
  const AttendanceLogScreen({Key? key}) : super(key: key);

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
          padding: EdgeInsets.only(left: 14.h, top: 10.h, right: 14.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomSearchView(
                controller: controller.searchController,
                hintText: "msg_search_by_name_or".tr,
                contentPadding: EdgeInsets.fromLTRB(16.h, 8.h, 12.h, 8.h),
                suffix:
                    controller.searchController.text.isNotEmpty
                        ? IconButton(
                          icon: Icon(Icons.clear, size: 20),
                          onPressed: controller.clearSearch,
                        )
                        : null,
              ),
              SizedBox(height: 24.h),
              _buildDateFilterRow(),
              SizedBox(height: 10.h),
              // Results Count
              Obx(
                () => Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: ${controller.totalCount.value} records',
                        style: CustomTextStyles.labelLargeBlack900SemiBold,
                      ),
                      Text(
                        'Page ${controller.currentPage.value} of ${controller.totalPages.value}',
                        style: CustomTextStyles.labelLargeBlack900SemiBold,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              _buildHeaderRow(),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.all(8.h),
                  decoration: AppDecoration.outlineBlack,
                  child: Column(
                    spacing: 20,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // _buildCheckInRow(),
                      // _buildCheckOutRow(),
                      // _buildDropOffStack(),
                      _buildAttendanceLogList(),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 20.h),
              // Pagination
              Obx(
                () => Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed:
                            controller.currentPage.value > 1
                                ? controller.previousPage
                                : null,
                        icon: Icon(Icons.chevron_left),
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Page ${controller.currentPage.value} of ${controller.totalPages.value}',
                        style: CustomTextStyles.labelLargeBlack900SemiBold,
                      ),
                      SizedBox(width: 16),
                      IconButton(
                        onPressed:
                            controller.currentPage.value <
                                    controller.totalPages.value
                                ? controller.nextPage
                                : null,
                        icon: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ),
              ),
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
      //  leading:
      //  AppbarLeadingImage(
      //   onTap: ()=> Get.back(),
      //   imagePath: ImageConstant.imgArrowLeft,
      //      height: 100.h,
      //     width: 100.h,
      //  //   margin: EdgeInsets.only(right: 16.h),
      //   margin: EdgeInsets.only(left: 16.h),
      // ),
      // leadingWidth: 59.h,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeft,
        height: 38.h,
        width: 38.h,
        margin: EdgeInsets.only(left: 21.h, top: 4.h, bottom: 8.h),
        onTap: () {
          // onTapArrowleftone();
          Get.back();
        },
      ),
      centerTitle: true,
      title: Obx(
        () => AppbarSubtitleTwo(
          text:
              controllerx.userName.value.isEmpty
                  ? "msg_hi_blessing_anthony".tr
                  : "Hi, ${controllerx.userName.value}! 👋🏽",
        ),
      ),
      actions: [
        // AppbarTrailingImage(
        //   imagePath: ImageConstant.imgMenuBurger2,
        //   height: 20.h,
        //   width: 20.h,
        //   margin: EdgeInsets.only(right: 16.h),
        // ),
        Obx(
          () => AppbarLeadingImage(
            height: 40.h,
            width: 40.h,
            imagePath:
                controllerx.logo.value.isEmpty
                    ? ImageConstant.imgSchulupLogo1
                    : controllerx.logo.value,
            margin: EdgeInsets.only(right: 24.h),
          ),
        ),
      ],
    );
  }

  // /// Section Widget
  // Widget _buildDateFilterRow() {
  //   return SizedBox(
  //     width: double.maxFinite,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         CustomDropDown(
  //           width: 112.h,
  //           icon: Container(
  //             margin: EdgeInsets.only(left: 12.h),
  //             child: CustomImageView(
  //               imagePath: ImageConstant.imgArrowdown,
  //               height: 18.h,
  //               width: 18.h,
  //               fit: BoxFit.contain,
  //             ),
  //           ),
  //           iconSize: 18.h,
  //           hintText: "lbl_start_date".tr,
  //           items:
  //               controller.attendanceLogModelObj.value.dropdownItemList!.value,
  //           contentPadding: EdgeInsets.fromLTRB(16.h, 6.h, 8.h, 6.h),
  //         ),
  //         CustomDropDown(
  //           width: 112.h,
  //           icon: Container(
  //             margin: EdgeInsets.only(left: 12.h),
  //             child: CustomImageView(
  //               imagePath: ImageConstant.imgArrowdown,
  //               height: 18.h,
  //               width: 18.h,
  //               fit: BoxFit.contain,
  //             ),
  //           ),
  //           iconSize: 18.h,
  //           hintText: "lbl_end_date".tr,
  //           items:
  //               controller.attendanceLogModelObj.value.dropdownItemList1!.value,
  //           contentPadding: EdgeInsets.fromLTRB(16.h, 6.h, 8.h, 6.h),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /// Section Widget
  Widget _buildDateFilterRow() {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Start Date Picker
          Obx(
            () => GestureDetector(
              onTap: () => controller.selectStartDate(Get.context!),
              onLongPress:
                  controller.selectedStartDate.value != null
                      ? () => controller.clearStartDate()
                      : null,
              child: Container(
                width: 150.h,
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 10.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        controller.selectedStartDate.value != null
                            ? DateFormat(
                              'dd/MM/yyyy',
                            ).format(controller.selectedStartDate.value!)
                            : "lbl_start_date".tr,
                        style: CustomTextStyles.labelLargeBlack900SemiBold
                            .copyWith(
                              color:
                                  controller.selectedStartDate.value != null
                                      ? Colors.black
                                      : Colors.grey,
                            ),

                        // TextStyle(
                        //   fontSize: 14,
                        // color:
                        //     controller.selectedStartDate.value != null
                        //         ? Colors.black
                        //         : Colors.grey,
                        // ),
                      ),
                    ),
                    Icon(
                      controller.selectedStartDate.value != null
                          ? Icons.close
                          : Icons.calendar_today,
                      size: 18.h,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // End Date Picker
          Obx(
            () => GestureDetector(
              onTap: () => controller.selectEndDate(Get.context!),
              onLongPress:
                  controller.selectedEndDate.value != null
                      ? () => controller.clearEndDate()
                      : null,
              child: Container(
                width: 150.h,
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 10.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        controller.selectedEndDate.value != null
                            ? DateFormat(
                              'dd/MM/yyyy',
                            ).format(controller.selectedEndDate.value!)
                            : "lbl_end_date".tr,
                        style: CustomTextStyles.labelLargeBlack900SemiBold
                            .copyWith(
                              color:
                                  controller.selectedEndDate.value != null
                                      ? Colors.black
                                      : Colors.grey,
                            ),
                      ),
                    ),
                    Icon(
                      controller.selectedEndDate.value != null
                          ? Icons.close
                          : Icons.calendar_today,
                      size: 18.h,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildHeaderRow() {
    return Container(
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 6.h),
            decoration: AppDecoration.outlineGray,
            child: Text(
              "lbl_name".tr,
              textAlign: TextAlign.center,
              style: CustomTextStyles.labelLargeBlack900SemiBold,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 6.h),
            decoration: AppDecoration.outlineGray,
            child: Text(
              "lbl_card_no".tr,
              textAlign: TextAlign.center,
              style: CustomTextStyles.labelLargeBlack900SemiBold,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 6.h),
            decoration: AppDecoration.outlineGray,
            child: Text(
              "lbl_date".tr,
              textAlign: TextAlign.center,
              style: CustomTextStyles.labelLargeBlack900SemiBold,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
            decoration: AppDecoration.outlineGray,
            child: Text(
              "lbl_time".tr,
              textAlign: TextAlign.center,
              style: CustomTextStyles.labelLargeBlack900SemiBold,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 6.h),
            decoration: AppDecoration.fillWhiteA,
            child: Text(
              "lbl_status".tr,
              textAlign: TextAlign.center,
              style: CustomTextStyles.labelLargeBlack900SemiBold,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCheckInRow() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("msg_precious_anthony".tr, style: theme.textTheme.bodySmall),
          Spacer(),
          Text("lbl_234657".tr, style: theme.textTheme.bodySmall),
          Padding(
            padding: EdgeInsets.only(left: 22.h),
            child: Text("lbl_06_09_23".tr, style: theme.textTheme.bodySmall),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text("lbl_2_00pm".tr, style: theme.textTheme.bodySmall),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              "lbl_check_in".tr,
              style: CustomTextStyles.bodySmallGreen600,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCheckOutRow() {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("msg_precious_anthony".tr, style: theme.textTheme.bodySmall),
          Spacer(),
          Text("lbl_234657".tr, style: theme.textTheme.bodySmall),
          Padding(
            padding: EdgeInsets.only(left: 22.h),
            child: Text("lbl_06_09_23".tr, style: theme.textTheme.bodySmall),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text("lbl_2_00pm".tr, style: theme.textTheme.bodySmall),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              "lbl_check_out2".tr,
              style: CustomTextStyles.bodySmallRed600_1,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildDropOffStack() {
    return Container(
      height: 12.h,
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 10.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "msg_precious_anthony".tr,
              style: theme.textTheme.bodySmall,
            ),
          ),
          Text("lbl_234657".tr, style: theme.textTheme.bodySmall),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 92.h),
              child: Text("lbl_06_09_23".tr, style: theme.textTheme.bodySmall),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 52.h),
              child: Text("lbl_2_00pm".tr, style: theme.textTheme.bodySmall),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "lbl_drop_off".tr,
              style: CustomTextStyles.bodySmallSecondaryContainer,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "msg_precious_anthony".tr,
                        style: theme.textTheme.bodySmall,
                      ),
                      Spacer(),
                      Text("lbl_234657".tr, style: theme.textTheme.bodySmall),
                      Padding(
                        padding: EdgeInsets.only(left: 22.h),
                        child: Text(
                          "lbl_06_09_23".tr,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.h),
                        child: Text(
                          "lbl_2_00pm".tr,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.h),
                        child: Text(
                          "lbl_drop_off".tr,
                          style: CustomTextStyles.bodySmallSecondaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Section Widget
  // Widget _buildAttendanceLogList() {
  //   return Expanded(
  //     child: Obx(
  //       () => ListView.separated(
  //         padding: EdgeInsets.zero,
  //         physics: BouncingScrollPhysics(),
  //         shrinkWrap: true,
  //         separatorBuilder: (context, index) {
  //           return SizedBox(height: 20.h);
  //         },
  //         itemCount:
  //             controller
  //                 .attendanceLogModelObj
  //                 .value
  //                 .attendanceloglistItemList
  //                 .value
  //                 .length,
  //         itemBuilder: (context, index) {
  //           AttendanceloglistItemModel model =
  //               controller
  //                   .attendanceLogModelObj
  //                   .value
  //                   .attendanceloglistItemList
  //                   .value[index];
  //           return AttendanceloglistItemWidget(model);
  //         },
  //       ),
  //     ),
  //   );
  // }
  Widget _buildAttendanceLogList() {
    return Expanded(
      child: Obx(() {
        // Show loading indicator
        if (controller.isLoading.value
        // &&
        //     controller
        //         .attendanceLogModelObj
        //         .value
        //         .attendanceloglistItemList
        //         .value
        //         .isEmpty
        ) {
          return Center(child: CircularProgressIndicator());
        }

        // Show error message
        if (controller.hasError.value &&
            controller
                .attendanceLogModelObj
                .value
                .attendanceloglistItemList
                .value
                .isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: Colors.red),
                SizedBox(height: 16),
                Text(
                  controller.errorMessage.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed:
                      () => controller.fetchAttendanceLogs(isRefresh: true),
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        // Show empty state
        if (controller
            .attendanceLogModelObj
            .value
            .attendanceloglistItemList
            .value
            .isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox_outlined, size: 48, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No attendance logs found',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        // Show list with pull-to-refresh
        return RefreshIndicator(
          onRefresh: controller.refreshData,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(height: 20.h);
            },
            itemCount:
                controller
                    .attendanceLogModelObj
                    .value
                    .attendanceloglistItemList
                    .value
                    .length +
                (controller.isLoading.value ? 1 : 0),
            itemBuilder: (context, index) {
              // Show loading at bottom when loading more
              if (index ==
                  controller
                      .attendanceLogModelObj
                      .value
                      .attendanceloglistItemList
                      .value
                      .length) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.h),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              AttendanceloglistItemModel model =
                  controller
                      .attendanceLogModelObj
                      .value
                      .attendanceloglistItemList
                      .value[index];
              return AttendanceloglistItemWidget(model);
            },
          ),
        );
      }),
    );
  }
}
