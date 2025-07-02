import 'package:get/get.dart';

class ChatMessageModel {
  final RxString? userId;
  final RxString? sessionId;
  final RxString? timestamp;
  final RxString? ragType;
  final RxString? ttl;
  final RxString? message;
  final RxString? botResponse;

  ChatMessageModel({
    this.userId,
    this.sessionId,
    this.timestamp,
    this.ragType,
    this.ttl,
    this.message,
    this.botResponse,
  });
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      userId: RxString(json['user_id'] ?? ''),
      sessionId: RxString(json['session_id'] ?? ''),
      timestamp: RxString(json['timestamp'] ?? ''),
      ragType: RxString(json['rag_type'] ?? ''),
      ttl: RxString(json['ttl'] ?? ''),
      message: RxString(json['message'] ?? ''),
      botResponse: RxString(json['bot_response'] ?? ''),
    );
  }
}
