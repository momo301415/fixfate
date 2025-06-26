import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
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

  // 單一通知排程
  Future<void> _scheduleNotification({
    required int id,
    required tz.TZDateTime dateTime,
    required String title,
  }) async {
    print('⏰ 排程通知: id=$id time=$dateTime title=$title');
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      '用藥提醒',
      title,
      dateTime,
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
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// 主排程方法
  Future<void> scheduleReminder(String frequency) async {
    // 清除所有相關通知（但不是 cancelAll）
    for (int id = 1000; id < 1100; id++) {
      await _flutterLocalNotificationsPlugin.cancel(id);
    }

    final now = tz.TZDateTime.now(tz.local);
    int id = 1000;

    for (int i = 0; i < 30; i++) {
      final base = now.add(Duration(days: i));
      switch (frequency) {
        case '三天一次':
          if (i % 3 == 0) {
            await _scheduleNotification(
              id: id++,
              dateTime: _nextAt(base, 8, 0),
              title: '三天一次服藥提醒',
            );
          }
          break;
        case '兩天一次':
          if (i % 2 == 0) {
            await _scheduleNotification(
              id: id++,
              dateTime: _nextAt(base, 8, 0),
              title: '兩天一次服藥提醒',
            );
          }
          break;
        case '每天一次':
          await _scheduleNotification(
            id: id++,
            dateTime: _nextAt(base, 8, 0),
            title: '每天服藥提醒',
          );
          // await testImmediateNotification();
          // scheduleAlarmNotification();
          break;
        case '一天兩次':
          await _scheduleNotification(
              id: id++, dateTime: _nextAt(base, 8, 0), title: '早上服藥提醒');
          await _scheduleNotification(
              id: id++, dateTime: _nextAt(base, 18, 0), title: '晚上服藥提醒');
          break;
        case '一天三次':
          await _scheduleNotification(
              id: id++, dateTime: _nextAt(base, 8, 0), title: '早上服藥提醒');
          await _scheduleNotification(
              id: id++, dateTime: _nextAt(base, 13, 0), title: '中午服藥提醒');
          await _scheduleNotification(
              id: id++, dateTime: _nextAt(base, 18, 0), title: '晚上服藥提醒');
          break;
        case '一天四次':
          await _scheduleNotification(
              id: id++, dateTime: _nextAt(base, 8, 0), title: '早上服藥提醒');
          await _scheduleNotification(
              id: id++, dateTime: _nextAt(base, 13, 0), title: '中午服藥提醒');
          await _scheduleNotification(
              id: id++, dateTime: _nextAt(base, 18, 0), title: '傍晚服藥提醒');
          await _scheduleNotification(
              id: id++, dateTime: _nextAt(base, 22, 0), title: '晚上服藥提醒');
          break;
        case '每晚一次':
          await _scheduleNotification(
              id: id++, dateTime: _nextAt(base, 18, 0), title: '晚上服藥提醒');
          break;
      }
    }
  }

  /// 傳回距離 base 最近的某時間點（今天還沒到就今天，否則明天）
  tz.TZDateTime _nextAt(tz.TZDateTime base, int hour, int minute) {
    final dt =
        tz.TZDateTime(tz.local, base.year, base.month, base.day, hour, minute);
    return dt.isBefore(tz.TZDateTime.now(tz.local))
        ? dt.add(const Duration(days: 1))
        : dt;
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

  Future<void> showFromFirebaseNotification(String title, String body) async {
    await Future.delayed(Duration(milliseconds: 500)); // 等待 UI 穩定
    await _flutterLocalNotificationsPlugin.show(
      9990,
      '$title',
      '$body',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'connect_channel',
          'firebase頻道',
          channelDescription: '這是firebase通知',
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
      '十秒後應該跳出',
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
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  @pragma('vm:entry-point')
  Future<void> testNotification() async {
    print("scheduleAlarmNotification");
    // 發送通知
    await _flutterLocalNotificationsPlugin.show(
      88888, // 任意 id
      '鬧鐘通知',
      '這是在 kill app 後跳出的通知',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_channel',
          '鬧鐘通知',
          channelDescription: '在 kill app 後觸發的鬧鐘通知',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  void scheduleAlarmNotification() async {
    final now = DateTime.now();
    final target = now.add(Duration(seconds: 10));

    final success = await AndroidAlarmManager.oneShotAt(
      target,
      99999, // alarm 的唯一 ID
      testNotification,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );

    print('alarm schedule result: $success');
  }
}
