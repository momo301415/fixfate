// 新建文件：widgets/nutrition_card_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/widgets/custom_icon_button.dart';
import '../../../core/app_export.dart';


enum NutritionCardType {
  breakfast,
  tea,
  waterIntake,
  lunch,
  snack,
  milkTea,
  dinner,
}

extension NutritionCardTypeExtension on NutritionCardType {
  String get displayName {
    switch (this) {
      case NutritionCardType.breakfast: return '早餐';
      case NutritionCardType.tea: return '早茶';
      case NutritionCardType.waterIntake: return '水';
      case NutritionCardType.lunch: return '午餐';
      case NutritionCardType.snack: return '点心';
      case NutritionCardType.milkTea: return '奶茶';
      case NutritionCardType.dinner: return '晚餐';
    }
  }

  // 从字符串值反查枚举
  static NutritionCardType? fromValue(String value) {
    for (var type in NutritionCardType.values) {
      if (type.displayName == value) {
        return type;
      }
    }
    return null;
  }
}

class FoodTypeData{
  String? foodType;
  double? foodKG;
  bool state;
  FoodTypeData({
    required this.foodType,
    required this.foodKG,
    required this.state
  });
}

class NutritionCardData {
  NutritionCardType type;
  List<FoodTypeData>? data;
  String? day;
  String? time;
  int? kcal;
  double? calorieValue;
  double? carbohydrateValue;
  double? fatValue;
  double? fiberValue;
  String? imagePath;
  String? foodName;
  int? number;
  String? piece;


  NutritionCardData({
    required this.type,
    this.data,
    this.day,
    this.time,
    this.kcal,
    this.foodName,
    this.number,
    this.imagePath,
    this.piece,
  });

  String getType(NutritionCardType type){
    return type.displayName;
  }

  // 复制方法，用于创建可编辑的副本
  NutritionCardData copyWith({
    NutritionCardType? type,
    String? day,
    List<FoodTypeData>? data,
    String? time,
    int? kcal,
    String? imagePath,
    String? foodName,
    int? number,
    String? piece
  }) {
    return NutritionCardData(
      type: type ?? this.type,
      data: data ?? this.data,
      kcal: kcal ?? this.kcal,
      day: day ?? this.day,
      time: time ?? this.time,
      imagePath: imagePath ?? this.imagePath,
      foodName: foodName ?? this.foodName,
      number: number ?? this.number,
      piece: piece ?? this.piece,
    );
  }
}

class NutritionCard extends StatelessWidget {
  final NutritionCardData data;

  const NutritionCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.h, 10.h, 8.h, 8.h),
      decoration: AppDecoration.outlineGray200,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomIconButton(
                height: 40.h,
                width: 40.h,
                padding: EdgeInsets.all(10.h),
                decoration: IconButtonStyleHelper.fillPrimary,
                child: CustomImageView(
                  imagePath: ImageConstant.imgFiRrUtensils,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 4.h),
                decoration: AppDecoration.gray100.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder2,
                ),
                child: Text(
                  "${data.getType(data.type)}",
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodySmallBluegray4008,
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: _buildSupperRow(
                  time: "lbl_9_30_am".tr,
                  prop: data.foodName?? "",
                  one: "${data.number}",
                  prop1: "${data.piece}",
                  calorieValue: "${data.kcal}",
                  kcal: "lbl_kcal".tr,
                  data:data.data,
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }



  /// Common widget
  Widget _buildSupperRow({
    required String time,
    required String prop,
    required String one,
    required String prop1,
    required String calorieValue,
    required String kcal,
    List<FoodTypeData>? data
  }) {
    return Column(
      spacing: 8,
      children: [
        SizedBox(
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 直接使用 Text，不需要 Obx
                    Text(
                      time,
                      style: CustomTextStyles.labelSmallPrimary.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    Text(
                      prop,
                      style: CustomTextStyles.bodySmall11.copyWith(
                        color: theme.colorScheme.errorContainer,
                      ),
                    ),
                  ],
                ),
              ),
              // 直接使用 Text，不需要 Obx
              Text(
                one,
                style: CustomTextStyles.titleSmallBluegray40014.copyWith(
                  color: appTheme.blueGray400,
                ),
              ),
              Text(
                prop1,
                style: CustomTextStyles.bodySmallBluegray40010.copyWith(
                  color: appTheme.blueGray400,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.h),
                child: Text(
                  calorieValue,
                  style: CustomTextStyles.titleSmallPrimary.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              Text(
                kcal,
                style: CustomTextStyles.bodySmallBluegray40010.copyWith(
                  color: appTheme.blueGray400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 10.h,
                  runSpacing: 10.h,
                  children: data?.map((item) =>
                      SizedBox(
                        width: 80.h, // 根据你的需求调整宽度
                        child: _buildNutritionCard(item),
                      )
                  ).toList() ?? [],
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgNotification,
                height: 16.h,
                width: 18.h,
                margin: EdgeInsets.only(top: 4.h),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionCard(FoodTypeData? card) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text( // 直接使用 Text
              card?.foodType ?? "",
              style: CustomTextStyles.bodySmallBluegray4008
                  .copyWith(color: appTheme.blueGray400),
            ),
          ),
          SizedBox(width: 8.h),
          Text( // 直接使用 Text
            "${card?.foodKG ?? 0}",
            style: CustomTextStyles.labelSmallBluegray400
                .copyWith(color: appTheme.blueGray400),
          ),
          Text(
            "g",
            style: CustomTextStyles.bodySmallBluegray4008
                .copyWith(color: appTheme.blueGray400),
          ),
        ],
      ),
    );
  }


}