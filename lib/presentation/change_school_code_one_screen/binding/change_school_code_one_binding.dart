import '../../../core/app_export.dart';
import '../controller/change_school_code_one_controller.dart';

/// A binding class for the ChangeSchoolCodeOneScreen.
///
/// This class ensures that the ChangeSchoolCodeOneController is created when the
/// ChangeSchoolCodeOneScreen is first loaded.
class ChangeSchoolCodeOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangeSchoolCodeOneController());
  }
}
