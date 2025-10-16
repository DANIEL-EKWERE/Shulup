import '../../../core/app_export.dart';
import '../controller/success_modal_controller.dart';

/// A binding class for the SuccessModalScreen.
///
/// This class ensures that the SuccessModalController is created when the
/// SuccessModalScreen is first loaded.
class SuccessModalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SuccessModalController());
  }
}
