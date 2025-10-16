import 'package:schulup/presentation/success_modal_one_screen/controller/success_modal_one_controller.dart';

import '../../../core/app_export.dart';


/// A binding class for the SuccessModalOneScreen.
///
/// This class ensures that the SuccessModalOneController is created when the
/// SuccessModalOneScreen is first loaded.
class SuccessModalOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SuccessModalOneController());
  }
}
