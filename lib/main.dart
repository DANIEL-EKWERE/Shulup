import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_export.dart';
import 'package:overlay_kit/overlay_kit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    value,
  ) {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return OverlayKit(
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme,
              translations: AppLocalization(),
              locale: Locale('en', ''),
              fallbackLocale: Locale('en', ''),
              title: 'schulup',
              initialRoute: AppRoutes.initialRoute,
              getPages: AppRoutes.pages,
              builder: (context, child) {
                // return MediaQuery(
                //   data: MediaQuery.of(
                //     context,
                //   ).copyWith(textScaler: TextScaler.linear(1.0)),
                //   child: child!,
                // );
                final mediaQuery = MediaQuery.maybeOf(context);
                if (mediaQuery == null) return child!; // safety for first build
                return MediaQuery(
                  data: mediaQuery.copyWith(
                    textScaler: const TextScaler.linear(1.0),
                  ),
                  child: child!,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
