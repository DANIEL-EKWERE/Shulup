import '../../../core/app_export.dart';
import '../controller/home_one_controller.dart';

/// A binding class for the HomeOneScreen.
///
/// This class ensures that the HomeOneController is created when the
/// HomeOneScreen is first loaded.
class HomeOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeOneController());
  }
}
