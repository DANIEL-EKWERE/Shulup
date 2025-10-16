import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/home_one_model.dart';

/// A controller class for the HomeOneScreen.
///
/// This class manages the state of the HomeOneScreen, including the
/// current homeOneModelObj
class HomeOneController extends GetxController {
  Rx<HomeOneModel> homeOneModelObj = HomeOneModel().obs;
}
