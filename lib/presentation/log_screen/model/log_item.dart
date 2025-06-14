class LogItem {
  final int id;
  final String userId;
  final String logType;
  final String rawLogData;
  final DateTime createdAt;

  LogItem({
    required this.id,
    required this.userId,
    required this.logType,
    required this.rawLogData,
    required this.createdAt,
  });

  factory LogItem.fromJson(Map<String, dynamic> json) {
    return LogItem(
      id: json['id'],
      userId: json['userId'],
      logType: json['logType'],
      rawLogData: json['logData'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
