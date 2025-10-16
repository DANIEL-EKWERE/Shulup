import '../../../core/app_export.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import 'attendanceloglist_item_model.dart';

/// This class defines the variables used in the [attendance_log_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class AttendanceLogModel {
  Rx<List<SelectionPopupModel>> dropdownItemList = Rx([
    SelectionPopupModel(id: 1, title: "Item One", isSelected: true),
    SelectionPopupModel(id: 2, title: "Item Two"),
    SelectionPopupModel(id: 3, title: "Item Three"),
  ]);

  Rx<List<SelectionPopupModel>> dropdownItemList1 = Rx([
    SelectionPopupModel(id: 1, title: "Item One", isSelected: true),
    SelectionPopupModel(id: 2, title: "Item Two"),
    SelectionPopupModel(id: 3, title: "Item Three"),
  ]);

  Rx<List<AttendanceloglistItemModel>> attendanceloglistItemList = Rx([
    AttendanceloglistItemModel(
      precious: "msg_precious_anthony".tr.obs,
      zipcode: "lbl_234657".tr.obs,
      twentythree: "lbl_06_09_23".tr.obs,
      time: "lbl_2_00pm".tr.obs,
      pickup: "lbl_pick_up2".tr.obs,
    ),
    AttendanceloglistItemModel(
      precious: "msg_precious_anthony".tr.obs,
      zipcode: "lbl_234657".tr.obs,
      twentythree: "lbl_06_09_23".tr.obs,
      time: "lbl_2_00pm".tr.obs,
      pickup: "lbl_drop_off".tr.obs,
    ),
    AttendanceloglistItemModel(
      precious: "msg_precious_anthony".tr.obs,
      zipcode: "lbl_234657".tr.obs,
      twentythree: "lbl_06_09_23".tr.obs,
      time: "lbl_2_00pm".tr.obs,
      pickup: "lbl_pick_up2".tr.obs,
    ),
    AttendanceloglistItemModel(
      precious: "msg_precious_anthony".tr.obs,
      zipcode: "lbl_234657".tr.obs,
      twentythree: "lbl_06_09_23".tr.obs,
      time: "lbl_2_00pm".tr.obs,
      pickup: "lbl_pick_up2".tr.obs,
    ),
    AttendanceloglistItemModel(
      precious: "msg_precious_anthony".tr.obs,
      zipcode: "lbl_234657".tr.obs,
      twentythree: "lbl_06_09_23".tr.obs,
      time: "lbl_2_00pm".tr.obs,
      pickup: "lbl_check_in".tr.obs,
    ),
    AttendanceloglistItemModel(
      precious: "msg_precious_anthony".tr.obs,
      zipcode: "lbl_234657".tr.obs,
      twentythree: "lbl_06_09_23".tr.obs,
      time: "lbl_2_00pm".tr.obs,
      pickup: "lbl_check_out".tr.obs,
    ),
    AttendanceloglistItemModel(
      precious: "msg_precious_anthony".tr.obs,
      zipcode: "lbl_234657".tr.obs,
      twentythree: "lbl_06_09_23".tr.obs,
      time: "lbl_2_00pm".tr.obs,
      pickup: "lbl_drop_off2".tr.obs,
    ),
    AttendanceloglistItemModel(
      precious: "msg_precious_anthony".tr.obs,
      zipcode: "lbl_234657".tr.obs,
      twentythree: "lbl_06_09_23".tr.obs,
      time: "lbl_2_00pm".tr.obs,
      pickup: "lbl_pick_up2".tr.obs,
    ),
    AttendanceloglistItemModel(
      precious: "msg_precious_anthony".tr.obs,
      zipcode: "lbl_234657".tr.obs,
      twentythree: "lbl_06_09_23".tr.obs,
      time: "lbl_2_00pm".tr.obs,
      pickup: "lbl_pick_up2".tr.obs,
    ),
    AttendanceloglistItemModel(
      precious: "msg_precious_anthony".tr.obs,
      zipcode: "lbl_234657".tr.obs,
      twentythree: "lbl_06_09_23".tr.obs,
      time: "lbl_2_00pm".tr.obs,
      pickup: "lbl_pick_up2".tr.obs,
    ),
    AttendanceloglistItemModel(
      precious: "msg_precious_anthony".tr.obs,
      zipcode: "lbl_234657".tr.obs,
      twentythree: "lbl_06_09_23".tr.obs,
      time: "lbl_2_00pm".tr.obs,
      pickup: "lbl_pick_up2".tr.obs,
    ),
    AttendanceloglistItemModel(
      precious: "msg_precious_anthony".tr.obs,
      zipcode: "lbl_234657".tr.obs,
      twentythree: "lbl_06_09_23".tr.obs,
      time: "lbl_2_00pm".tr.obs,
      pickup: "lbl_pick_up2".tr.obs,
    ),
  ]);
}
