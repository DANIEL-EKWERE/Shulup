import 'package:schulup/presentation/home_screen_one/binding/home_one_binding.dart';
import 'package:schulup/presentation/home_screen_one/home_screen_one.dart';
import 'package:schulup/presentation/login_screen/second_login_screen.dart';
import 'package:schulup/presentation/success_modal_one_screen/bindings/success_modal_one_binding.dart';

import '../core/app_export.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import '../presentation/attendance_log_screen/attendance_log_screen.dart';
import '../presentation/attendance_log_screen/binding/attendance_log_binding.dart';
import '../presentation/change_school_code_one_screen/binding/change_school_code_one_binding.dart';
import '../presentation/change_school_code_one_screen/change_school_code_one_screen.dart';
import '../presentation/drop_off_scan_screen/binding/drop_off_scan_binding.dart';
import '../presentation/drop_off_scan_screen/drop_off_scan_screen.dart';
import '../presentation/home_screen/binding/home_binding.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/iphone_13_14_five_screen/binding/iphone_13_14_five_binding.dart';
import '../presentation/iphone_13_14_five_screen/iphone_13_14_five_screen.dart';
import '../presentation/login_screen/binding/login_binding.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/register_card_screen/binding/register_card_binding.dart';
import '../presentation/register_card_screen/register_card_screen.dart';
import '../presentation/scanned_card_screen/binding/scanned_card_binding.dart';
import '../presentation/scanned_card_screen/scanned_card_screen.dart';
import '../presentation/success_modal_one_screen/success_modal_one_screen.dart';
import '../presentation/success_modal_screen/binding/success_modal_binding.dart';
import '../presentation/success_modal_screen/success_modal_screen.dart';

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String loginScreen = '/login_screen';

  static const String secondLoginScreen = '/second_login_screen';

  static const String registerCardScreen = '/register_card_screen';

  static const String scannedCardScreen = '/scanned_card_screen';

  static const String successModalScreen = '/success_modal_screen';

  static const String homeScreen = '/home_screen';

  static const String dropOffScanScreen = '/drop_off_scan_screen';

  static const String attendanceLogScreen = '/attendance_log_screen';

  static const String successModalOneScreen = '/success_modal_one_screen';

  static const String changeSchoolCodeOneScreen =
      '/change_school_code_one_screen';

  static const String homeOneScreen = '/home_one_screen';

  static const String iphone1314FiveScreen = '/iphone_13_14_five_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static List<GetPage> pages = [
    //secondLoginScreen
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      bindings: [LoginBinding()],
    ),
    GetPage(
      name: secondLoginScreen,
      page: () => SecondLoginScreen(),
      bindings: [LoginBinding()],
    ),
    GetPage(
      name: registerCardScreen,
      page: () => RegisterCardScreen(),
      bindings: [RegisterCardBinding()],
    ),
    GetPage(
      name: scannedCardScreen,
      page: () => ScannedCardScreen(),
      bindings: [ScannedCardBinding()],
    ),
    GetPage(
      name: successModalScreen,
      page: () => SuccessModalScreen(),
      bindings: [SuccessModalBinding()],
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: dropOffScanScreen,
      page: () => DropOffScanScreen(),
      bindings: [DropOffScanBinding()],
    ),
    GetPage(
      name: attendanceLogScreen,
      page: () => AttendanceLogScreen(),
      bindings: [AttendanceLogBinding()],
    ),
    GetPage(
      name: successModalOneScreen,
      page: () => SuccessModalOneScreen(),
      bindings: [SuccessModalOneBinding()],
    ),
    GetPage(
      name: changeSchoolCodeOneScreen,
      page: () => ChangeSchoolCodeOneScreen(),
      bindings: [ChangeSchoolCodeOneBinding()],
    ),
    GetPage(
      name: homeOneScreen,
      page: () => HomeOneScreen(),
      bindings: [HomeOneBinding()],
    ),
    GetPage(
      name: iphone1314FiveScreen,
      page: () => Iphone1314FiveScreen(),
      bindings: [Iphone1314FiveBinding()],
    ),
    GetPage(
      name: appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [AppNavigationBinding()],
    ),
    GetPage(
      name: initialRoute,
      page: () => Iphone1314FiveScreen(),
      bindings: [Iphone1314FiveBinding()],
    ),
  ];
}
