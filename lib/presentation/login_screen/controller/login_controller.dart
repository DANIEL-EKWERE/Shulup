import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:schulup/data/apiClient/api_client.dart';
import 'package:flutter/material.dart';
import 'package:schulup/core/utils/storage.dart';
import 'package:schulup/presentation/change_school_code_dialog/controller/change_school_code_controller.dart';
import 'package:schulup/presentation/home_screen/controller/home_controller.dart';
import '../../../core/app_export.dart';
import '../models/login_model.dart';
import 'dart:developer' as myLog;
import 'package:overlay_kit/overlay_kit.dart';

/// A controller class for the LoginScreen.
///
/// This class manages the state of the LoginScreen, including the
/// current loginModelObj
class LoginController extends GetxController {
  ApiClient _apiService = ApiClient(Duration(seconds: 60 * 5));
  TextEditingController schoolCodeInputController = TextEditingController();
  ChangeSchoolCodeController homeController = Get.put(
    ChangeSchoolCodeController(),
  );
  TextEditingController usernameInputController = TextEditingController();

  TextEditingController passwordInputController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  Rx<LoginModel> loginModelObj = LoginModel().obs;

  Rx<bool> isShowPassword = true.obs;

  Rx<bool> remembermeone = false.obs;

  int inCorrectPassWord = 0;

  @override
  void onClose() {
    super.onClose();
    // schoolCodeInputController.dispose();
    // usernameInputController.dispose();
    // passwordInputController.dispose();
    // usernameController.dispose();
    // passwordController.dispose();
  }

  Future<void> firstLogin() async {
    OverlayLoadingProgress.start(
      context: Get.context!,
      circularProgressColor: Color(0XFFFF8C42),
    );
    try {
      final body = {
        "username": usernameInputController.text,
        "password": passwordInputController.text,
        "schoolCode": schoolCodeInputController.text,
      };
      print(body);
      final response = await _apiService.firstLogin(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // OverlayLoadingProgress.stop();
        // myLog.log('Login successful: ${response.body}');
        // schoolCodeInputController.dispose();
        // usernameInputController.dispose();
        // passwordInputController.dispose();
        var responseData = jsonDecode(response.body);
        var token = responseData['data']['token'];
        var userId = responseData['data']['userID'];
        var userName = responseData['data']['displayName'];
        myLog.log('Token: $token');
        dataBase.saveToken(token);
        dataBase.saveUserId(userId);
        dataBase.saveUserName(userName);
        dataBase.saveTransactionPin(passwordInputController.text);
        dataBase.saveBrmCode(schoolCodeInputController.text);
        usernameInputController.clear();
        passwordInputController.clear();
        schoolCodeInputController.clear();
        Get.offAllNamed(AppRoutes.homeScreen);
        OverlayLoadingProgress.stop();
        //   Get.toNamed(AppRoutes.signFourScreen);
      } else if (response.statusCode == 404 || response.statusCode == 401) {
        //Get.offAllNamed(AppRoutes.signTwoScreen);
        OverlayLoadingProgress.stop();
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
        OverlayLoadingProgress.stop();
        Get.snackbar(
          'Error',
          'Login failed. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
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
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      //OverlayLoadingProgress.stop();
    } finally {
      OverlayLoadingProgress.stop();
    }
  }

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
      final networkInfo = NetworkInfo();
      if (await networkInfo.isConnected()) {
    try {
      final body = {
        "username": usernameController.text,
        "password": passwordController.text,
        "schoolCode": schoolcode,
      };

      final response = await _apiService.firstLogin(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        myLog.log('login successful: ${response.body}');
        usernameController.clear();
        passwordController.clear();
        // usernameController.dispose();
        // passwordController.dispose();
        Get.offAllNamed(AppRoutes.homeScreen);

        //   Get.toNamed(AppRoutes.signFourScreen);
      } else if (response.statusCode == 404 || response.statusCode == 401) {
        var responseData = jsonDecode(response.body);
        var message = responseData['message'];
        if (message == "Invalid credentials.") {
          myLog.log('invalid passord');
          inCorrectPassWord++;
          if (inCorrectPassWord == 5) {
            inCorrectPassWord = 0;
            Get.dialog(
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AlertDialog(
                  contentPadding: EdgeInsets.all(16),
                  backgroundColor: Colors.white,
                  insetPadding: EdgeInsets.zero,
                  title: Text('Logging You Out'),
                  content: Text(
                    'you,ve enter an incorrect password for about 5 times\n You will be logged out of your account!',
                  ),
                ),
              ),
            );
            Timer(Duration(seconds: 5), () {
              homeController.logout();
              dataBase.logOut();

              Get.offAllNamed(AppRoutes.loginScreen);
            });
          }
        }
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
          'Login failed. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
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
      } else {
        Get.snackbar(
          'Offline Login',
          'Offline login enabled',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        // Get.snackbar(
        //   'Offline Login',
        //   'USERNAME: ${usernameController.text} - ${username}',
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.orange,
        //   colorText: Colors.white,
        // );
        //         Get.snackbar(
        //   'Offline Login',
        //   'PASSOWRD: ${passwordController.text} - ${password}',
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.orange,
        //   colorText: Colors.white,
        // );
        if (usernameController.text == username &&
            passwordController.text == password) {
          Get.offAllNamed(AppRoutes.homeScreen);
        }
        // myLog.log("USERNAME: ${usernameController.text} - ${username}");
        // myLog.log("PASSOWRD: ${passwordController.text} - ${password}");
        OverlayLoadingProgress.stop();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      OverlayLoadingProgress.stop();
    }
  }
}
