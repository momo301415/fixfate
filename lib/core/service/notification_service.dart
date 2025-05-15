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

  Future<bool> _canScheduleExactAlarms() async {
    if (Platform.isAndroid) {
      final androidPlugin = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      return await androidPlugin?.canScheduleExactNotifications() ?? false;
    }
    return false;
  }

  Future<void> _requestExactAlarmPermission() async {
    if (Platform.isAndroid) {
      final androidPlugin = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await androidPlugin?.requestExactAlarmsPermission();
    }
  }

  Future<void> scheduleReminder(String frequency) async {
    // 取消所有已排程的通知
    await _flutterLocalNotificationsPlugin.cancelAll();

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final List<tz.TZDateTime> scheduledDates = [];

    switch (frequency) {
      case '三天一次':
        scheduledDates.add(_nextInstanceOfTime(now, 8, 0));
        for (int i = 1; i <= 10; i++) {
          scheduledDates.add(scheduledDates[0].add(Duration(days: i * 3)));
        }
        break;
      case '兩天一次':
        scheduledDates.add(_nextInstanceOfTime(now, 8, 0));
        for (int i = 1; i <= 15; i++) {
          scheduledDates.add(scheduledDates[0].add(Duration(days: i * 2)));
        }
        break;
      case '每天一次':
        for (int i = 0; i < 30; i++) {
          scheduledDates
              .add(_nextInstanceOfTime(now.add(Duration(days: i)), 8, 0));
        }
        break;
      case '一天兩次':
        for (int i = 0; i < 30; i++) {
          scheduledDates
              .add(_nextInstanceOfTime(now.add(Duration(days: i)), 8, 0));
          scheduledDates
              .add(_nextInstanceOfTime(now.add(Duration(days: i)), 18, 0));
        }
        break;
      case '一天三次':
        for (int i = 0; i < 30; i++) {
          scheduledDates
              .add(_nextInstanceOfTime(now.add(Duration(days: i)), 8, 0));
          scheduledDates
              .add(_nextInstanceOfTime(now.add(Duration(days: i)), 13, 0));
          scheduledDates
              .add(_nextInstanceOfTime(now.add(Duration(days: i)), 18, 0));
        }
        break;
      case '一天四次':
        for (int i = 0; i < 30; i++) {
          scheduledDates
              .add(_nextInstanceOfTime(now.add(Duration(days: i)), 8, 0));
          scheduledDates
              .add(_nextInstanceOfTime(now.add(Duration(days: i)), 13, 0));
          scheduledDates
              .add(_nextInstanceOfTime(now.add(Duration(days: i)), 18, 0));
          scheduledDates
              .add(_nextInstanceOfTime(now.add(Duration(days: i)), 22, 0));
        }
        break;
      case '每晚一次':
        for (int i = 0; i < 30; i++) {
          scheduledDates
              .add(_nextInstanceOfTime(now.add(Duration(days: i)), 18, 0));
        }
        break;
      default:
        // 預設為每天早上8點
        for (int i = 0; i < 30; i++) {
          scheduledDates
              .add(_nextInstanceOfTime(now.add(Duration(days: i)), 8, 0));
        }
        break;
    }

    final bool hasExactAlarmPermission = await _canScheduleExactAlarms();

    if (!hasExactAlarmPermission) {
      await _requestExactAlarmPermission();
      // 等待使用者授權後再嘗試排程通知
      return;
    }

    for (int i = 0; i < scheduledDates.length; i++) {
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        i,
        '用藥提醒',
        '該服藥了，請按時服用。',
        scheduledDates[i],
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
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  tz.TZDateTime _nextInstanceOfTime(tz.TZDateTime from, int hour, int minute) {
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, from.year, from.month, from.day, hour, minute);
    if (scheduledDate.isBefore(from)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
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
}
