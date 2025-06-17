import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      _flutterLocalNotificationsPlugin;

  Future<void> initialize() async {
    // 初始化時區
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    // Android 初始化設定
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS 初始化設定
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    // 綜合初始化設定
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleReminder(String frequency) async {
    await _flutterLocalNotificationsPlugin.cancelAll(); // 清除舊通知

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    int notificationId = 0;

    tz.TZDateTime _nextInstanceOfTime(
        tz.TZDateTime from, int hour, int minute) {
      tz.TZDateTime scheduledDate = tz.TZDateTime(
          tz.local, from.year, from.month, from.day, hour, minute);
      if (scheduledDate.isBefore(from)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }
      return scheduledDate;
    }

    Future<void> scheduleNotification(
        tz.TZDateTime scheduledTime, String title, int id) async {
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        '用藥提醒',
        title,
        scheduledTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'medication_channel',
            '用藥提醒',
            channelDescription: '提醒您按時服藥',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: null,
      );
    }

    for (int i = 0; i < 30; i++) {
      final baseDate = now.add(Duration(days: i));
      switch (frequency) {
        case '三天一次':
          if (i % 3 == 0) {
            final time = _nextInstanceOfTime(baseDate, 8, 0);
            await scheduleNotification(time, '三天一次服藥提醒', notificationId++);
          }
          break;
        case '兩天一次':
          if (i % 2 == 0) {
            final time = _nextInstanceOfTime(baseDate, 8, 0);
            await scheduleNotification(time, '兩天一次服藥提醒', notificationId++);
          }
          break;
        case '每天一次':
          final time = _nextInstanceOfTime(baseDate, 8, 0);
          await scheduleNotification(time, '每天服藥提醒', notificationId++);
          break;
        case '一天兩次':
          await scheduleNotification(
              _nextInstanceOfTime(baseDate, 8, 0), '早上服藥提醒', notificationId++);
          await scheduleNotification(
              _nextInstanceOfTime(baseDate, 18, 0), '晚上服藥提醒', notificationId++);
          break;
        case '一天三次':
          await scheduleNotification(
              _nextInstanceOfTime(baseDate, 8, 0), '早上服藥提醒', notificationId++);
          await scheduleNotification(
              _nextInstanceOfTime(baseDate, 13, 0), '中午服藥提醒', notificationId++);
          await scheduleNotification(
              _nextInstanceOfTime(baseDate, 18, 0), '晚上服藥提醒', notificationId++);
          break;
        case '一天四次':
          await scheduleNotification(
              _nextInstanceOfTime(baseDate, 8, 0), '早上服藥提醒', notificationId++);
          await scheduleNotification(
              _nextInstanceOfTime(baseDate, 13, 0), '中午服藥提醒', notificationId++);
          await scheduleNotification(_nextInstanceOfTime(baseDate, 15, 51),
              '傍晚服藥提醒', notificationId++);
          await scheduleNotification(
              _nextInstanceOfTime(baseDate, 22, 0), '晚上服藥提醒', notificationId++);
          break;
        case '每晚一次':
          await scheduleNotification(
              _nextInstanceOfTime(baseDate, 18, 0), '晚上服藥提醒', notificationId++);
          break;
        default:
          final time = _nextInstanceOfTime(baseDate, 8, 0);
          await scheduleNotification(time, '預設服藥提醒', notificationId++);
          break;
      }
    }
  }

  Future<void> showDeviceDisconnectedNotification() async {
    await Future.delayed(Duration(milliseconds: 500)); // 等待 UI 穩定
    await _flutterLocalNotificationsPlugin.show(
      9999,
      'PulesRing通知',
      '藍芽裝置斷線通知',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'connect_channel',
          '連線頻道',
          channelDescription: '這是藍芽連線通知',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  Future<void> showDeviceConnectedNotification() async {
    await Future.delayed(Duration(milliseconds: 500)); // 等待 UI 穩定
    await _flutterLocalNotificationsPlugin.show(
      9997,
      'PulesRing通知',
      '藍芽裝置已連線通知',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'connect_channel',
          '連線頻道',
          channelDescription: '這是藍芽連線通知',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  Future<void> showDeviceLowPowerNotification() async {
    await Future.delayed(Duration(milliseconds: 500)); // 等待 UI 穩定
    await _flutterLocalNotificationsPlugin.show(
      9998,
      'PulesRing通知',
      '藍芽裝置低電量通知',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'connect_channel',
          '低電量頻道',
          channelDescription: '這是藍芽裝置低電量通知',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  Future<bool> canScheduleExactAlarms() async {
    if (Platform.isAndroid) {
      final androidPlugin = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      return await androidPlugin?.canScheduleExactNotifications() ?? false;
    }
    return false;
  }

  Future<void> requestExactAlarmPermission() async {
    if (Platform.isAndroid) {
      final androidImpl = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      final granted =
          await androidImpl?.canScheduleExactNotifications() ?? false;
      if (!granted) {
        await androidImpl?.requestExactAlarmsPermission();
      }
    }
  }

  Future<void> showGoalNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await FlutterLocalNotificationsPlugin().show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'goal_channel',
          '目標通知',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> testImmediateNotification() async {
    final now = tz.TZDateTime.now(tz.local);
    final scheduled = now.add(Duration(seconds: 10)); // 現在 + 2 分鐘

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      12345,
      '測試通知',
      '兩分鐘後應該跳出',
      scheduled,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          '測試頻道',
          channelDescription: '用於測試排程通知',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
