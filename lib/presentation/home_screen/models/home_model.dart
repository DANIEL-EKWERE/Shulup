import '../../../core/app_export.dart';
import 'actiongrid_item_model.dart';

/// This class defines the variables used in the [home_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class HomeModel {
  Rx<List<ActiongridItemModel>> actiongridItemList = Rx([
    ActiongridItemModel(
      id: '1'.obs,
      dropOffOne: ImageConstant.imgLinkedin.obs,
      dropoff: "lbl_drop_off".tr.obs,
    ),
    ActiongridItemModel(
      id: '2'.obs,
      dropOffOne: ImageConstant.imgLinkedinWhiteA700.obs,
      dropoff: "lbl_pick_up".tr.obs,
    ),
    ActiongridItemModel(
      id: '3'.obs,
      dropOffOne: ImageConstant.imgLinkedin.obs,
      dropoff: "lbl_check_in".tr.obs,
    ),
    ActiongridItemModel(
      id: '4'.obs,
      dropOffOne: ImageConstant.imgLinkedinWhiteA700.obs,
      dropoff: "lbl_check_out".tr.obs,
    ),
  ]);
}
