import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:pulsedevice/core/global_controller.dart';

typedef OnChunkCallback = void Function(String text);
typedef OnMessageStartCallback = void Function(String id);
typedef OnMessageEndCallback = void Function(String id);
typedef OnErrorCallback = void Function(dynamic error);
typedef OnHistoryResultCallback = void Function(
    List<Map<String, dynamic>> history);
typedef OnSessionIdCallback = void Function(String sessionId);
typedef OnFeedbackResultCallback = void Function(bool success);

class WebSocketService {
  final String url;
  final gc = Get.find<GlobalController>();
  WebSocketChannel? _channel;
  String? sessionId;
  bool _isConnecting = false;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 5;

  OnChunkCallback? onChunk;
  OnMessageStartCallback? onStart;
  OnMessageEndCallback? onEnd;
  OnErrorCallback? onError;
  OnHistoryResultCallback? onHistoryResult;
  OnSessionIdCallback? onSessionIdReceived;
  OnFeedbackResultCallback? onFeedbackResult;

  bool get isConnected {
    return _channel != null &&
        _channel!.closeCode == null &&
        _channel!.closeReason == null;
  }

  bool get canSendMessage =>
      isConnected && sessionId != null && sessionId!.isNotEmpty;

  WebSocketService(this.url);

  Future<void> connect() async {
    // 🔥 確保舊連接完全清理
    if (_channel != null) {
      _channel!.sink.close();
      _channel = null;
    }

    if (_isConnecting) {
      print('⚠️ WebSocket 正在連線中');
      return;
    }

    _isConnecting = true;
    print('🔄 WebSocket 連線中... (嘗試 ${_reconnectAttempts + 1})');

    try {
      // 準備 headers
      final headers = <String, String>{
        'X-API-Key': gc.chatApiKeyValue.value,
        'user_id': gc.userId.value
      };

      print('🔑 使用 API Key: ${gc.chatApiKeyValue.value}');

      // 使用 dart:io WebSocket.connect 支援 headers
      final webSocket = await WebSocket.connect(
        safeParseUrl(url).toString(),
        headers: headers,
      );

      // 包裝成 WebSocketChannel
      _channel = IOWebSocketChannel(webSocket);

      _channel!.stream.listen(
        (event) {
          _handleIncomingMessage(event);
          _reconnectAttempts = 0; // 連線成功，重置重連計數
        },
        onError: (error) {
          print('❌ WebSocket 錯誤: $error');
          _isConnecting = false;
          onError?.call(error);
          _handleConnectionLoss();
        },
        onDone: () {
          print('📡 WebSocket 連線關閉');
          _isConnecting = false;
          _handleConnectionLoss();
        },
      );

      _isConnecting = false;

      // 只在沒有有效 session 時才請求
      _requestSessionIfNeeded();
    } catch (e) {
      _isConnecting = false;
      print('❌ WebSocket 連線失敗: $e');
      onError?.call(e);
      _handleConnectionLoss();
    }
  }

  void _requestSessionIfNeeded() {
    if (sessionId == null || sessionId!.isEmpty) {
      print('📋 請求新的 session_id...');
      _send({"type": "sendmessage", "action": "get_session_id"});
    } else {
      print('✅ 重用現有 session_id: $sessionId');
      // 🔥 直接觸發回調，session 已可用，支援會話延續
      Future.microtask(() => onSessionIdReceived?.call(sessionId!));
    }
  }

