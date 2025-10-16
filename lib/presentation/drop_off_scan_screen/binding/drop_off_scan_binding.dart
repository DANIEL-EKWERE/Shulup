import '../../../core/app_export.dart';
import '../controller/drop_off_scan_controller.dart';

/// A binding class for the DropOffScanScreen.
///
/// This class ensures that the DropOffScanController is created when the
/// DropOffScanScreen is first loaded.
class DropOffScanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DropOffScanController());
  }
}
