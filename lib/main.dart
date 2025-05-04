import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pulsedevice/core/hiveDb/user_profile.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';
import 'core/app_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) async {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    // 初始化穿戴式sdk
    YcProductPlugin().initPlugin(isReconnectEnable: true, isLogEnable: true);
    await Hive.initFlutter();
    Hive.registerAdapter(UserProfileAdapter());
    await Hive.openBox<UserProfile>('user_profile');
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
