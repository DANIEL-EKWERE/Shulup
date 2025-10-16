import 'package:flutter/material.dart';
import 'package:schulup/core/utils/storage.dart';
import '../../../core/app_export.dart';
import '../models/iphone_13_14_five_model.dart';

/// A controller class for the Iphone1314FiveScreen.
///
/// This class manages the state of the Iphone1314FiveScreen, including the
/// current iphone1314FiveModelObj
class Iphone1314FiveController extends GetxController {
  Rx<Iphone1314FiveModel> iphone1314FiveModelObj = Iphone1314FiveModel().obs;

  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      // Get.offNamed(AppRoutes.loginScreen);
      navigate();
    });
  }

  void navigate() async {
    var token = await dataBase.getToken();
    print('token: $token');
    token.isEmpty
        ?
        // Get.toNamed('/sign_two_screen');
        Get.offAllNamed(AppRoutes.loginScreen)
        : Get.offAllNamed(AppRoutes.secondLoginScreen);
  }
}
