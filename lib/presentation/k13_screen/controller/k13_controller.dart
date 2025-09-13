// 更新k13_controller.dart
import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/k13_screen/widgets/nutrition_card_widget.dart';
import 'package:pulsedevice/presentation/k13_screen/widgets/selection_popup_model.dart';
import '../../../core/app_export.dart';
import '../../../core/utils/dialog_utils.dart';

import '../../k3_bottomsheet/controller/k3_controller.dart';
import '../../k3_bottomsheet/k3_bottomsheet.dart';
import '../../six_dialog/controller/six_controller.dart';
import '../../six_dialog/six_dialog.dart';
import '../models/k13_model.dart';
import '../models/nutrition_data.dart';

class K13Controller extends GetxController {
  Rx<K13Model> k13ModelObj = K13Model().obs;
  var kcalNumber = 1381.obs; // 目標攝取量
  var currentKcal = 346.obs; // 已攝取量
  var selectedDate = DateTime.now().obs; // 選中的日期
  
  // 營養素數據
  var carbohydrates = NutritionData(current: 189, target: 370, unit: 'g').obs;
  var protein = NutritionData(current: 64, target: 75, unit: 'g').obs;
  var fat = NutritionData(current: 19, target: 50, unit: 'g').obs;
  var fiber = NutritionData(current: 10, target: 35, unit: 'g').obs;

  SelectionPopupModel? selectedDropDownValue;

// 获取营养卡片数据列表
  List<NutritionCardData> get nutritionCards => [
    NutritionCardData(
      type: NutritionCardType.breakfast,
      foodName: "豬肉漢堡",
      data: [
        FoodTypeData(foodType: "碳水化合物", foodKG: 0.1, state: true),
        FoodTypeData(foodType: "蛋白質", foodKG: 0.1, state: true),
        FoodTypeData(foodType: "飽和脂肪", foodKG: 0.1, state: true),
        FoodTypeData(foodType: "膳食纖維", foodKG: 0.1, state: true),
      ],
      time: null,
      day: null,
      imagePath: '', // 假设的图标路径
      kcal: 100,
      number: 1,
      piece: '个',
    ),
    NutritionCardData(
      type: NutritionCardType.breakfast,
      foodName: "奶茶",
      data: [
        FoodTypeData(foodType: "醣類", foodKG: 8.3 , state: true),
        FoodTypeData(foodType: "飽和脂肪", foodKG: 31.0, state: true),
      ],
      time: null,
      day: null,
      imagePath: '', // 假设的图标路径
      kcal: 1000,
      number: 500,
      piece: 'ml',
    ),
    NutritionCardData(
      type: NutritionCardType.tea,
      foodName: "牛肉麵",
      time: null,
      day: null,
      data: [
        FoodTypeData(foodType: "碳水化合物", foodKG: 0.1, state: true),
        FoodTypeData(foodType: "蛋白質", foodKG: 0.1, state: true),
        FoodTypeData(foodType: "飽和脂肪", foodKG: 0.1, state: true),
        FoodTypeData(foodType: "膳食纖維", foodKG: 0.1, state: true),
      ],
      imagePath: '', // 假设的图标路径
      kcal: 1500,
      number: 1,
      piece: '碗',
    ),
    NutritionCardData(
      type: NutritionCardType.waterIntake,
      foodName: "水",
      imagePath: '', // 假设的图标路径
      kcal: 0,
      number: 500,
      piece: ' ml',
    ),
    NutritionCardData(
      type: NutritionCardType.lunch,
      foodName: "乖乖",
      time: null,
      day: null,
      imagePath: '', // 假设的图标路径
      data: [
        FoodTypeData(foodType: "碳水化合物", foodKG: 0.1, state: true),
        FoodTypeData(foodType: "蛋白質", foodKG: 0.1, state: true),
        FoodTypeData(foodType: "飽和脂肪", foodKG: 0.1, state: true),
        FoodTypeData(foodType: "膳食纖維", foodKG: 0.1, state: true),
      ],
      kcal: 1500,
      number: 500,
      piece: '克',
    ),
    NutritionCardData(
      type: NutritionCardType.snack,
      foodName: "点心",
      time: null,
      day: null,
      data: [
        FoodTypeData(foodType: "碳水化合物", foodKG: 0.1, state: true),
        FoodTypeData(foodType: "蛋白質", foodKG: 0.1, state: true),
        FoodTypeData(foodType: "飽和脂肪", foodKG: 0.1, state: true),
        FoodTypeData(foodType: "膳食纖維", foodKG: 0.1, state: true),
      ],
      kcal: 1500,
      number: 1,
      imagePath: ImageConstant.imgFiRrUtensils,
      piece: '',
    ),
  ];


// 计算碳水化合物（示例：假设卡路里的50%来自碳水）
  double _calculateCarbs(int calories) {
    return (calories * 0.5) / 4; // 1g碳水 = 4卡路里
  }

// 计算脂肪（示例：假设卡路里的30%来自脂肪）
  double _calculateFat(int calories) {
    return (calories * 0.3) / 9; // 1g脂肪 = 9卡路里
  }

// 计算纤维（示例：基于卡路里的简单估算）
  double _calculateFiber(int calories) {
    return calories * 0.01; // 每100卡路里约1g纤维
  }

  Future<void> showInputKcal() async {
    final result = await DialogHelper.showCustomDialog(
        Get.context!, SixDialog(Get.put(SixController())));
    if (result != null && result.isNotEmpty) {
      kcalNumber.value = int.parse(result);
      // 根据当前操作更新对应的数据
      updateNutritionData(kcalNumber.value);
    }
  }
  
  // 更新選中日期
  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    // 這裡可以根據日期加載對應的營養數據
    loadNutritionDataForDate(date);
  }
  
  // 根據日期加載營養數據
  void loadNutritionDataForDate(DateTime date) {
    // 這裡應該從數據庫或API加載對應日期的數據
    // 暫時使用模擬數據
  }
  
  // 獲取圓環進度
  double get circularProgress {
    return kcalNumber.value > 0 ? (currentKcal.value / kcalNumber.value).clamp(0.0, 1.0) : 0.0;
  }

  Future<void> showSelectAllFood() async {
    final result = await DialogHelper.showCustomBottomSheet(
        Get.context!, K3Bottomsheet(Get.put(K3Controller())));
    if (result != null && result.isNotEmpty) {
      kcalNumber.value = int.parse(result);
      // 根据当前操作更新对应的数据
      updateNutritionData(kcalNumber.value);
    }
  }

  // 更新营养数据的方法
  void updateNutritionData(int calories) {
    // 这里需要根据当前操作的类型来更新对应的数据
    // 可以通过记录最后一次操作的类型来实现
    // 或者通过回调参数传递类型信息
  }

  // 在K13Controller中添加
  void updateNutritionCard(int index, NutritionCardData newData) {
    // 根据索引找到对应的餐食类型并更新具体数据
    nutritionCards[index] = newData;
    update();
  }

  @override
  void onReady() {}
}