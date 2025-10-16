import '../../../core/app_export.dart';

/// This class is used in the [actiongrid_item_widget] screen.

// ignore_for_file: must_be_immutable
class ActiongridItemModel {
  ActiongridItemModel({this.dropOffOne, this.dropoff, this.id}) {
    dropOffOne = dropOffOne ?? Rx(ImageConstant.imgLinkedin);
    dropoff = dropoff ?? Rx("lbl_drop_off".tr);
    id = id ?? Rx("");
  }

  Rx<String>? dropOffOne;

  Rx<String>? dropoff;

  Rx<String>? id;
}
