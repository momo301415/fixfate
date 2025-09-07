// 新建文件：models/daily_nutrition_model.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DailyNutritionModel {
  // 卡路里摄入行数据
  RxInt calorieIntake = 0.obs;
  RxInt calorieTarget = 2000.obs;

  // 早餐数据
  RxString breakfastName = "早餐".obs;
  RxInt breakfastCalories = 0.obs;

  // 早茶数据
  RxString teaName = "早茶".obs;
  RxInt teaCalories = 0.obs;

  // 水分摄入数据
  RxInt waterIntake = 0.obs;
  RxInt waterTarget = 8.obs; // 8杯水

  // 午餐数据
  RxString lunchName = "午餐".obs;
  RxInt lunchCalories = 0.obs;

  // 点心数据
  RxString snackName = "点心".obs;
  RxInt snackCalories = 0.obs;

  // 奶茶数据
  RxString milkTeaName = "奶茶".obs;
  RxInt milkTeaCalories = 0.obs;

  // 晚餐数据
  RxString dinnerName = "晚餐".obs;
  RxInt dinnerCalories = 0.obs;

}