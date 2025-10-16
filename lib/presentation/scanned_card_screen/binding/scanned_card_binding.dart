import '../../../core/app_export.dart';
import '../controller/scanned_card_controller.dart';

/// A binding class for the ScannedCardScreen.
///
/// This class ensures that the ScannedCardController is created when the
/// ScannedCardScreen is first loaded.
class ScannedCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScannedCardController());
  }
}
