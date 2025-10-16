import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/change_school_code_one_model.dart';

/// A controller class for the ChangeSchoolCodeOneScreen.
///
/// This class manages the state of the ChangeSchoolCodeOneScreen, including the
/// current changeSchoolCodeOneModelObj
class ChangeSchoolCodeOneController extends GetxController {
  TextEditingController studentoneoneController = TextEditingController();

  Rx<ChangeSchoolCodeOneModel> changeSchoolCodeOneModelObj =
      ChangeSchoolCodeOneModel().obs;

  @override
  void onClose() {
    super.onClose();
    studentoneoneController.dispose();
  }
}
