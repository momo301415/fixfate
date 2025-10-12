import 'package:get/get.dart';

/// 食物营养信息模型
class FoodNutritionInfo {
  final String foodName;
  final double calories;
  final double protein;
  final double carbohydrates;
  final double fat;
  final double fiber;
  final String description;
  final String? imageUrl;

  FoodNutritionInfo({
    required this.foodName,
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fat,
    required this.fiber,
    required this.description,
    this.imageUrl,
  });

  factory FoodNutritionInfo.fromJson(Map<String, dynamic> json) {
    return FoodNutritionInfo(
      foodName: json['food_name'] ?? '',
      calories: (json['calories'] ?? 0).toDouble(),
      protein: (json['protein'] ?? 0).toDouble(),
      carbohydrates: (json['carbohydrates'] ?? 0).toDouble(),
      fat: (json['fat'] ?? 0).toDouble(),
      fiber: (json['fiber'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'food_name': foodName,
      'calories': calories,
      'protein': protein,
      'carbohydrates': carbohydrates,
      'fat': fat,
      'fiber': fiber,
      'description': description,
      'image_url': imageUrl,
    };
  }

  @override
  String toString() {
    return 'FoodNutritionInfo(foodName: $foodName, calories: $calories, protein: $protein, carbohydrates: $carbohydrates, fat: $fat, fiber: $fiber)';
  }
}

/// 食物分析结果模型
class FoodAnalysisResult {
  final List<FoodNutritionInfo> foods;
  final double totalCalories;
  final double totalProtein;
  final double totalCarbohydrates;
  final double totalFat;
  final double totalFiber;
  final String analysisNote;

  FoodAnalysisResult({
    required this.foods,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbohydrates,
    required this.totalFat,
    required this.totalFiber,
    required this.analysisNote,
  });

  factory FoodAnalysisResult.fromJson(Map<String, dynamic> json) {
    List<FoodNutritionInfo> foodList = [];
    if (json['foods'] != null) {
      foodList = (json['foods'] as List)
          .map((item) => FoodNutritionInfo.fromJson(item))
          .toList();
    }

    return FoodAnalysisResult(
      foods: foodList,
      totalCalories: (json['total_calories'] ?? 0).toDouble(),
      totalProtein: (json['total_protein'] ?? 0).toDouble(),
      totalCarbohydrates: (json['total_carbohydrates'] ?? 0).toDouble(),
      totalFat: (json['total_fat'] ?? 0).toDouble(),
      totalFiber: (json['total_fiber'] ?? 0).toDouble(),
      analysisNote: json['analysis_note'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foods': foods.map((food) => food.toJson()).toList(),
      'total_calories': totalCalories,
      'total_protein': totalProtein,
      'total_carbohydrates': totalCarbohydrates,
      'total_fat': totalFat,
      'total_fiber': totalFiber,
      'analysis_note': analysisNote,
    };
  }

  /// 计算总营养信息
  static FoodAnalysisResult calculateTotals(List<FoodNutritionInfo> foods, String note) {
    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbohydrates = 0;
    double totalFat = 0;
    double totalFiber = 0;

    for (var food in foods) {
      totalCalories += food.calories;
      totalProtein += food.protein;
      totalCarbohydrates += food.carbohydrates;
      totalFat += food.fat;
      totalFiber += food.fiber;
    }

    return FoodAnalysisResult(
      foods: foods,
      totalCalories: totalCalories,
      totalProtein: totalProtein,
      totalCarbohydrates: totalCarbohydrates,
      totalFat: totalFat,
      totalFiber: totalFiber,
      analysisNote: note,
    );
  }
}

/// 食物分析状态枚举
enum FoodAnalysisStatus {
  idle,
  analyzing,
  success,
  error,
}

/// 食物分析状态模型
class FoodAnalysisState {
  final FoodAnalysisStatus status;
  final FoodAnalysisResult? result;
  final String? errorMessage;

  FoodAnalysisState({
    required this.status,
    this.result,
    this.errorMessage,
  });

  FoodAnalysisState copyWith({
    FoodAnalysisStatus? status,
    FoodAnalysisResult? result,
    String? errorMessage,
  }) {
    return FoodAnalysisState(
      status: status ?? this.status,
      result: result ?? this.result,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}