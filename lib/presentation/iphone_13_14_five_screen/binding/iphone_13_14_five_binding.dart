import '../../../core/app_export.dart';
import '../controller/iphone_13_14_five_controller.dart';

/// A binding class for the Iphone1314FiveScreen.
///
/// This class ensures that the Iphone1314FiveController is created when the
/// Iphone1314FiveScreen is first loaded.
class Iphone1314FiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Iphone1314FiveController());
  }
}
