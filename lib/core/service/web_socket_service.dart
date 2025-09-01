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
typedef OnRateLimitCallback = void Function(String message);
// 🔥 新增：HTTP錯誤分類回調
typedef OnHttpClientErrorCallback = void Function(
    String message, int statusCode);
typedef OnHttpServerErrorCallback = void Function(
    String message, int statusCode);
typedef OnNetworkErrorCallback = void Function(String message);

class WebSocketService {
  final String url;
  final gc = Get.find<GlobalController>();
  WebSocketChannel? _channel;
  String? sessionId;
  bool _isConnecting = false;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 5;
  bool _isRateLimited = false;

  OnChunkCallback? onChunk;
  OnMessageStartCallback? onStart;
  OnMessageEndCallback? onEnd;
  OnErrorCallback? onError;
  OnHistoryResultCallback? onHistoryResult;
  OnSessionIdCallback? onSessionIdReceived;
  OnFeedbackResultCallback? onFeedbackResult;
  OnRateLimitCallback? onRateLimit;
  // 🔥 新增：HTTP錯誤分類回調
  OnHttpClientErrorCallback? onHttpClientError;
  OnHttpServerErrorCallback? onHttpServerError;
  OnNetworkErrorCallback? onNetworkError;

  bool get isConnected {
    return _channel != null &&
        _channel!.closeCode == null &&
        _channel!.closeReason == null;
  }

  bool get canSendMessage =>
      isConnected && sessionId != null && sessionId!.isNotEmpty;

  bool get isRateLimited => _isRateLimited;

  WebSocketService(this.url);

  Future<void> connect() async {
    print("connect url : $url");
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
        'user_id': gc.apiId.value
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

          // 🔥 新增：HTTP錯誤分類處理
          _handleWebSocketError(error);

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

      // 🔥 修改：擴展HTTP錯誤分類處理
      _handleConnectionError(e);
    }
  }

  /// 🔥 新增：處理連線階段的錯誤
  void _handleConnectionError(dynamic error) {
    final errorString = error.toString();

    // 檢查429錯誤
    if (errorString.contains('429')) {
      _isRateLimited = true;
      print('🚫 已達使用上限 (429)');
      onRateLimit?.call('已達使用上限');
      return; // 不觸發重連
    }

    // 🔥 新增：檢查HTTP 4xx 客戶端錯誤
    if (errorString.contains('400') ||
        errorString.contains('401') ||
        errorString.contains('403') ||
        errorString.contains('404')) {
      final statusCode = _extractHttpStatusCode(errorString);
      final message = _getClientErrorMessage(statusCode);
      print('🚫 HTTP 客戶端錯誤 ($statusCode): $message');
      onHttpClientError?.call(message, statusCode);
      return; // 不觸發重連
    }

    // 🔥 新增：檢查HTTP 5xx 服務器錯誤
    if (errorString.contains('500') ||
        errorString.contains('502') ||
        errorString.contains('503') ||
        errorString.contains('504')) {
      final statusCode = _extractHttpStatusCode(errorString);
      final message = _getServerErrorMessage(statusCode);
      print('🚫 HTTP 服務器錯誤 ($statusCode): $message');
      onHttpServerError?.call(message, statusCode);
      return; // 不觸發重連
    }

    // 🔥 新增：網路連線錯誤
    if (errorString.contains('Connection refused') ||
        errorString.contains('Network is unreachable') ||
        errorString.contains('No route to host')) {
      final message = '網路連線失敗，請檢查網路設定';
      print('🌐 網路連線錯誤: $message');
      onNetworkError?.call(message);
    }

    // 其他錯誤使用原有的onError回調
    print('❌ WebSocket 連線失敗: $error');
    onError?.call(error);
    _handleConnectionLoss();
  }

  /// 🔥 新增：處理WebSocket運行時的錯誤
  void _handleWebSocketError(dynamic error) {
    final errorString = error.toString();

    // 檢查HTTP錯誤狀態碼
    if (errorString.contains('400') ||
        errorString.contains('401') ||
        errorString.contains('403') ||
        errorString.contains('404')) {
      final statusCode = _extractHttpStatusCode(errorString);
      final message = _getClientErrorMessage(statusCode);
      print('🚫 WebSocket HTTP 客戶端錯誤 ($statusCode): $message');
      onHttpClientError?.call(message, statusCode);
      return;
    }

    if (errorString.contains('500') ||
        errorString.contains('502') ||
        errorString.contains('503') ||
        errorString.contains('504')) {
      final statusCode = _extractHttpStatusCode(errorString);
      final message = _getServerErrorMessage(statusCode);
      print('🚫 WebSocket HTTP 服務器錯誤 ($statusCode): $message');
      onHttpServerError?.call(message, statusCode);
      return;
    }

    // 其他錯誤使用原有的onError回調
    onError?.call(error);
  }

  /// 🔥 新增：從錯誤訊息中提取HTTP狀態碼
  int _extractHttpStatusCode(String errorString) {
    // 嘗試提取HTTP狀態碼
    final regex = RegExp(r'(\d{3})');
    final match = regex.firstMatch(errorString);
    if (match != null) {
      return int.tryParse(match.group(1) ?? '500') ?? 500;
    }
    return 500; // 預設值
  }

  /// 🔥 新增：獲取客戶端錯誤訊息
  String _getClientErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return '請求格式錯誤，請檢查輸入內容';
      case 401:
        return '認證失敗，請重新登入';
      case 403:
        return '權限不足，無法執行此操作';
      case 404:
        return '請求的資源不存在';
      default:
        return '客戶端錯誤 ($statusCode)';
    }
  }

  /// 🔥 新增：獲取服務器錯誤訊息
  String _getServerErrorMessage(int statusCode) {
    switch (statusCode) {
      case 500:
        return '服務器內部錯誤，請稍後再試';
      case 502:
        return '網關錯誤，服務暫時不可用';
      case 503:
        return '服務暫時不可用，請稍後再試';
      case 504:
        return '網關超時，請稍後再試';
      default:
        return '服務器錯誤 ($statusCode)';
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

  /// 重置 429 錯誤狀態
  void resetRateLimit() {
    _isRateLimited = false;
    print('✅ 已重置 429 錯誤狀態');
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
    final uriParser = Uri.parse(url).toString();
    print("uriParser : $uriParser");
    final cleaned = uriParser.trim();
    if (!cleaned.startsWith("ws://") && !cleaned.startsWith("wss://")) {
      throw FormatException("❌ WebSocket URL 必須以 ws:// 或 wss:// 開頭: $cleaned");
    }
    print("final websocket url : $cleaned");
    return Uri.parse(cleaned);
  }
}
