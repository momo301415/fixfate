import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../models/food_nutrition_model.dart';

/// 营养信息结果卡片组件 - 基于k15_screen样式
class NutritionResultCard extends StatelessWidget {
  final FoodNutritionInfo nutrition;
  final VoidCallback? onTap;

  const NutritionResultCard({
    Key? key,
    required this.nutrition,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.h, 10.h, 8.h, 8.h),
      decoration: AppDecoration.outlineGray200,
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 食物图标
            Container(
              height: 40.h,
              width: 40.h,
              decoration: AppDecoration.fillPrimary1.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder20,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgClosePrimary, // 使用默认图标
                    height: 20.h,
                    width: 22.h,
                  ),
                ],
              ),
            ),
            // 营养信息内容
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(left: 12.h, top: 4.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 第一行：食物名称和卡路里
                      SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                nutrition.foodName,
                                style: CustomTextStyles.labelMediumPrimarySemiBold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  nutrition.calories.toStringAsFixed(0),
                                  style: CustomTextStyles.titleSmallPrimary,
                                ),
                                Text(
                                  ' kcal',
                                  style: CustomTextStyles.bodySmallBluegray40010,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 6.h),
                      // 第二行：蛋白质和碳水化合物
                      SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Text(
                              '蛋白质',
                              style: CustomTextStyles.bodySmallBluegray4008,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.h),
                              child: Text(
                                nutrition.protein.toStringAsFixed(1),
                                style: CustomTextStyles.labelSmallBluegray400,
                              ),
                            ),
                            Text(
                              'g',
                              style: CustomTextStyles.bodySmallBluegray4008,
                            ),
                            // 分隔符
                            CustomImageView(
                              imagePath: ImageConstant.imgVector308,
                              height: 6.h,
                              width: 3.h,
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.only(left: 8.h, right: 6.h),
                            ),
                            Text(
                              '碳水',
                              style: CustomTextStyles.bodySmallBluegray4008,
                            ),
                            Spacer(),
                            Text(
                              nutrition.carbohydrates.toStringAsFixed(1),
                              style: CustomTextStyles.labelSmallBluegray400,
                            ),
                            Text(
                              'g',
                              style: CustomTextStyles.bodySmallBluegray4008,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      // 第三行：脂肪和纤维素
                      SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Text(
                              '脂肪',
                              style: CustomTextStyles.bodySmallBluegray4008,
                            ),
                            Spacer(flex: 31),
                            Text(
                              nutrition.fat.toStringAsFixed(1),
                              style: CustomTextStyles.labelSmallBluegray400,
                            ),
                            Text(
                              'g',
                              style: CustomTextStyles.bodySmallBluegray4008,
                            ),
                            // 分隔符
                            CustomImageView(
                              imagePath: ImageConstant.imgVector308,
                              height: 6.h,
                              width: 3.h,
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.only(left: 8.h, right: 6.h),
                            ),
                            Text(
                              '纤维',
                              style: CustomTextStyles.bodySmallBluegray4008,
                            ),
                            Spacer(flex: 25),
                            Text(
                              nutrition.fiber.toStringAsFixed(1),
                              style: CustomTextStyles.labelSmallBluegray400,
                            ),
                            Text(
                              'g',
                              style: CustomTextStyles.bodySmallBluegray4008,
                            ),
                            Spacer(flex: 42),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 营养分析结果展示页面 - 基于k15_screen样式
class NutritionAnalysisResultScreen extends StatelessWidget {
  final FoodAnalysisResult analysisResult;

  const NutritionAnalysisResultScreen({
    Key? key,
    required this.analysisResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryContainer,
      appBar: AppBar(
        title: Text('营养分析结果'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 20.h,
          right: 16.h,
        ),
        child: Column(
          spacing: 20,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 总营养信息卡片
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(16.h),
              decoration: AppDecoration.fillWhiteA.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 16.h),
                  CustomImageView(
                    imagePath: ImageConstant.imgClosePrimary,
                    height: 24.h,
                    width: 26.h,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '总营养信息',
                    style: CustomTextStyles.titleSmallPrimary,
                  ),
                  Text(
                    '基于AI分析的营养成分估算',
                    style: CustomTextStyles.bodySmallBluegray4008,
                  ),
                  SizedBox(height: 24.h),
                  
                  // 总营养信息展示
                  _buildTotalNutritionInfo(),
                  
                  SizedBox(height: 22.h),
                  
                  // 食物列表
                  if (analysisResult.foods.isNotEmpty) ...[
                    Text(
                      '识别的食物',
                      style: CustomTextStyles.titleSmallPrimary,
                    ),
                    SizedBox(height: 12.h),
                    _buildFoodListSection(),
                    SizedBox(height: 22.h),
                  ],
                  
                  // 分析说明
                  if (analysisResult.analysisNote.isNotEmpty) ...[
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.all(12.h),
                      decoration: AppDecoration.fillGray.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: Text(
                        analysisResult.analysisNote,
                        style: CustomTextStyles.bodySmallBluegray4008,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 22.h),
                  ],
                  
                  // 操作按钮
                  CustomElevatedButton(
                    text: '保存到记录',
                    buttonStyle: CustomButtonStyles.fillGrayTL8,
                    buttonTextStyle: CustomTextStyles.bodyLargeBluegray400,
                    onPressed: () {
                      Get.snackbar('提示', '保存功能开发中...');
                    },
                  ),
                ],
              ),
            ),
            
            // 底部按钮
            CustomElevatedButton(
              text: '重新分析',
              buttonStyle: CustomButtonStyles.none,
              decoration: CustomButtonStyles.gradientCyanToPrimaryTL8Decoration,
              onPressed: () => Get.back(),
            ),
            
            Text(
              '数据仅供参考，实际营养成分可能有所差异',
              style: CustomTextStyles.titleMediumBluegray400,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// 构建总营养信息
  Widget _buildTotalNutritionInfo() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.outlineGray200.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('总卡路里', style: CustomTextStyles.bodyLargeBluegray400),
              Row(
                children: [
                  Text(
                    analysisResult.totalCalories.toStringAsFixed(0),
                    style: CustomTextStyles.titleMediumPrimary,
                  ),
                  Text(' kcal', style: CustomTextStyles.bodySmallBluegray40010),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _buildNutrientRow('蛋白质', analysisResult.totalProtein, 'g'),
          SizedBox(height: 8.h),
          _buildNutrientRow('碳水化合物', analysisResult.totalCarbohydrates, 'g'),
          SizedBox(height: 8.h),
          _buildNutrientRow('脂肪', analysisResult.totalFat, 'g'),
          SizedBox(height: 8.h),
          _buildNutrientRow('纤维素', analysisResult.totalFiber, 'g'),
        ],
      ),
    );
  }

  /// 构建营养素行
  Widget _buildNutrientRow(String name, double value, String unit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: CustomTextStyles.bodyMediumBluegray400),
        Row(
          children: [
            Text(
              value.toStringAsFixed(1),
              // style: CustomTextStyles.labelMediumBluegray400,
            ),
            Text(' $unit', style: CustomTextStyles.bodySmallBluegray40010),
          ],
        ),
      ],
    );
  }

  /// 构建食物列表
  Widget _buildFoodListSection() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return SizedBox(height: 12.h);
      },
      itemCount: analysisResult.foods.length,
      itemBuilder: (context, index) {
        final food = analysisResult.foods[index];
        return NutritionResultCard(
          nutrition: food,
          onTap: () {
            // 可以显示单个食物的详细信息
            _showFoodDetails(food);
          },
        );
      },
    );
  }

  /// 显示单个食物详情
  void _showFoodDetails(FoodNutritionInfo food) {
    Get.dialog(
      AlertDialog(
        title: Text(food.foodName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('卡路里: ${food.calories.toStringAsFixed(1)} kcal'),
            SizedBox(height: 8),
            Text('蛋白质: ${food.protein.toStringAsFixed(1)}g'),
            SizedBox(height: 8),
            Text('碳水化合物: ${food.carbohydrates.toStringAsFixed(1)}g'),
            SizedBox(height: 8),
            Text('脂肪: ${food.fat.toStringAsFixed(1)}g'),
            SizedBox(height: 8),
            Text('纤维素: ${food.fiber.toStringAsFixed(1)}g'),
            if (food.description.isNotEmpty) ...[
              SizedBox(height: 12),
              Text('描述:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(food.description),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('关闭'),
          ),
        ],
      ),
    );
  }
}