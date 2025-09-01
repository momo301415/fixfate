import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

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

  /// 儲存需要延遲處理的訊息（背景或關閉 App 點推播）
  static RemoteMessage? _pendingDialogMessage;

  /// 防抖動機制 - 使用 Set 原子性操作防止重複顯示 Dialog
  static final Set<String> _processingMessages = <String>{};
  static final Map<String, DateTime> _messageHistory = {};
  static var count = 0;
  static Future<void> init() async {
    await getDeviceToken();
    await _requestPermission();

    // 🔴 關閉 App 點推播啟動
    final initMsg = await _messaging.getInitialMessage();
    if (initMsg != null && shouldShowDialog(initMsg)) {
      print("🔴 App 從關閉狀態啟動，儲存推播訊息");
      _pendingDialogMessage = initMsg;
      // 延遲處理，等待 App 完全載入
      Future.delayed(Duration(seconds: 2), () {
        _processPendingMessage();
      });
    }

    // 🟠 App 背景 → 點推播 → 返回 App
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (shouldShowDialog(message)) {
        print("🟠 App 從背景恢復，儲存推播訊息");
        _pendingDialogMessage = message;
        // 延遲處理，等待 App 完全載入
        Future.delayed(Duration(seconds: 1), () {
          _processPendingMessage();
        });
      }
    });

    // 🟢 App 前景收到推播
    FirebaseMessaging.onMessage.listen(handleMessage);

    // 🟤 後台推播（主要用於 Android background handler）
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
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

  static Future<void> handleMessage(RemoteMessage message) async {
    // 步驟 1: 生成唯一識別鍵
    final messageKey = _generateMessageKey(message);

    // 步驟 2: 原子性檢查 - 核心防抖動機制
    if (!_processingMessages.add(messageKey)) {
      print("🚫 防抖動觸發：訊息正在處理中 - $messageKey");
      return; // 立即返回，不執行後續邏輯
    }

    // 步驟 3: 雙重保險 - 時間窗口檢查
    if (_isRecentlyProcessed(messageKey)) {
      _processingMessages.remove(messageKey); // 釋放鎖定
      print("🚫 防抖動觸發：最近已處理過 - $messageKey");
      return;
    }

    try {
      // 步驟 4: 記錄處理時間
      _messageHistory[messageKey] = DateTime.now();
      print("✅ 開始處理訊息 - $messageKey");

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
            count++;
            print("family confirm dialog : $count");
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
    } finally {
      // 步驟 5: 確保釋放鎖定
      _processingMessages.remove(messageKey);
      print("🔓 釋放訊息鎖定 - $messageKey");

      // 步驟 6: 清理舊記錄
      _cleanupOldHistory();
    }
  }

  @pragma('vm:entry-point')
  static Future<void> backgroundHandler(RemoteMessage message) async {
    await handleMessage(message); // 共用同邏輯
  }

  /// 檢查是否應該顯示對話框
  static bool shouldShowDialog(RemoteMessage message) {
    final flag = message.data['alertDialog']?.toString().toLowerCase();
    if (flag == null) return false;
    return true;
  }

  /// 處理待處理的推播訊息
  static void _processPendingMessage() {
    print("🔄 _processPendingMessage called");
    final message = _pendingDialogMessage;
    if (message != null) {
      print("✅ 處理待處理的推播訊息: $message");
      _pendingDialogMessage = null;
      Future.delayed(Duration(milliseconds: 500), () async {
        try {
          await handleMessage(message);
        } catch (e) {
          print("❌ 處理待處理訊息時發生錯誤: $e");
        }
      });
    } else {
      print("ℹ️ 沒有待處理的推播訊息");
    }
  }

  /// 提供給首頁呼叫，顯示 Dialog 用
  static RemoteMessage? consumePendingDialogMessage() {
    print("enter consumePendingDialogMessage");
    final msg = _pendingDialogMessage;
    print("consumePendingDialogMessage -> msg: $msg");
    _pendingDialogMessage = null;
    return msg;
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

  /// 生成訊息唯一識別鍵
  static String _generateMessageKey(RemoteMessage message) {
    final messageId = message.messageId ?? '';
    final dataVal = message.data['alertDialog'] ?? '';
    final title = message.notification?.title ?? '';
    final body = message.notification?.body ?? '';

    // 組合多個特徵確保唯一性
    return "${messageId}_${dataVal}_${title}_${body}";
  }

  /// 檢查是否最近已處理過
  static bool _isRecentlyProcessed(String messageKey) {
    final lastTime = _messageHistory[messageKey];
    if (lastTime == null) return false;

    final diff = DateTime.now().difference(lastTime);
    return diff < Duration(seconds: 1); // 1秒內算重複
  }

  /// 清理舊的歷史記錄
  static void _cleanupOldHistory() {
    final cutoff = DateTime.now().subtract(Duration(minutes: 5));
    _messageHistory.removeWhere((key, time) => time.isBefore(cutoff));

    // 限制記錄數量，防止無限增長
    if (_messageHistory.length > 100) {
      final sortedEntries = _messageHistory.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));

      // 保留最新的 50 筆記錄
      _messageHistory.clear();
      for (var entry in sortedEntries.take(50)) {
        _messageHistory[entry.key] = entry.value;
      }
    }
  }
}
