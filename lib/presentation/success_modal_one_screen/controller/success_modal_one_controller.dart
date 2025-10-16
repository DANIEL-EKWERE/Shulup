import 'package:flutter/material.dart';
import 'package:schulup/presentation/success_modal_one_screen/models/success_model_one_model.dart';
import '../../../core/app_export.dart';


/// A controller class for the SuccessModalOneScreen.
///
/// This class manages the state of the SuccessModalOneScreen, including the
/// current successModalOneModelObj
class SuccessModalOneController extends GetxController {
  Rx<SuccessModalOneModel> successModalOneModelObj = SuccessModalOneModel().obs;
}
