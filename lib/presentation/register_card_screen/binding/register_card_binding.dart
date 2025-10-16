import '../../../core/app_export.dart';
import '../controller/register_card_controller.dart';

/// A binding class for the RegisterCardScreen.
///
/// This class ensures that the RegisterCardController is created when the
/// RegisterCardScreen is first loaded.
class RegisterCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterCardController());
  }
}
