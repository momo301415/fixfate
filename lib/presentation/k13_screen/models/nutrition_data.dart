/// 營養數據模型
class NutritionData {
  final double current; // 當前值
  final double target; // 目標值
  final String unit; // 單位

  NutritionData({
    required this.current,
    required this.target,
    required this.unit,
  });

  // 獲取進度百分比
  double get progress {
    return target > 0 ? (current / target).clamp(0.0, 1.0) : 0.0;
  }

  // 獲取格式化的顯示文本
  String get displayText {
    return '${current.toInt()}/${target.toInt()}';
  }

  // 複製並更新數據
  NutritionData copyWith({
    double? current,
    double? target,
    String? unit,
  }) {
    return NutritionData(
      current: current ?? this.current,
      target: target ?? this.target,
      unit: unit ?? this.unit,
    );
  }
}