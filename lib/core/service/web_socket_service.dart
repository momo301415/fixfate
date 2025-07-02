import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

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
  WebSocketChannel? _channel;
  String? sessionId;

  OnChunkCallback? onChunk;
  OnMessageStartCallback? onStart;
  OnMessageEndCallback? onEnd;
  OnErrorCallback? onError;
  OnHistoryResultCallback? onHistoryResult;
  OnSessionIdCallback? onSessionIdReceived;
  OnFeedbackResultCallback? onFeedbackResult;

  bool get isConnected => _channel != null && _channel!.closeCode == null;

  WebSocketService(this.url);

  void connect() {
    _channel = WebSocketChannel.connect(safeParseUrl(url));

    _channel!.stream.listen(
      (event) {
        _handleIncomingMessage(event);
      },
      onError: (error) {
        onError?.call(error);
        reconnect();
      },
      onDone: () {
        reconnect();
      },
    );

    // 初始化 session_id
    _send({"type": "sendmessage", "action": "get_session_id"});
  }

  void reconnect() {
    Future.delayed(const Duration(seconds: 3), () {
      connect();
    });
  }

  /// 使用者發問
  void ask({
    required String userId,
    required String message,
    required String topicId,
    String ragType = 'health',
  }) {
    if (sessionId == null) return;

    _send({
      "type": "sendmessage",
      "action": "ask",
      "user_id": userId,
      "message": message,
      "session_id": sessionId,
      "topic_id": topicId,
      "rag_type": ragType,
    });
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
    // 若 type 存在就走 switch
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
          sessionId = json['session_id'];
          print('🎯 WebSocket session_id 初始化成功: $sessionId');
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
          print('🔔 Unhandled WebSocket message: $json');
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

  void disconnect() {
    _channel?.sink.close();
  }

  Uri safeParseUrl(String url) {
    final cleaned = url.trim();
    if (!cleaned.startsWith("ws://") && !cleaned.startsWith("wss://")) {
      throw FormatException("❌ WebSocket URL 必須以 ws:// 或 wss:// 開頭: $cleaned");
    }
    return Uri.parse(cleaned);
  }
}
