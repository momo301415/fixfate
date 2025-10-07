import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:pulsedevice/core/chat_screen_controller.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/service/firebase_analytics_service.dart';
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
  final gc = Get.find<GlobalController>();
  final WebSocketService socketService = WebSocketService(Api.socketUrl);
  final RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;
  TextEditingController searchoneController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final chatScreenController = Get.find<ChatScreenController>();
  final cc = Get.find<ChatScreenController>();
  late String topicId;
  String _currentAnswer = "";
  String? _currentMessageId;
  bool _isSocketInitialized = false;
  final RxBool isHistoryLoading = true.obs;
  final RxBool isAiReplying = false.obs;
  String? _loadingMessageId;
  Timer? _chunkTimeoutTimer;

  // 🔥 添加會話超時管理
  DateTime? lastInteractionTime;
  static const Duration sessionTimeout = Duration(minutes: 10);

  @override
  void onInit() {
    super.onInit();

    // 📊 記錄Chatbot頁面瀏覽事件
    FirebaseAnalyticsService.instance.logViewChatbotPage();

    _generateNewTopicId();
  }

  @override
  void onReady() {
    super.onReady();
    // 🔥 不再自動清空messages，保留歷史對話的可能性
  }

  @override
  void onClose() {
    _clearChunkTimeout();
    closeEvent();
    super.onClose();
  }

  void ensureWebSocketConnected() {
    // 🔥 檢查會話是否超時，需要重置
    _checkAndResetIfTimeout();

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
    try {
      socketService.connect();

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

        // 🔥 更新互動時間
        _updateInteractionTime();

        print('✅ AI回覆完成，恢復發送功能');
      };

      socketService.onSessionIdReceived = (id) {
        print('🎯 K19 收到 session_id: $id');
        // 根據新需求，不自動載入歷史對話
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

      socketService.onFeedbackResult = (success) {
        print('✅ 回饋結果: $success');
      };

      // 🔥 新增：429 錯誤處理
      socketService.onRateLimit = (message) {
        print('🚫 K19 收到 429 錯誤：$message');

        // 清除 loading 狀態
        if (_loadingMessageId != null) {
          messages.removeWhere((msg) => msg.id == _loadingMessageId);
          _loadingMessageId = null;
        }

        // 恢復發送功能
        isAiReplying.value = false;

        // 添加系統提示訊息
        messages.add(ChatMessageModel(
          text: "🚫 $message\n\n請稍後再試或聯繫客服。",
          isUser: false,
          id: "rate_limit_${DateTime.now().millisecondsSinceEpoch}",
        ));

        // 滾動到底部
        scrollToBottom();

        print('🚫 已顯示 429 錯誤提示，用戶無法發送新訊息');
      };

      // 🔥 新增：HTTP 4xx 客戶端錯誤處理
      socketService.onHttpClientError = (message, statusCode) {
        print('🚫 K19 收到 HTTP 客戶端錯誤 ($statusCode): $message');

        // 清除 loading 狀態
        if (_loadingMessageId != null) {
          messages.removeWhere((msg) => msg.id == _loadingMessageId);
          _loadingMessageId = null;
        }

        // 恢復發送功能
        isAiReplying.value = false;

        // 添加用戶友好的錯誤訊息
        final errorMessage = _formatClientErrorMessage(message, statusCode);
        messages.add(ChatMessageModel(
          text: errorMessage,
          isUser: false,
          id: "client_error_${DateTime.now().millisecondsSinceEpoch}",
        ));

        // 滾動到底部
        scrollToBottom();

        print('🚫 已顯示客戶端錯誤提示 ($statusCode)');
      };

      // 🔥 新增：HTTP 5xx 服務器錯誤處理
      socketService.onHttpServerError = (message, statusCode) {
        print('🚫 K19 收到 HTTP 服務器錯誤 ($statusCode): $message');

        // 清除 loading 狀態
        if (_loadingMessageId != null) {
          messages.removeWhere((msg) => msg.id == _loadingMessageId);
          _loadingMessageId = null;
        }

        // 恢復發送功能
        isAiReplying.value = false;

        // 添加用戶友好的錯誤訊息
        final errorMessage = _formatServerErrorMessage(message, statusCode);
        messages.add(ChatMessageModel(
          text: errorMessage,
          isUser: false,
          id: "server_error_${DateTime.now().millisecondsSinceEpoch}",
        ));

        // 滾動到底部
        scrollToBottom();

        print('🚫 已顯示服務器錯誤提示 ($statusCode)');
      };

      // 🔥 新增：網路連線錯誤處理
      socketService.onNetworkError = (message) {
        print('🌐 K19 收到網路連線錯誤: $message');

        // 清除 loading 狀態
        if (_loadingMessageId != null) {
          messages.removeWhere((msg) => msg.id == _loadingMessageId);
          _loadingMessageId = null;
        }

        // 恢復發送功能
        isAiReplying.value = false;

        // 添加用戶友好的錯誤訊息
        final errorMessage = _formatNetworkErrorMessage(message);
        messages.add(ChatMessageModel(
          text: errorMessage,
          isUser: false,
          id: "network_error_${DateTime.now().millisecondsSinceEpoch}",
        ));

        // 滾動到底部
        scrollToBottom();

        print('🌐 已顯示網路錯誤提示');
      };

      socketService.onError = (err) {
        print("❌ WebSocket 錯誤: $err");
        _isSocketInitialized = false; // 發生錯誤時退回，允許重連

        // 🔥 發生錯誤時清除 chunk 超時計時
        _clearChunkTimeout();

        // 讓 WebSocketService 自己處理重連
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
  Future<void> sendUserMessage() async {
    final content = searchoneController.text.trim();
    if (content.isEmpty) return;

    // 🔥 防呆：如果AI正在回覆，不允許發送新訊息
    if (isAiReplying.value) {
      print('⚠️ AI正在回覆中，請稍後再發送');
      return;
    }

    // 🔥 防呆：如果已達到使用上限，不允許發送新訊息
    if (socketService.isRateLimited) {
      print('🚫 已達到使用上限，無法發送訊息');
      return;
    }

    // 🔥 新增：檢查是否有HTTP錯誤狀態，不允許發送訊息
    if (_hasHttpError()) {
      print('🚫 檢測到HTTP錯誤，無法發送訊息');
      return;
    }

    // 🔥 檢查 WebSocket 是否準備就緒
    if (!socketService.canSendMessage) {
      print('⏳ WebSocket 正在準備中，等待連線完成...');

      // 等待連線完成
      final success = await _waitForWebSocketReady(context: '用戶發送訊息');
      if (!success) {
        print('❌ WebSocket 準備失敗，無法發送訊息');
        return;
      }
      // 連線完成後重新調用
      sendUserMessage();
      return;
    }

    // 🔥 用戶發送訊息時更新互動時間
    _updateInteractionTime();

    // 📊 記錄開始Chatbot會話事件
    FirebaseAnalyticsService.instance.logStartChatbotSession(
      sessionType: 'user_message',
    );

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
  Future<void> sendUserMessageByFeedback(String text, int rating) async {
    // 🔥 防呆：如果AI正在回覆，不允許發送新訊息
    if (isAiReplying.value) {
      print('⚠️ AI正在回覆中，請稍後再發送');
      return;
    }

    // 🔥 防呆：如果已達到使用上限，不允許發送新訊息
    if (socketService.isRateLimited) {
      print('🚫 已達到使用上限，無法發送訊息');
      return;
    }

    // 🔥 新增：檢查是否有HTTP錯誤狀態，不允許發送訊息
    if (_hasHttpError()) {
      print('🚫 檢測到HTTP錯誤，無法發送訊息');
      return;
    }

    // 🔥 檢查 WebSocket 是否準備就緒
    if (!socketService.canSendMessage) {
      print('⏳ WebSocket 正在準備中，等待連線完成...');

      // 等待連線完成
      final success = await _waitForWebSocketReady(context: '回饋發送訊息');
      if (!success) {
        print('❌ WebSocket 準備失敗，無法發送訊息');
        return;
      }
      // 連線完成後重新調用
      sendUserMessageByFeedback(text, rating);
      return;
    }

    // 🔥 用戶透過回饋發送訊息時更新互動時間
    _updateInteractionTime();

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

    // 🔥 關閉對話時保持 lastInteractionTime，用於下次檢查是否超時
    print('📝 對話已關閉，topic_id: $topicId，最後互動時間: $lastInteractionTime');
  }

  ///路由到歷史訊息
  void goK20Screen() async {
    final result = await Get.toNamed(AppRoutes.k20Screen);

    // 🔥 監聽從 K20Screen 回傳的歷史對話資料
    if (result != null && result is Map<String, dynamic>) {
      final topicId = result['topicId'] as String?;
      final messages = result['messages'] as List<k20.ChatMessageModel>?;

      if (topicId != null && messages != null) {
        print('📱 從 K20 接收到歷史對話，準備載入...');
        loadHistoryConversation(
          historyTopicId: topicId,
          historyMessages: messages,
        );
      }
    }
  }

  void handleIncomingChatFromK73(String text) {
    // 🔥 簡化：不再檢查WebSocket狀態，只處理內容
    // WebSocket連線會在K19Screen顯示後自動處理

    if (text.isNotEmpty) {
      gc.chatInput.value = text;
    }

    // 確保K19顯示（雙重保證）
    chatScreenController.showK19();
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

  /// 🔥 會話管理功能

  /// 載入歷史對話 - 改為公開方法，供外部調用
  void loadHistoryConversation({
    required String historyTopicId,
    required List<k20.ChatMessageModel> historyMessages,
  }) {
    topicId = historyTopicId;

    print('📜 載入歷史對話 - Topic: $topicId, 訊息數: ${historyMessages.length}');

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

    // 🔥 關鍵修改：強制清空sessionId，讓WebSocket重新取得新的
    socketService.sessionId = null;
    print('🆕 強制使用新的session_id配合歷史topic_id: $topicId');

    // 🔥 確保 WebSocket 連線並等待準備完成
    _ensureWebSocketReadyForHistory();

    // 滾動到底部
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });

    // 🔥 注意：載入歷史對話不算真正互動，lastInteractionTime 將在用戶實際發送訊息時才更新
  }

  /// 🔥 確保 WebSocket 為歷史對話準備就緒
  Future<void> _ensureWebSocketReadyForHistory() async {
    print('🚀 開始準備 WebSocket 連線...');

    // 1. 初始化 WebSocket 連線
    ensureWebSocketConnected();

    // 2. 等待 WebSocket 完全準備就緒
    final success = await _waitForWebSocketReady(
      waitForConnection: true,
      maxAttempts: 40, // 最多等待 20 秒
      context: '歷史對話載入',
    );

    if (success) {
      print('✅ WebSocket 完全準備就緒，可以開始對話');
    } else {
      print('❌ WebSocket 準備超時，但歷史對話已載入');
    }
  }

  /// 生成新的對話 ID
  void _generateNewTopicId() {
    topicId = _generateNewUUID();
    print('🆕 創建新對話會話，Topic ID: $topicId');
  }

  String _generateNewUUID() {
    const uuid = Uuid();
    return uuid.v4();
  }

  /// 檢查會話是否超時並重置
  void _checkAndResetIfTimeout() {
    if (lastInteractionTime != null) {
      final now = DateTime.now();
      final timeSinceLastInteraction = now.difference(lastInteractionTime!);

      if (timeSinceLastInteraction > sessionTimeout) {
        print('⏰ 會話超時 ${timeSinceLastInteraction.inMinutes} 分鐘，開始新會話');
        _startNewSession();
      } else {
        final remainingMinutes =
            sessionTimeout.inMinutes - timeSinceLastInteraction.inMinutes;
        print('✅ 會話仍有效，剩餘 $remainingMinutes 分鐘');
      }
    } else {
      print('🆕 首次進入聊天，準備開始新會話');
    }
  }

  /// 開始新會話
  void _startNewSession() {
    // 1. 清空對話
    messages.clear();

    // 2. 生成新的 topic_id
    _generateNewTopicId();

    // 3. 重置 WebSocket 狀態（確保獲取新 session_id）
    socketService.sessionId = null;
    _isSocketInitialized = false;
    socketService.disconnect();

    // 4. 重置時間
    lastInteractionTime = null;

    print('🆕 新會話已開始，Topic ID: $topicId');
  }

  /// 更新互動時間
  void _updateInteractionTime() {
    lastInteractionTime = DateTime.now();
    print('🕐 互動時間已更新: ${lastInteractionTime!.toLocal()}');
  }

  /// 🔥 統一的 WebSocket 等待方法
  ///
  /// [waitForConnection] 是否等待連線完成（用於歷史對話載入）
  /// [maxAttempts] 最大等待次數
  /// [context] 等待上下文，用於日誌輸出
  /// 返回是否成功準備就緒
  Future<bool> _waitForWebSocketReady({
    bool waitForConnection = false,
    int maxAttempts = 60,
    String context = '發送訊息',
  }) async {
    int attempts = 0;
    final delayMs = 500;

    print('🔍 [$context] 開始等待 WebSocket 準備...');
    print(
        '🔍 [$context] 當前狀態 - isConnected: ${socketService.isConnected}, sessionId: ${socketService.sessionId}');

    // 如果需要等待連線，先等待連線完成
    if (waitForConnection) {
      while (!socketService.isConnected && attempts < maxAttempts) {
        await Future.delayed(Duration(milliseconds: delayMs));
        attempts++;
        if (attempts % 10 == 0) {
          print('⏳ [$context] 等待 WebSocket 連線中... (${attempts}/$maxAttempts)');
        }
      }

      if (!socketService.isConnected) {
        print('❌ [$context] WebSocket 連線超時');
        return false;
      }

      print('✅ [$context] WebSocket 連線成功，等待 session 準備...');
      attempts = 0; // 重置計數器，用於等待 session
    }

    // 等待 session 準備完成
    while (!socketService.canSendMessage && attempts < maxAttempts) {
      await Future.delayed(Duration(milliseconds: delayMs));
      attempts++;

      // 每 10 次檢查打印一次詳細狀態
      if (attempts % 10 == 0) {
        print('⏳ [$context] 等待 WebSocket 準備中... (${attempts}/$maxAttempts)');
        print(
            '🔍 [$context] 狀態檢查 - isConnected: ${socketService.isConnected}, sessionId: ${socketService.sessionId}');
      }

      // 🔥 如果 WebSocket 已連接但 sessionId 為空，嘗試重新請求
      if (socketService.isConnected &&
          (socketService.sessionId == null ||
              socketService.sessionId!.isEmpty)) {
        print('🔄 [$context] WebSocket 已連接但 sessionId 為空，嘗試重新請求...');
        socketService.forceNewSession();
      }
    }

    final success = socketService.canSendMessage;

    if (!success) {
      print('❌ [$context] WebSocket 準備超時');
      print(
          '🔍 [$context] 最終狀態 - isConnected: ${socketService.isConnected}, sessionId: ${socketService.sessionId}');
    } else {
      print('✅ [$context] WebSocket 已準備就緒，可以發送訊息');
      print(
          '🔍 [$context] 最終狀態 - isConnected: ${socketService.isConnected}, sessionId: ${socketService.sessionId}');
    }

    return success;
  }

  /// 🔥 新增：獲取連接狀態（供狀態欄使用）
  bool get isWebSocketConnected => socketService.isConnected;

  /// 🔥 新增：獲取是否可以發送訊息（供狀態欄使用）
  bool get canSendMessage => socketService.canSendMessage;

  /// 🔥 新增：手動重連方法（供狀態欄使用）
  void retryConnection() {
    print('🔄 手動重連...');

    // 🔥 重置 429 錯誤狀態，允許重新嘗試
    socketService.resetRateLimit();

    socketService.manualReconnect();
  }

  /// 🔥 新增：獲取連接狀態描述（供狀態欄使用）
  String get connectionStatusDescription {
    // 🔥 優先檢查 429 錯誤狀態
    if (socketService.isRateLimited) {
      return '已達使用上限';
    }

    if (!socketService.isConnected) {
      return '離線';
    }

    if (!socketService.canSendMessage) {
      if (isAiReplying.value) {
        return '連線不穩定';
      } else {
        return '正在連線';
      }
    }

    return '已連線';
  }

  /// 🔥 新增：格式化客戶端錯誤訊息
  String _formatClientErrorMessage(String message, int statusCode) {
    String icon = "⚠️";
    String suggestion = "";

    switch (statusCode) {
      case 400:
        icon = "📝";
        suggestion = "\n\n💡 建議：檢查輸入內容是否正確";
        break;
      case 401:
        icon = "🔐";
        suggestion = "\n\n💡 建議：請重新登入或檢查認證資訊";
        break;
      case 403:
        icon = "🚫";
        suggestion = "\n\n💡 建議：檢查帳號權限或聯繫客服";
        break;
      case 404:
        icon = "🔍";
        suggestion = "\n\n💡 建議：檢查請求的資源是否存在";
        break;
      default:
        icon = "⚠️";
        suggestion = "\n\n💡 建議：請稍後再試或聯繫客服";
    }

    return "$icon **$message**\n\n📊 錯誤代碼：$statusCode$suggestion";
  }

  /// 🔥 新增：格式化服務器錯誤訊息
  String _formatServerErrorMessage(String message, int statusCode) {
    String icon = "🖥️";
    String suggestion = "";

    switch (statusCode) {
      case 500:
        icon = "💥";
        suggestion = "\n\n💡 建議：請稍後再試，這是服務器內部問題";
        break;
      case 502:
        icon = "🌐";
        suggestion = "\n\n💡 建議：服務暫時不可用，請稍後再試";
        break;
      case 503:
        icon = "🔧";
        suggestion = "\n\n💡 建議：服務正在維護中，請稍後再試";
        break;
      case 504:
        icon = "⏰";
        suggestion = "\n\n💡 建議：服務回應超時，請稍後再試";
        break;
      default:
        icon = "🖥️";
        suggestion = "\n\n💡 建議：請稍後再試或聯繫客服";
    }

    return "$icon **$message**\n\n📊 錯誤代碼：$statusCode$suggestion";
  }

  /// 🔥 新增：格式化網路連線錯誤訊息
  String _formatNetworkErrorMessage(String message) {
    return "🌐 **$message**\n\n💡 建議：\n"
        "• 檢查網路連線是否正常\n"
        "• 檢查防火牆設定\n"
        "• 稍後再試或聯繫網路管理員";
  }

  /// 🔥 新增：檢查是否有HTTP錯誤狀態
  bool _hasHttpError() {
    // 檢查最近的訊息中是否有錯誤訊息
    if (messages.isNotEmpty) {
      final lastMessage = messages.last;
      final messageId = lastMessage.id;

      // 檢查是否是錯誤訊息ID
      if (messageId.contains('client_error') ||
          messageId.contains('server_error') ||
          messageId.contains('network_error') ||
          messageId.contains('rate_limit')) {
        return true;
      }
    }
    return false;
  }
}
