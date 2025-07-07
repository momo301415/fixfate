import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pulsedevice/core/chat_screen_controller.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/service/web_socket_service.dart';
import 'package:pulsedevice/presentation/k19_screen/models/chat_message_model.dart';
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
  String topicId = "健康主題";
  String _currentAnswer = "";
  String? _currentMessageId;
  bool _isSocketInitialized = false;
  final RxBool isHistoryLoading = true.obs;
  final RxBool isAiReplying = false.obs;
  String? _loadingMessageId;
  Timer? _chunkTimeoutTimer;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _clearChunkTimeout();
    closeEvent();
    super.onClose();
  }

  void ensureWebSocketConnected() {
    if (_isSocketInitialized) return;

    _isSocketInitialized = true;
    initSocketIfNeeded();
  }

  void initSocketIfNeeded() {
    try {
      socketService.connect();

      _isSocketInitialized = true;

      socketService.onStart = (id) {
        _currentMessageId = id;
        _currentAnswer = "";

        // 🔥 移除loading訊息
        if (_loadingMessageId != null) {
          messages.removeWhere((msg) => msg.id == _loadingMessageId);
          _loadingMessageId = null;
        }

        // 🔥 添加真正的AI回覆訊息
        messages.add(ChatMessageModel(
          text: "",
          isUser: false,
          id: id,
          isLoading: false, // 🔥 明確標記為非loading狀態
        ));

        // 🔥 開始 chunk 超時計時
        _startChunkTimeout();
      };

      socketService.onChunk = (chunk) {
        _currentAnswer += chunk;
        _updateLastMessageText(_currentAnswer);

        // 🔥 重置 chunk 超時計時
        _resetChunkTimeout();
      };

      socketService.onEnd = (id) {
        _currentMessageId = null;

        // 🔥 恢復發送功能
        isAiReplying.value = false;
        _loadingMessageId = null;

        // 🔥 清除 chunk 超時計時
        _clearChunkTimeout();

        print('✅ AI回覆完成，恢復發送功能');
      };

      socketService.onSessionIdReceived = (id) {
        // 若有暫存訊息，送出
        _ifChatInputIsNotEmpty();
      };

      socketService.onHistoryResult = (historyList) {
        final historyMessages = <ChatMessageModel>[];

        for (final item in historyList) {
          final userMsg = ChatMessageModel(
            text: item['message'],
            isUser: true,
            id: item['id'],
          );
          final botMsg = ChatMessageModel(
            text: item['bot_response'],
            isUser: false,
            id: item['id'],
          );

          historyMessages.add(userMsg);
          historyMessages.add(botMsg);
        }

        messages.assignAll(historyMessages); // 直接取代 messages
        isHistoryLoading.value = false;
      };

      socketService.onError = (err) {
        print("WebSocket error: $err");
        _isSocketInitialized = false; // 發生錯誤時退回，允許重連

        // 🔥 發生錯誤時清除 chunk 超時計時
        _clearChunkTimeout();
      };
    } catch (e) {
      print("❌ WebSocket 連線失敗: $e");
      _isSocketInitialized = false;
    }
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

    // 🔥 防呆：如果AI正在回覆，不允許發送新訊息
    if (isAiReplying.value) {
      print('⚠️ AI正在回覆中，請稍後再發送');
      return;
    }

    // 1. 立即設置AI回覆狀態，阻擋連續發送
    isAiReplying.value = true;

    // 2. 添加用戶訊息
    messages.add(ChatMessageModel(
      text: content,
      isUser: true,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    ));

    // 3. 立即添加loading訊息
    _loadingMessageId = "loading_${DateTime.now().millisecondsSinceEpoch}";
    messages.add(ChatMessageModel(
      text: "",
      isUser: false,
      id: _loadingMessageId!,
      isLoading: true, // 🔥 標記為loading狀態
    ));

    // 4. 清空輸入框並滾動到底部
    searchoneController.clear();
    scrollToBottom();

    // 5. 發送WebSocket訊息
    socketService.ask(
      userId: gc.apiId.value,
      message: content,
      topicId: topicId,
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
    // 🔥 防呆：如果AI正在回覆，不允許發送新訊息
    if (isAiReplying.value) {
      print('⚠️ AI正在回覆中，請稍後再發送');
      return;
    }

    // 1. 立即設置AI回覆狀態，阻擋連續發送
    isAiReplying.value = true;

    // 2. 處理回饋評分
    final latestBotMessage = messages.lastWhereOrNull((m) => !m.isUser);
    if (latestBotMessage != null) {
      onFeedbackPressed(latestBotMessage.id, rating);
    }

    // 3. 添加用戶訊息
    final messageId = DateTime.now().millisecondsSinceEpoch.toString();
    messages.add(ChatMessageModel(
      text: text,
      isUser: true,
      id: messageId,
    ));

    // 4. 立即添加loading訊息
    _loadingMessageId = "loading_${DateTime.now().millisecondsSinceEpoch}";
    messages.add(ChatMessageModel(
      text: "",
      isUser: false,
      id: _loadingMessageId!,
      isLoading: true, // 🔥 標記為loading狀態
    ));

    // 5. 滾動到底部
    scrollToBottom();

    // 6. 發送WebSocket訊息
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
    // scrollController.dispose();
    _isSocketInitialized = false;

    // 🔥 清除 chunk 超時計時
    _clearChunkTimeout();
  }

  ///路由到歷史訊息
  void goK20Screen() {
    Get.toNamed(AppRoutes.k20Screen);
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

  /// 🔥 Chunk 超時保護機制

  /// 開始 chunk 超時計時（10秒）
  void _startChunkTimeout() {
    _chunkTimeoutTimer = Timer(Duration(seconds: 10), () {
      print('⚠️ Chunk 流中斷超過 10 秒，觸發保護機制');
      _handleChunkTimeout();
    });
  }

  /// 重置 chunk 超時計時
  void _resetChunkTimeout() {
    _chunkTimeoutTimer?.cancel();
    _startChunkTimeout();
  }

  /// 清除 chunk 超時計時
  void _clearChunkTimeout() {
    _chunkTimeoutTimer?.cancel();
    _chunkTimeoutTimer = null;
  }

  /// 處理 chunk 超時
  void _handleChunkTimeout() {
    print('⚠️ 偵測到 chunk 流中斷，強制結束對話');

    // 在當前回覆後面加上中斷提示
    if (_currentAnswer.isNotEmpty) {
      _currentAnswer += "\n\n⚠️ 回覆中斷，請重新提問";
      _updateLastMessageText(_currentAnswer);
    }

    // 模擬 onEnd 行為，恢復用戶互動
    _currentMessageId = null;
    isAiReplying.value = false;
    _loadingMessageId = null;

    // 清理計時器
    _clearChunkTimeout();

    print('✅ 已恢復用戶互動功能');
  }
}
