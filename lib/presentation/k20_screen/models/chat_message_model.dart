import 'package:get/get.dart';

class ChatMessageModel {
  final RxString? userId;
  final RxString? sessionId;
  final RxString? timestamp;
  final RxString? ragType;
  final RxString? topicId;
  final RxString? ttl;
  final RxString? message;
  final RxString? botResponse;
  final RxString? id;

  ChatMessageModel({
    this.userId,
    this.sessionId,
    this.timestamp,
    this.ragType,
    this.topicId,
    this.ttl,
    this.message,
    this.botResponse,
    this.id,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      userId: RxString(json['user_id'] ?? ''),
      sessionId: RxString(json['session_id'] ?? ''),
      timestamp: RxString(json['timestamp'] ?? ''),
      ragType: RxString(json['rag_type'] ?? ''),
      topicId: RxString(json['topic_id'] ?? ''),
      ttl: RxString(json['ttl'] ?? ''),
      message: RxString(json['message'] ?? ''),
      botResponse: RxString(json['bot_response'] ?? ''),
      id: RxString(json['id'] ?? ''),
    );
  }

  Map<String, dynamic> toK19Message() {
    return {
      'user_id': userId?.value ?? '',
      'session_id': sessionId?.value ?? '',
      'timestamp': timestamp?.value ?? '',
      'rag_type': ragType?.value ?? '',
      'topic_id': topicId?.value ?? '',
      'message': message?.value ?? '',
      'bot_response': botResponse?.value ?? '',
      'id': id?.value ?? '',
    };
  }
}

class ChatTopicGroup {
  final String topicId;
  final String sessionId;
  final List<ChatMessageModel> messages;
  final DateTime lastMessageTime;
  final int messageCount;

  ChatTopicGroup({
    required this.topicId,
    required this.sessionId,
    required this.messages,
    required this.lastMessageTime,
    required this.messageCount,
  });

  String get groupTitle {
    final sortedMessages = messages.toList()
      ..sort((a, b) {
        final aTime = DateTime.tryParse(a.timestamp?.value ?? '');
        final bTime = DateTime.tryParse(b.timestamp?.value ?? '');
        if (aTime == null || bTime == null) return 0;
        return aTime.compareTo(bTime);
      });

    final firstUserMessage = sortedMessages
        .where((msg) => msg.message?.value?.isNotEmpty == true)
        .firstOrNull;

    if (firstUserMessage?.message?.value?.isNotEmpty == true) {
      String title = firstUserMessage!.message!.value!;
      return title.length > 30 ? '${title.substring(0, 30)}...' : title;
    }

    return '未知對話';
  }

  String get lastMessagePreview {
    final lastMsg = messages.lastOrNull;
    if (lastMsg?.botResponse?.value?.isNotEmpty == true) {
      String preview = lastMsg!.botResponse!.value!;
      return preview.length > 50 ? '${preview.substring(0, 50)}...' : preview;
    }
    return '沒有訊息';
  }

  String get timeDisplay {
    final now = DateTime.now();
    final diff = now.difference(lastMessageTime);

    if (diff.inDays == 0) {
      return '今天';
    } else if (diff.inDays == 1) {
      return '昨天';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}天前';
    } else {
      return '${lastMessageTime.month}/${lastMessageTime.day}';
    }
  }

  bool get isUuidTopic {
    final uuidPattern = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
      caseSensitive: false,
    );
    return uuidPattern.hasMatch(topicId);
  }

  String get groupKey => '${topicId}_${sessionId}';
}

class ChatGroupedSection {
  final int dayOffset;
  final List<ChatTopicGroup> messages; // 改為存放 ChatTopicGroup

  ChatGroupedSection({
    required this.dayOffset,
    required this.messages,
  });
}
