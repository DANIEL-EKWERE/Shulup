import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/drop_off_scan_success_modal_model.dart';

/// A controller class for the DropOffScanSuccessModalDialog.
///
/// This class manages the state of the DropOffScanSuccessModalDialog, including the
/// current dropOffScanSuccessModalModelObj
class DropOffScanSuccessModalController extends GetxController {
  Rx<DropOffScanSuccessModalModel> dropOffScanSuccessModalModelObj =
      DropOffScanSuccessModalModel().obs;
}
