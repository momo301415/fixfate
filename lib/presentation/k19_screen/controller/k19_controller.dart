import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:pulsedevice/core/chat_screen_controller.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/service/web_socket_service.dart';
import 'package:pulsedevice/presentation/k19_screen/models/chat_message_model.dart';
import 'package:pulsedevice/presentation/k20_screen/models/chat_message_model.dart'
    as k20;
import '../../../core/app_export.dart';

/// A controller class for the K19Screen.
///
/// This class manages the state of the K19Screen, including the
/// current k19ModelObj
class K19Controller extends GetxController {
  final WebSocketService socketService = WebSocketService(Api.socketUrl);
  final RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;
  TextEditingController searchoneController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final chatScreenController = Get.find<ChatScreenController>();
  final gc = Get.find<GlobalController>();
  final cc = Get.find<ChatScreenController>();
  late String topicId;
  String _currentAnswer = "";
  String? _currentMessageId;
  bool _isSocketInitialized = false;
  final RxBool isHistoryLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _generateNewTopicId();
  }

  @override
  void onReady() {
    super.onReady();
    messages.clear();
  }

  // 🔥 載入歷史對話 - 改為公開方法，供外部調用
  void loadHistoryConversation({
    required String historyTopicId,
    required String sessionId,
    required List<k20.ChatMessageModel> historyMessages,
  }) {
    topicId = historyTopicId;

    print(
        '📜 載入歷史對話 - Topic: $topicId, Session: $sessionId, 訊息數: ${historyMessages.length}');

    // 🔥 將K20的ChatMessageModel轉換為K19使用的格式
    messages.clear();
    for (final k20Msg in historyMessages) {
      // 用戶訊息
      if (k20Msg.message?.value?.isNotEmpty == true) {
        messages.add(ChatMessageModel(
          text: k20Msg.message!.value!,
          isUser: true,
          id: k20Msg.id?.value ??
              DateTime.now().millisecondsSinceEpoch.toString(),
        ));
      }

      // AI 回應
      if (k20Msg.botResponse?.value?.isNotEmpty == true) {
        messages.add(ChatMessageModel(
          text: k20Msg.botResponse!.value!,
          isUser: false,
          id: k20Msg.id?.value ??
              DateTime.now().millisecondsSinceEpoch.toString(),
        ));
      }
    }

    print('✅ 載入了 ${messages.length} 則歷史訊息');

    // 🔥 設定 WebSocket 使用相同的 session_id（如果還有效的話）
    if (sessionId.isNotEmpty) {
      socketService.sessionId = sessionId;
      print('🔄 重用 session_id: $sessionId');
    }

    // 初始化 WebSocket 連線
    ensureWebSocketConnected();

    // 滾動到底部
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });
  }

  // 🔥 生成新的對話 ID
  void _generateNewTopicId() {
    topicId = _generateNewUUID();
    print('🆕 創建新對話會話，Topic ID: $topicId');
  }

  String _generateNewUUID() {
    const uuid = Uuid();
    return uuid.v4();
  }

  void ensureWebSocketConnected() {
    if (_isSocketInitialized && socketService.isConnected) {
      print('✅ WebSocket 已連接且已初始化');
      return;
    }

    print('🚀 初始化 WebSocket...');
    _initializeWebSocket();
  }

  void _initializeWebSocket() {
    if (_isSocketInitialized) {
      // 已初始化但可能斷線，嘗試重連
      socketService.connect();
      return;
    }

    _isSocketInitialized = true;

    socketService.onStart = (id) {
      _currentMessageId = id;
      _currentAnswer = "";
      messages.add(ChatMessageModel(text: "", isUser: false, id: id));
    };

    socketService.onChunk = (chunk) {
      _currentAnswer += chunk;
      _updateLastMessageText(_currentAnswer);
    };

    socketService.onEnd = (id) {
      _currentMessageId = null;
    };

    socketService.onSessionIdReceived = (id) {
      print('🎯 K19 收到 session_id: $id');
      // 根據新需求，不自動載入歷史對話
      // 若有暫存訊息，送出
      _ifChatInputIsNotEmpty();
    };

    socketService.onError = (err) {
      print("❌ WebSocket 錯誤: $err");
      // 讓 WebSocketService 自己處理重連
    };

    // 開始連線
    socketService.connect();
  }

  /// 檢查使用者輸入從上一頁過來是否為空
  void _ifChatInputIsNotEmpty() {
    if (gc.chatInput.value.isNotEmpty) {
      searchoneController.text = gc.chatInput.value;
      gc.chatInput.value = ''; // 清空
      sendUserMessage();
    }
  }

  void _updateLastMessageText(String text) {
    if (messages.isNotEmpty) {
      messages.last = messages.last.copyWith(text: text);
      messages.refresh();
      scrollToBottom();
    }
  }

  /// 傳送使用者訊息
  void sendUserMessage() {
    final content = searchoneController.text.trim();
    if (content.isEmpty) return;

    if (!socketService.canSendMessage) {
      print('❌ WebSocket 未準備好，無法發送訊息');
      return;
    }

    messages.add(ChatMessageModel(
      text: content,
      isUser: true,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    ));

    searchoneController.clear();
    scrollToBottom();
    socketService.ask(
      userId: gc.apiId.value,
      message: content,
      topicId: topicId, // 使用 UUID 格式的 topicId
    );
  }

  /// 傳送回饋
  void onFeedbackPressed(String msgId, int rating) {
    socketService.sendFeedback(id: msgId, rating: rating);

    final index = messages.indexWhere((m) => m.id == msgId && !m.isUser);
    if (index != -1) {
      messages[index] = messages[index].copyWith(feedbackRating: rating);
      messages.refresh();
    }
  }

  /// 傳送使用者訊息從回饋按鈕發送
  void sendUserMessageByFeedback(String text, int rating) {
    final latestBotMessage = messages.lastWhereOrNull((m) => !m.isUser);
    if (latestBotMessage != null) {
      onFeedbackPressed(latestBotMessage.id, rating);
    }
    final messageId = DateTime.now().millisecondsSinceEpoch.toString();

    messages.add(ChatMessageModel(
      text: text,
      isUser: true,
      id: messageId,
    ));
    scrollToBottom();

    socketService.ask(
      userId: gc.apiId.value,
      message: text,
      topicId: topicId,
    );
  }

  /// 滾動
  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  ///關閉
  void onClosePressed() {
    closeEvent();
    chatScreenController.hideK19();
  }

  void closeEvent() {
    socketService.disconnect();
    _isSocketInitialized = false;
    print('📝 對話已關閉，topic_id: $topicId');
  }

  ///路由到歷史訊息
  void goK20Screen() async {
    final result = await Get.toNamed(AppRoutes.k20Screen);

    // 🔥 監聽從 K20Screen 回傳的歷史對話資料
    if (result != null && result is Map<String, dynamic>) {
      final topicId = result['topicId'] as String?;
      final sessionId = result['sessionId'] as String?;
      final messages = result['messages'] as List<k20.ChatMessageModel>?;

      if (topicId != null && sessionId != null && messages != null) {
        print('📱 從 K20 接收到歷史對話，準備載入...');
        loadHistoryConversation(
          historyTopicId: topicId,
          sessionId: sessionId,
          historyMessages: messages,
        );
      }
    }
  }

  void handleIncomingChatFromK73(String text) {
    if (!_isSocketInitialized || !socketService.isConnected) {
      // 還沒連線，先暫存
      gc.chatInput.value = text;
      chatScreenController.showK19();
    } else {
      // 已連線，直接送出
      chatScreenController.showK19();
      _ifChatInputIsNotEmpty();
    }
  }
}
