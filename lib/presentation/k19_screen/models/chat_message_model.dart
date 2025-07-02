class ChatMessageModel {
  final String id;
  final String text;
  final bool isUser;
  final int? feedbackRating;

  ChatMessageModel({
    required this.text,
    required this.isUser,
    required this.id,
    this.feedbackRating,
  });

  ChatMessageModel copyWith({
    String? text,
    int? feedbackRating,
  }) {
    return ChatMessageModel(
      id: id,
      text: text ?? this.text,
      isUser: isUser,
      feedbackRating: feedbackRating ?? this.feedbackRating,
    );
  }
}
