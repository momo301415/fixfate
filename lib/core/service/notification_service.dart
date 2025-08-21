import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:pulsedevice/core/app_export.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api_service.dart';
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

  ApiService service = ApiService();
  final gc = Get.find<GlobalController>();

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

  /// 🔄 新增：計算指定時間的下一次觸發
  tz.TZDateTime _nextTimeOfDay(tz.TZDateTime base, TimeOfDay timeOfDay) {
    final scheduled = tz.TZDateTime(
      tz.local,
      base.year,
      base.month,
      base.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );

    return scheduled.isBefore(base)
        ? scheduled.add(const Duration(days: 1))
        : scheduled;
  }

  /// 🔄 新增：清除所有用藥提醒
  Future<void> _cancelAllMedicationReminders() async {
    // 清除重複通知 (1001-1020)
    for (int id = 1001; id <= 1020; id++) {
      await _flutterLocalNotificationsPlugin.cancel(id);
    }

    // 清除間隔通知 (2000-2030, 3000-3030)
    for (int id = 2000; id <= 2030; id++) {
      await _flutterLocalNotificationsPlugin.cancel(id);
    }
    for (int id = 3000; id <= 3030; id++) {
      await _flutterLocalNotificationsPlugin.cancel(id);
    }

    print('✅ 已清除所有用藥提醒');
  }

  /// 🔄 新增：停止所有用藥提醒（公開方法）
  Future<void> stopAllMedicationReminders() async {
    try {
      await _cancelAllMedicationReminders();
      print('✅ 已停止所有用藥提醒');
    } catch (e) {
      print('❌ 停止用藥提醒失敗: $e');
      rethrow;
    }
  }

  // 🔄 保留原有的 _nextAt 方法（向後相容）
  tz.TZDateTime _nextAt(tz.TZDateTime base, int hour, int minute) {
    return _nextTimeOfDay(base, TimeOfDay(hour: hour, minute: minute));
  }

  // ========== 以下保留原有的其他通知方法 ==========

  Future<void> showDeviceDisconnectedNotification() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await _flutterLocalNotificationsPlugin.show(
      9999,
      'FIX FATE通知',
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
    await Future.delayed(const Duration(milliseconds: 500));
    await _flutterLocalNotificationsPlugin.show(
      9997,
      'FIX FATE通知',
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
    await Future.delayed(const Duration(milliseconds: 500));
    await _flutterLocalNotificationsPlugin.show(
      9998,
      'FIX FATE通知',
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

  Future<void> showDeviceSyncDataNotification() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await _flutterLocalNotificationsPlugin.show(
      9996,
      'FIX FATE通知',
      '與藍牙裝置資料同步通知',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'async_channel',
          '同步資料頻道',
          channelDescription: '這是藍芽裝置資料同步通知',
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
    await Future.delayed(const Duration(milliseconds: 500));
    await _flutterLocalNotificationsPlugin.show(
      9990,
      title,
      body,
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
    final scheduled = now.add(const Duration(seconds: 10));

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
    await _flutterLocalNotificationsPlugin.show(
      88888,
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
    final target = now.add(const Duration(seconds: 10));

    final success = await AndroidAlarmManager.oneShotAt(
      target,
      99999,
      testNotification,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );

    print('alarm schedule result: $success');
  }
}
