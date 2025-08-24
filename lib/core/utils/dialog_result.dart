/// Dialog 操作結果封裝類別
/// 用於明確區分使用者的操作意圖：確認、取消、關閉
class DialogResult<T> {
  final T? value;
  final DialogAction action;

  const DialogResult._(this.value, this.action);

  /// 使用者確認並提供了值
  factory DialogResult.confirmed(T value) {
    return DialogResult._(value, DialogAction.confirmed);
  }

  /// 使用者明確取消操作
  factory DialogResult.cancelled() {
    return DialogResult._(null, DialogAction.cancelled);
  }

  /// 對話框被關閉（例如點擊外部區域或返回鍵）
  factory DialogResult.dismissed() {
    return DialogResult._(null, DialogAction.dismissed);
  }

  /// 是否為確認操作
  bool get isConfirmed => action == DialogAction.confirmed;

  /// 是否為取消操作
  bool get isCancelled => action == DialogAction.cancelled;

  /// 是否為關閉操作
  bool get isDismissed => action == DialogAction.dismissed;

  /// 是否有有效值
  bool get hasValue => value != null && isConfirmed;

  /// 獲取值，如果沒有有效值則返回預設值
  T getValueOrDefault(T defaultValue) {
    return hasValue ? value! : defaultValue;
  }

  /// 獲取值，如果沒有有效值則返回 null
  T? get valueOrNull => hasValue ? value : null;

  @override
  String toString() {
    return 'DialogResult{value: $value, action: $action}';
  }
}

/// Dialog 操作類型
enum DialogAction {
  /// 使用者確認操作
  confirmed,

  /// 使用者取消操作
  cancelled,

  /// 對話框被關閉
  dismissed,
}



