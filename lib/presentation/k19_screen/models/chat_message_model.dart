class ChatMessageModel {
  final String id;
  final String text;
  final bool isUser;
  final int? feedbackRating;
  final bool isLoading;

  ChatMessageModel({
    required this.text,
    required this.isUser,
    required this.id,
    this.feedbackRating,
    this.isLoading = false,
  });

  ChatMessageModel copyWith({
    String? text,
    int? feedbackRating,
    bool? isLoading,
  }) {
    return ChatMessageModel(
      id: id,
      text: text ?? this.text,
      isUser: isUser,
      feedbackRating: feedbackRating ?? this.feedbackRating,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
