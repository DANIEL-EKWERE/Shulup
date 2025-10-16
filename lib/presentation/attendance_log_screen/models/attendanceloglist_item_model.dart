import '../../../core/app_export.dart';

/// This class is used in the [attendanceloglist_item_widget] screen.

// ignore_for_file: must_be_immutable
class AttendanceloglistItemModel {
  AttendanceloglistItemModel({
    this.precious,
    this.zipcode,
    this.twentythree,
    this.time,
    this.pickup,
    this.id,
  }) {
    precious = precious ?? Rx("msg_precious_anthony".tr);
    zipcode = zipcode ?? Rx("lbl_234657".tr);
    twentythree = twentythree ?? Rx("lbl_06_09_23".tr);
    time = time ?? Rx("lbl_2_00pm".tr);
    pickup = pickup ?? Rx("lbl_pick_up2".tr);
    id = id ?? Rx("");
  }

  Rx<String>? precious;

  Rx<String>? zipcode;

  Rx<String>? twentythree;

  Rx<String>? time;

  Rx<String>? pickup;

  Rx<String>? id;
}
