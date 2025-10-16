import '../../../core/app_export.dart';
import '../controller/attendance_log_controller.dart';

/// A binding class for the AttendanceLogScreen.
///
/// This class ensures that the AttendanceLogController is created when the
/// AttendanceLogScreen is first loaded.
class AttendanceLogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceLogController());
  }
}
