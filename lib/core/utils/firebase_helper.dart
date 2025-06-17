import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
    if (message.notification != null) {
      print('Message title: ${message.notification!.title}');
      print('Message body: ${message.notification!.body}');
    }
  }
}