  void _handleConnectionLoss() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      print('❌ 達到最大重連次數 ($_maxReconnectAttempts)，停止重連');
      _reconnectAttempts = 0;
      return;
    }

    final delaySeconds = _getReconnectDelay();
    print(
        '⏳ ${delaySeconds}秒後嘗試重連... (${_reconnectAttempts + 1}/$_maxReconnectAttempts)');

    Future.delayed(Duration(seconds: delaySeconds), () {
      if (!isConnected && !_isConnecting) {
        _reconnectAttempts++;
        connect();
      }
    });
  }

  int _getReconnectDelay() {
    switch (_reconnectAttempts) {
      case 0:
        return 1; // 第一次重連：1秒
      case 1:
        return 3; // 第二次重連：3秒
      case 2:
        return 5; // 第三次重連：5秒
      default:
        return 10; // 後續重連：10秒
    }
  }

  /// 使用者發問
  void ask({
    required String userId,
    required String message,
    required String topicId,
    String ragType = 'health',
  }) {
    if (!canSendMessage) {
      print('❌ WebSocket 未準備好，無法發送訊息');
      return;
    }

    final payload = {
      "type": "sendmessage",
      "action": "ask",
      "user_id": userId,
      "message": message,
      "session_id": sessionId,
      "topic_id": topicId,
      "rag_type": ragType,
    };

    print('📤 發送提問: topic=$topicId, session=$sessionId');
    _send(payload);
  }

  /// 查詢歷史紀錄
  void sendHistory({
    required String userId,
    String ragType = 'health',
  }) {
    _send({
      "type": "sendmessage",
      "action": "history",
      "user_id": userId,
      "rag_type": ragType,
    });
  }

  /// 傳送回饋
  void sendFeedback({
    required String id,
    required int rating, // 1=正面, 0=負面
    String? feedbackText,
  }) {
    _send({
      "type": "sendmessage",
      "action": "feedback",
      "id": id,
      "rating": rating,
      "feedback_text": feedbackText ?? "",
    });
  }

  void _send(Map<String, dynamic> data) {
    final jsonString = jsonEncode(data);
    _channel?.sink.add(jsonString);
  }

  void _handleIncomingMessage(String data) {
    final json = jsonDecode(data);

    if (json.containsKey('type')) {
      switch (json['type']) {
        case 'start':
          onStart?.call(json['id']);
          break;
        case 'chunk':
          onChunk?.call(json['text']);
          break;
        case 'end':
          onEnd?.call(json['id']);
          break;
        case 'session_id':
          final newSessionId = json['session_id'];
          if (sessionId == null || sessionId != newSessionId) {
            sessionId = newSessionId;
            print('🎯 更新 session_id: $sessionId');
          }
          onSessionIdReceived?.call(sessionId!);
          break;
        case 'history_result':
          final history = List<Map<String, dynamic>>.from(json['history']);
          onHistoryResult?.call(history);
          break;
        case 'feedback_received':
          final success = json['success'] == true;
          onFeedbackResult?.call(success);
          break;
        default:
          print('🔔 未處理的 WebSocket 訊息: ${json['type']}');
      }
    }
    // 若沒有 type，但有 history，就當作 history 結果處理
    else if (json.containsKey('history')) {
      final historyRaw = json['history'];
      if (historyRaw is String) {
        try {
          final parsedList = jsonDecode(historyRaw);
          if (parsedList is List) {
            final history = List<Map<String, dynamic>>.from(parsedList);
            onHistoryResult?.call(history);
          } else {
            print('⚠️ history 字串解析後不是 List');
          }
        } catch (e) {
          print('❌ history JSON 解析失敗: $e');
        }
      } else {
        print('⚠️ history 欄位不是字串: ${historyRaw.runtimeType}');
      }
    } else {
      print('🪵 收到未知格式的資料: $json');
    }
  }

  void manualReconnect() {
    print('🔄 手動重連...');
    _reconnectAttempts = 0;
    disconnect();
    Future.delayed(const Duration(milliseconds: 500), () {
      connect();
    });
  }

  void forceNewSession() {
    sessionId = null;
    if (isConnected) {
      print('🔄 強制請求新 session...');
      _send({"type": "sendmessage", "action": "get_session_id"});
    }
  }

  void disconnect() {
    _isConnecting = false;
    _reconnectAttempts = 0;

    // 🔥 完全清理 WebSocket 資源
    if (_channel != null) {
      _channel!.sink.close();
      _channel = null; // 🔥 關鍵：清空 channel 引用
    }

    print('📤 WebSocket 已斷線並清理資源');
  }

  Uri safeParseUrl(String url) {
    final cleaned = url.trim();
    if (!cleaned.startsWith("ws://") && !cleaned.startsWith("wss://")) {
      throw FormatException("❌ WebSocket URL 必須以 ws:// 或 wss:// 開頭: $cleaned");
    }
    return Uri.parse(cleaned);
  }
}
