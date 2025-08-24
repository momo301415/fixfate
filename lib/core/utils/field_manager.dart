import 'package:get/get.dart';
import 'dialog_result.dart';

/// 欄位管理器，用於處理使用者輸入欄位的狀態和預設值邏輯
class FieldManager<T> {
  final Rx<T> _value;
  final T _defaultValue;
  final bool Function(T value)? _isEmpty;

  FieldManager({
    required T initialValue,
    required T defaultValue,
    bool Function(T value)? isEmpty,
  })  : _value = initialValue.obs,
        _defaultValue = defaultValue,
        _isEmpty = isEmpty ?? _defaultIsEmpty;

  /// 獲取當前值
  T get value => _value.value;

  /// 獲取響應式值
  Rx<T> get obs => _value;

  /// 設定值
  set value(T newValue) => _value.value = newValue;

  /// 檢查是否為空值（可自訂邏輯）
  bool get isEmpty =>
      _isEmpty?.call(_value.value) ?? _defaultIsEmpty(_value.value);

  /// 檢查是否已經有值（非空且非預設值）
  bool get hasValue => !isEmpty;

  /// 處理對話框結果
  void handleDialogResult(DialogResult<T> result) {
    if (result.isConfirmed && result.value != null) {
      // 使用者確認並提供了值
      _value.value = result.value!;
    } else if (isEmpty) {
      // 只有在欄位為空時才設定預設值
      _value.value = _defaultValue;
    }
    // 如果是取消操作且欄位已有值，則不做任何事
  }

  /// 預設的空值檢查邏輯
  static bool _defaultIsEmpty<T>(T value) {
    if (value is String) return value.isEmpty;
    if (value is num) return value == 0;
    if (value is List) return value.isEmpty;
    return value == null;
  }

  @override
  String toString() {
    return 'FieldManager{value: ${_value.value}, isEmpty: $isEmpty, hasValue: $hasValue}';
  }
}

/// 字串欄位管理器的便利建構子
class StringFieldManager extends FieldManager<String> {
  StringFieldManager({
    String initialValue = '',
    String defaultValue = '',
  }) : super(
          initialValue: initialValue,
          defaultValue: defaultValue,
          isEmpty: (value) => value.trim().isEmpty,
        );
}

/// 數字欄位管理器的便利建構子
class NumberFieldManager extends FieldManager<double> {
  NumberFieldManager({
    double initialValue = 0.0,
    required double defaultValue,
  }) : super(
          initialValue: initialValue,
          defaultValue: defaultValue,
          isEmpty: (value) => value <= 0,
        );
}



