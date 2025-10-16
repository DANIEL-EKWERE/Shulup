import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/attendance_log_controller.dart';
import '../models/attendanceloglist_item_model.dart';

// ignore_for_file: must_be_immutable
class AttendanceloglistItemWidget extends StatelessWidget {
  AttendanceloglistItemWidget(this.attendanceloglistItemModelObj, {Key? key})
    : super(key: key);

  AttendanceloglistItemModel attendanceloglistItemModelObj;

  var controller = Get.find<AttendanceLogController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 1),
          Expanded(
            child: Obx(
              () => Text(
                attendanceloglistItemModelObj.precious!.value,
                style: theme.textTheme.bodySmall,
              ),
            ),
          ),
          SizedBox(width: 30),
          // Spacer(),
          Expanded(
            child: Obx(
              () => Text(
                attendanceloglistItemModelObj.zipcode!.value,
                style: theme.textTheme.bodySmall,
              ),
            ),
          ),
          SizedBox(width: 2),
          Expanded(
            child: Obx(
              () => Text(
                attendanceloglistItemModelObj.twentythree!.value,
                style: theme.textTheme.bodySmall,
              ),
            ),
          ),
          // SizedBox(width: 10),
          Expanded(
            child: Obx(
              () => Text(
                attendanceloglistItemModelObj.time!.value,
                style: theme.textTheme.bodySmall,
              ),
            ),
          ),
          Obx(
            () => Text(
              attendanceloglistItemModelObj.pickup!.value,
              style:
                  attendanceloglistItemModelObj.pickup!.value == 'Drop Off'
                      ? CustomTextStyles.bodySmallBlue900
                      : attendanceloglistItemModelObj.pickup!.value == 'Pick Up'
                      ? CustomTextStyles.bodySmallYellow900
                      : attendanceloglistItemModelObj.pickup!.value ==
                          'Check In'
                      ? CustomTextStyles.bodySmallGreen900
                      : CustomTextStyles.bodySmallRed900,
            ),
          ),
        ],
      ),
    );
  }
}
