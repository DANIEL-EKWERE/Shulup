import 'dart:convert';
import 'dart:developer' as myLog;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:schulup/core/utils/storage.dart';
import 'package:schulup/data/apiClient/api_client.dart';

import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/scanned_card_model.dart';

/// A controller class for the ScannedCardScreen.
///
/// This class manages the state of the ScannedCardScreen, including the
/// current scannedCardModelObj
class ScannedCardController extends GetxController {
  TextEditingController studentoneoneController = TextEditingController();
  ApiClient _apiService = ApiClient(Duration(seconds: 60 * 5));
  Rx<ScannedCardModel> scannedCardModelObj = ScannedCardModel().obs;

  @override
  void onClose() {
    super.onClose();
    studentoneoneController.dispose();
  }

  Future<void> registerCard(String cardId) async {
    OverlayLoadingProgress.start(
      context: Get.context!,
      circularProgressColor: Color(0XFFFF8C42),
    );
    var schoolCode = await dataBase.getBrmCode();
    try {
      final body = {
        "schoolCode": schoolCode,
        "cardUID": cardId,
        "UserNo": studentoneoneController.text,
      };

      final response = await _apiService.regCard(body);
      if (response.statusCode == 200) {
        //  OverlayLoadingProgress.stop();
        // Handle successful logo retrieval
        print(response.body);
        // var responseBody = jsonDecode(response.body);
        // var schoolName = responseBody['data'];
        // name.value = schoolName;
        // print(name.value);
        var responseBody = jsonDecode(response.body);
        print(responseBody);

        // Get.toNamed(AppRoutes.accountCreationScreen);
        // !.then((value) {
        // Timer(const Duration(seconds: 4), () {
        studentoneoneController.clear();
        // Get.snackbar(
        //   'Success',
        //   responseBody['message'],
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        // );
        // });
        // });
        // Get.snackbar(
        //   'Success',
        //   responseBody['message'],
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        // );
        Get.toNamed(AppRoutes.successModalScreen);
      } else if (response.statusCode == 404) {
        var responseBody = jsonDecode(response.body);
        print(responseBody);
        Get.snackbar(
          'Oops!!!',
          responseBody['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      } else if (response.statusCode == 409) {
        var responseBody = jsonDecode(response.body);
        print(responseBody);
        Get.snackbar(
          'Oops!!!',
          responseBody['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      } else {
        //   OverlayLoadingProgress.stop();
        Get.snackbar("Error", "Unable to retrieve register card");
        var responseBody = jsonDecode(response.body);
        print(responseBody);
        print(response.body);
        print(response.statusCode);
      }
    } on SocketException {
      Get.snackbar(
        'Opps!!!',
        'Check your internet connection and try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color(0XFFFF8C42),
        colorText: Colors.white,
      );
    } catch (e) {
      //  OverlayLoadingProgress.stop();
      myLog.log("Unable to retrieve register card \n $e");
      Get.snackbar("Error", "Unable to retrieve register card \n $e");
    } finally {
      OverlayLoadingProgress.stop();
    }
  }
}
