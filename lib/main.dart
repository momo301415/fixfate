import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pulsedevice/core/global_controller.dart';

import 'core/app_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) async {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    await Firebase.initializeApp();
    Get.put(GlobalController()); // 註冊為全域單例
    GlobalController().setupIosMessageChannel();
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        translations: AppLocalization(),
        locale: Locale('en', ''),
        fallbackLocale: Locale('en', ''),
        supportedLocales: const [
          Locale("en", ""),
          Locale("zh", "TW"),
        ],
        title: 'pulsedevice',
        initialRoute: AppRoutes.initialRoute,
        getPages: AppRoutes.pages,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(1.0),
            ),
            child: child!,
          );
        },
      );
    });
  }
}
