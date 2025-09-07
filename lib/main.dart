import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:pulsedevice/core/chat_screen_controller.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/presentation/k5_screen/controller/k5_controller.dart';

import 'core/app_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) async {
    LoggerH.init(kReleaseMode ? LogMode.live : LogMode.debug);
    await Firebase.initializeApp();
    PrefUtils().init();
    Get.put(GlobalController()); // 註冊為全域單例
    // 將運動controller放在這裡，全 app 可用
    Get.put(K5Controller(), permanent: true);
    // 全局縮放聊天室
    Get.put(ChatScreenController());
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
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        translations: AppLocalization(),
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
        routingCallback: (Routing? routing) {
          // 在路由变化时触发
          if (routing != null) {
            
            Logger().d('当前路由: ${routing.current}');
            Logger().d('之前路由: ${routing.previous}');
            Logger().d('路由类型: ${routing.runtimeType}'); // 例如，跳转、返回、弹出对话框等

          
          }
        },
      );
    });
  }
}
