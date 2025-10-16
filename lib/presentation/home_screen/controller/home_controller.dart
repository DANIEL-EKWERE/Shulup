import 'dart:convert';
import 'dart:developer' as myLog;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:schulup/core/network/connectivity_service.dart';
import 'package:schulup/core/utils/storage.dart';
import 'package:schulup/data/apiClient/api_client.dart';
import '../../../core/app_export.dart';
import '../models/home_model.dart';
import 'package:overlay_kit/overlay_kit.dart';

/// A controller class for the HomeScreen.
///
/// This class manages the state of the HomeScreen, including the
/// current homeModelObj
class HomeController extends GetxController {
  Rx<HomeModel> homeModelObj = HomeModel().obs;

  RxString logo = ''.obs;
  RxString name = 'Loading....'.obs;
  RxString cardNo = ''.obs;
  RxString userName = 'Loading....'.obs;
  RxBool availabilityNFC = false.obs;

  TextEditingController userIdController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    getLogo();
    //getName();
    checkNFC();
    getUser();
    ConnectivityService().startSyncListener();
  }

 void checkNFC() async {
    bool availability = await NfcManager.instance.isAvailable();
    availabilityNFC.value = availability;
    update();
    if (!availability) {
      print("NFC may not be supported or may be temporarily disabled");
    } else {
      print("NFC is supported");
    }
  }


  ApiClient _apiService = ApiClient(Duration(seconds: 60 * 5));

  void getUser() async {
    var name = await dataBase.getUserName();
    userName.value = name;
    update();
  }

  Future<void> logout() async {
    OverlayLoadingProgress.start(
      context: Get.context!,
      circularProgressColor: Color(0XFFFF8C42),
    );

    try {
      final response = await _apiService.logOut();
      if (response.statusCode == 200) {
        OverlayLoadingProgress.stop();
        //dataBase.logOut();
        Get.offAllNamed(AppRoutes.secondLoginScreen);
      } else {
        OverlayLoadingProgress.stop();
        Get.snackbar("Error", "Unable to logout");
      }
    } on SocketException {
Get.snackbar(
          'Opps!!!',
          'Check your internet connection and try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0XFFFF8C42),
          colorText: Colors.white,
        );
    }
    catch (e) {
      OverlayLoadingProgress.stop();
      Get.snackbar("Error", "Unable to logout \n $e");
    } finally {
      OverlayLoadingProgress.stop();
    }
    //Get.offAllNamed(AppRoutes.signTwoScreen);
  }

  Future<void> getLogo() async {
    //  OverlayLoadingProgress.start(context: Get.context!);

    try {
      final response = await _apiService.getSchoolLogo();
      if (response.statusCode == 200) {
        //     OverlayLoadingProgress.stop();
        // Handle successful logo retrieval
        print(response.body);
        //} else {
        OverlayLoadingProgress.stop();
        var responseBody = jsonDecode(response.body);
        var logoUrl = responseBody['logoUrl'];
        logo.value = logoUrl;
        print(logo.value);
        myLog.log(logo.value);
      }
    } on SocketException{
      Get.snackbar("Low/No Internet", "Currently Operating in offline Mode");
    }
    
    catch (e) {
      OverlayLoadingProgress.stop();
      Get.snackbar("Error", "Unable to retrieve logo \n $e");
    } finally {
      // OverlayLoadingProgress.stop();
    }
  }

  Future<void> getName() async {
    //  OverlayLoadingProgress.start(context: Get.context!);

    try {
      final response = await _apiService.getSchoolName();
      if (response.statusCode == 200) {
        //  OverlayLoadingProgress.stop();
        // Handle successful logo retrieval
        print(response.body);
        var responseBody = jsonDecode(response.body);
        var schoolName = responseBody['data'];
        name.value = schoolName;
        print(name.value);
      } else {
        //   OverlayLoadingProgress.stop();
        Get.snackbar("Error", "Unable to retrieve logo");
      }
    } catch (e) {
      //  OverlayLoadingProgress.stop();
      Get.snackbar("Error", "Unable to retrieve logo \n $e");
    } finally {
      //  OverlayLoadingProgress.stop();
    }
  }
}
