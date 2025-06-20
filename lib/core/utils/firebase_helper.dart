import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/service/notification_service.dart';
import 'package:pulsedevice/core/utils/config.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';

class FirebaseHelper {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await getDeviceToken();
    await _requestPermission();
    FirebaseMessaging.onBackgroundMessage(_handleMessage);
    FirebaseMessaging.onMessage.listen(_handleMessage);
  }

  static Future<void> _requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<String?> getDeviceToken() async {
    try {
      final token = await _messaging.getToken();
      print("🔑 Firebase Token: $token");
      return token;
    } catch (e) {
      print("❌ Failed to get FCM token: $e");
      return null;
    }
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      '推播通知',
      channelDescription: '用於展示推播訊息',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@drawable/ic_notification',
    );

    const platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      platformDetails,
    );
  }

  static Future<void> _handleMessage(RemoteMessage message) async {
    var title = "";
    var body = "";
    if (message.notification != null) {
      print('Message title: ${message.notification!.title}');
      print('Message body: ${message.notification!.body}');
      title = message.notification!.title!;
      body = message.notification!.body!;
    }
    if (shouldShowDialog(message)) {
      final value = message.data['alertDialog'];
      if (value.toString().contains(";")) {
        final split = value.split(';');
        final main = split[0];
        final sub = Config.apiId;
        final nickName = split[2].toString().isEmpty ? split[1] : split[2];
        final mainNitify = split[3];
        Future.delayed(Duration.zero, () async {
          final result = await DialogHelper.showFamilyRequestDialog(split[1]);
          if (result == true) {
            await postApi(main, sub, nickName, mainNitify);
          }
        });
      } else {
        Future.delayed(Duration.zero, () async {
          final comfirm = await DialogHelper.showFamilyConfirmDialog();
          if (comfirm!) {
            Get.back(result: true);
          }
        });
      }
    } else {
      if (title.isEmpty || body.isEmpty) return;
      NotificationService().showFromFirebaseNotification(title, body);
    }
  }

  /// 檢查是否應該顯示對話框
  static bool shouldShowDialog(RemoteMessage message) {
    final flag = message.data['alertDialog']?.toString().toLowerCase();
    if (flag == null) return false;
    return true;
  }

  static Future<void> postApi(
      String main, String sub, String nickName, String mainNitify) async {
    try {
      final payload = {
        "id": {
          "userId": main,
          "familyId": sub,
        },
        "notify": true, //緊報通知
        "abbreviation": nickName
      };
      var res = await ApiService().postJson(
        Api.familyBiding,
        payload,
      );

      if (res.isNotEmpty) {
        await sendFirebase(mainNitify);
      }
    } catch (e) {
      print("Notify API Error: $e");
    }
  }

  static Future<void> sendFirebase(token) async {
    try {
      final payload = {
        "token": token,
        "title": '分享數據',
        "content": '分享數據內容',
        "dataKey": "alertDialog",
        "dataVal": "true",
      };
      var res = await ApiService().postJson(
        Api.sendFirebase,
        payload,
      );

      if (res.isNotEmpty) {}
    } catch (e) {
      print("Notify API Error: $e");
    }
  }
}
