import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:schulup/core/utils/storage.dart';
import 'package:schulup/data/apiClient/api_client.dart';
import 'package:schulup/presentation/change_school_code_dialog/model/change_school_code_model.dart';
import '../../../core/app_export.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'dart:developer' as myLog;

/// A controller class for the ChangeSchoolCodeDialog.
///
/// This class manages the state of the ChangeSchoolCodeDialog, including the
/// current changeSchoolCodeModelObj
class ChangeSchoolCodeController extends GetxController {
  TextEditingController schoolCodeController = TextEditingController();

  Rx<ChangeSchoolCodeModel> changeSchoolCodeModelObj =
      ChangeSchoolCodeModel().obs;

  ApiClient _apiService = ApiClient(Duration(seconds: 60 * 5));

  Future<void> secondLogin() async {
    OverlayLoadingProgress.start(
      context: Get.context!,
      circularProgressColor: Color(0XFFFF8C42),
    );
    var schoolcode = await dataBase.getBrmCode();
    var username = await dataBase.getUserName();
    var password = await dataBase.getTransactionPin();
    myLog.log('school code: $schoolcode');

    try {
      final body = {
        "username": username,
        "password": password,
        "schoolCode": schoolCodeController.text,
      };

      final response = await _apiService.firstLogin(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        myLog.log('login successful: ${response.body}');
        schoolCodeController.clear();
        dataBase.logOut();
        Get.offAllNamed(AppRoutes.loginScreen);

      } else if (response.statusCode == 404 || response.statusCode == 401) {
        //Get.offAllNamed(AppRoutes.loginScreen);

        var responseData = jsonDecode(response.body);
        var message = responseData['message'];
        Get.snackbar(
          'Error',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Something went wrong. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // OverlayLoadingProgress.stop();
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      OverlayLoadingProgress.stop();
    }
  }


  Future<void> logout() async {
    OverlayLoadingProgress.start(context: Get.context!,
      circularProgressColor: Color(0XFFFF8C42),);

    try {
      final response = await _apiService.logOut();
      if (response.statusCode == 200) {
        OverlayLoadingProgress.start(
      context: Get.context!,
      circularProgressColor: Color(0XFFFF8C42),
    );
        dataBase.logOut();
        Get.offAllNamed(AppRoutes.loginScreen);
      } else {
        OverlayLoadingProgress.stop();
        Get.snackbar("Error", "Unable to logout");
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      Get.snackbar("Error", "Unable to logout \n $e");
    } finally {
      OverlayLoadingProgress.stop();
    }
    //Get.offAllNamed(AppRoutes.signTwoScreen);
  }
}
