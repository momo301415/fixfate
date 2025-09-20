class WeightAnalysisModel {
  final double weight; // 体重
  final double bmi; // BMI值
  final double bodyFat; // 体脂肪重
  final double bodyWater; // 身体总水重
  final double protein; // 蛋白质量
  final double mineral; // 矿物质量
  final String updateTime; // 更新时间
  final String weightUnit; // 体重单位，如"公斤"
  final String bmiUnit; // BMI单位，如"kg/m²"

  const WeightAnalysisModel({
    required this.weight,
    required this.bmi,
    required this.bodyFat,
    required this.bodyWater,
    required this.protein,
    required this.mineral,
    required this.updateTime,
    this.weightUnit = '公斤',
    this.bmiUnit = 'kg/m²',
  });

  // 获取总重量（用于计算百分比）
  double get totalWeight => bodyFat + bodyWater + protein + mineral;

  // 获取体脂肪重百分比
  double get bodyFatPercentage => totalWeight > 0 ? bodyFat / totalWeight : 0;

  // 获取身体总水重百分比
  double get bodyWaterPercentage => totalWeight > 0 ? bodyWater / totalWeight : 0;

  // 获取蛋白质量百分比
  double get proteinPercentage => totalWeight > 0 ? protein / totalWeight : 0;

  // 获取矿物质量百分比
  double get mineralPercentage => totalWeight > 0 ? mineral / totalWeight : 0;

  // 复制并修改数据
  WeightAnalysisModel copyWith({
    double? weight,
    double? bmi,
    double? bodyFat,
    double? bodyWater,
    double? protein,
    double? mineral,
    String? updateTime,
    String? weightUnit,
    String? bmiUnit,
  }) {
    return WeightAnalysisModel(
      weight: weight ?? this.weight,
      bmi: bmi ?? this.bmi,
      bodyFat: bodyFat ?? this.bodyFat,
      bodyWater: bodyWater ?? this.bodyWater,
      protein: protein ?? this.protein,
      mineral: mineral ?? this.mineral,
      updateTime: updateTime ?? this.updateTime,
      weightUnit: weightUnit ?? this.weightUnit,
      bmiUnit: bmiUnit ?? this.bmiUnit,
    );
  }
}