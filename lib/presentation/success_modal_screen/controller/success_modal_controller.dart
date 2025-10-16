import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/success_modal_model.dart';

/// A controller class for the SuccessModalScreen.
///
/// This class manages the state of the SuccessModalScreen, including the
/// current successModalModelObj
class SuccessModalController extends GetxController {
  Rx<SuccessModalModel> successModalModelObj = SuccessModalModel().obs;
}
