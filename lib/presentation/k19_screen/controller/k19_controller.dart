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
        socketService.sendHistory(userId: gc.apiId.value);
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
    // scrollController.dispose();
    _isSocketInitialized = false;
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
}
