import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import '../../../core/app_export.dart';
import '../models/food_nutrition_model.dart';
import '../services/openai_service.dart';
import '../widgets/nutrition_result_card.dart';

class CameraScreenController extends GetxController {
  /// base64 encode
  String apiKey =
      'c2stcHJvai1TdzFqRHBPaHN3LUdrakVZWEVoMWtiOVk1eFZDdHV6MnMwS19QN3Y1MlpQWDZXY2FsMGxFUHhmemlpaEVUNmNSRmZJaDVJMWRvV1QzQmxia0ZKQ3JoM2VxV25LZ2x0bE5reWx3dTdvaXVHNXFhamZGZGwtQ2dLeGNTSDJSa1hrc0lucGo2akx3NW9GTUpsN0pzNUtLTlAxSEFFNEE=';
  // Tab控制
  RxInt currentTabIndex = 0.obs;

  // 相机相关
  CameraController? cameraController;
  RxBool isCameraInitialized = false.obs;
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  // 相册相关
  RxList<AssetEntity> albumAssets = <AssetEntity>[].obs;
  RxList<AssetEntity> selectedAssets = <AssetEntity>[].obs;
  RxBool isLoadingAlbum = false.obs;

  // 最大选择数量
  final int maxSelectCount = 3;

  // 食物分析相关
  final OpenAIService _openAIService = OpenAIService();
  RxBool isAnalyzing = false.obs;
  RxString analysisStatus = ''.obs;
  RxDouble analysisProgress = 0.0.obs;
  Rx<FoodAnalysisResult?> analysisResult = Rx<FoodAnalysisResult?>(null);

  // 当前分析的图片
  RxString currentAnalyzingImagePath = ''.obs;
  RxList<String> currentAnalyzingImagePaths = <String>[].obs;

  // 设置OpenAI API Key
  void setOpenAIApiKey(String apiKey) {
    _openAIService.setApiKey(apiKey);
  }

  // 显示API Key设置对话框
  void showApiKeyDialog() {
    final TextEditingController apiKeyController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('设置OpenAI API Key'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '请输入您的OpenAI API Key以使用食物分析功能：',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: apiKeyController,
              decoration: const InputDecoration(
                hintText: 'sk-...',
                border: OutlineInputBorder(),
                labelText: 'API Key',
              ),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              final apiKey = apiKeyController.text.trim();
              if (apiKey.isNotEmpty) {
                setOpenAIApiKey(apiKey);
                Get.back();
                Get.snackbar('成功', 'API Key已设置');
              } else {
                Get.snackbar('错误', '请输入有效的API Key');
              }
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    final decodeKey = utf8.decode(base64.decode(apiKey));
    setOpenAIApiKey(decodeKey);
    await initializeCamera();
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }

  // 初始化相机
  Future<void> initializeCamera() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // 获取可用相机
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        errorMessage.value = '没有可用的相机';
        return;
      }

      // 初始化相机控制器
      cameraController = CameraController(
        cameras.first,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await cameraController!.initialize();
      isCameraInitialized.value = true;
    } catch (e) {
      errorMessage.value = '相机初始化失败: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // 拍照
  Future<void> takePicture() async {
    if (!isCameraInitialized.value || cameraController == null) {
      Get.snackbar('错误', '相机未初始化');
      return;
    }

    try {
      final XFile photo = await cameraController!.takePicture();
      Get.snackbar('成功', '照片已保存: ${photo.path}');

      // 分析食物
      await analyzeFoodFromImage(photo.path);
    } catch (e) {
      Get.snackbar('错误', '拍照失败: $e');
    }
  }

  // 分析食物图片
  Future<void> analyzeFoodFromImage(String imagePath) async {
    try {
      isAnalyzing.value = true;
      analysisResult.value = null;
      currentAnalyzingImagePath.value = imagePath;
      currentAnalyzingImagePaths.clear();
      currentAnalyzingImagePaths.add(imagePath);

      // 模拟分析进度
      analysisStatus.value = '正在上传图片...';
      analysisProgress.value = 0.2;
      await Future.delayed(const Duration(milliseconds: 500));

      analysisStatus.value = '正在识别食物...';
      analysisProgress.value = 0.5;
      await Future.delayed(const Duration(milliseconds: 500));

      analysisStatus.value = '正在分析营养成分...';
      analysisProgress.value = 0.8;

      final File imageFile = File(imagePath);
      final result = await _openAIService.analyzeFoodImages([imageFile]);

      analysisStatus.value = '分析完成';
      analysisProgress.value = 1.0;
      await Future.delayed(const Duration(milliseconds: 300));

      analysisResult.value = result;

      // 显示分析结果
      _showAnalysisResult(result);
    } catch (e) {
      analysisStatus.value = '分析失败';
      Get.snackbar('错误', '食物分析失败: $e');
    } finally {
      isAnalyzing.value = false;
      analysisProgress.value = 0.0;
      analysisStatus.value = '';
      currentAnalyzingImagePath.value = '';
      currentAnalyzingImagePaths.clear();
    }
  }

  // 分析选中的相册照片
  Future<void> analyzeSelectedPhotos() async {
    if (selectedAssets.isEmpty) {
      Get.snackbar('提示', '请选择至少一张照片');
      return;
    }

    try {
      isAnalyzing.value = true;
      analysisResult.value = null;
      currentAnalyzingImagePath.value = '';
      currentAnalyzingImagePaths.clear();

      // 模拟分析进度
      analysisStatus.value = '正在处理选中的照片...';
      analysisProgress.value = 0.1;
      await Future.delayed(const Duration(milliseconds: 300));

      // 获取所有选中照片的文件
      List<File> imageFiles = [];
      for (var asset in selectedAssets) {
        final file = await asset.file;
        if (file != null) {
          imageFiles.add(file);
          currentAnalyzingImagePaths.add(file.path);
        }
      }

      if (imageFiles.isEmpty) {
        Get.snackbar('提示', '请先选择照片');
        return;
      }

      analysisStatus.value = '正在上传${imageFiles.length}张图片...';
      analysisProgress.value = 0.3;
      await Future.delayed(const Duration(milliseconds: 500));

      analysisStatus.value = '正在识别食物...';
      analysisProgress.value = 0.6;
      await Future.delayed(const Duration(milliseconds: 500));

      analysisStatus.value = '正在分析营养成分...';
      analysisProgress.value = 0.9;

      final result = await _openAIService.analyzeFoodImages(imageFiles);

      analysisStatus.value = '分析完成';
      analysisProgress.value = 1.0;
      await Future.delayed(const Duration(milliseconds: 300));

      analysisResult.value = result;
      _showAnalysisResult(result);
    } catch (e) {
      analysisStatus.value = '分析失败';
      Get.snackbar('错误', '食物分析失败: $e');
    } finally {
      isAnalyzing.value = false;
      analysisProgress.value = 0.0;
      analysisStatus.value = '';
      currentAnalyzingImagePath.value = '';
      currentAnalyzingImagePaths.clear();
    }
  }

  // 显示分析结果
  void _showAnalysisResult(FoodAnalysisResult result) {
    Get.dialog(
      AlertDialog(
        title: Text('食物分析结果'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('总卡路里: ${result.totalCalories.toStringAsFixed(1)} kcal'),
              SizedBox(height: 8),
              Text('总蛋白质: ${result.totalProtein.toStringAsFixed(1)}g'),
              SizedBox(height: 8),
              Text('总碳水化合物: ${result.totalCarbohydrates.toStringAsFixed(1)}g'),
              SizedBox(height: 8),
              Text('总脂肪: ${result.totalFat.toStringAsFixed(1)}g'),
              SizedBox(height: 8),
              Text('总纤维素: ${result.totalFiber.toStringAsFixed(1)}g'),
              if (result.analysisNote.isNotEmpty) ...[
                SizedBox(height: 12),
                Text('分析说明:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(result.analysisNote),
              ],
              if (result.foods.isNotEmpty) ...[
                SizedBox(height: 12),
                Text('识别的食物:', style: TextStyle(fontWeight: FontWeight.bold)),
                ...result.foods.map((food) => Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                          '• ${food.foodName} (${food.calories.toStringAsFixed(1)} kcal)'),
                    )),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('关闭'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              // 可以导航到营养详情页面
              _goToNutritionDetails(result);
            },
            child: Text('查看详情'),
          ),
        ],
      ),
    );
  }

  // 跳转到营养详情页面
  void _goToNutritionDetails(FoodAnalysisResult result) {
    Get.to(() => NutritionAnalysisResultScreen(analysisResult: result));
  }

  // 切换Tab
  void switchTab(int index) {
    currentTabIndex.value = index;
    if (index == 1 && albumAssets.isEmpty) {
      loadAlbumAssets();
    }
  }

  // 加载相册资源
  Future<void> loadAlbumAssets() async {
    try {
      isLoadingAlbum.value = true;

      // 请求相册权限
      final PermissionState permission =
          await PhotoManager.requestPermissionExtend();
      if (!permission.hasAccess) {
        Get.snackbar('错误', '需要相册访问权限');
        return;
      }

      // 获取相册
      final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: true,
      );

      if (albums.isNotEmpty) {
        // 获取最近的照片
        final List<AssetEntity> assets = await albums.first.getAssetListPaged(
          page: 0,
          size: 100,
        );
        albumAssets.value = assets;
      }
    } catch (e) {
      Get.snackbar('错误', '加载相册失败: $e');
    } finally {
      isLoadingAlbum.value = false;
    }
  }

  // 选择/取消选择照片
  void toggleAssetSelection(AssetEntity asset) {
    if (selectedAssets.contains(asset)) {
      selectedAssets.remove(asset);
    } else {
      if (selectedAssets.length >= maxSelectCount) {
        Get.snackbar('提示', '最多只能选择$maxSelectCount张照片');
        return;
      }
      selectedAssets.add(asset);
    }
  }

  // 检查是否已选择
  bool isAssetSelected(AssetEntity asset) {
    return selectedAssets.contains(asset);
  }

  // 获取选择的索引
  int getSelectedIndex(AssetEntity asset) {
    return selectedAssets.indexOf(asset) + 1;
  }

  // 确认选择
  void confirmSelection() {
    if (selectedAssets.isEmpty) {
      Get.snackbar('提示', '请选择至少一张照片');
      return;
    }

    // 分析选中的照片
    analyzeSelectedPhotos();
  }

  // 跳转到文字选择页面
  void goToTextSelection() {
    Get.snackbar('提示', '文字选择功能开发中...');
  }

  // 处理文字Tab的显示
  Widget buildTextSelectionView() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.text_fields,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 24),
          Text(
            '文字选择功能',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16),
          Text(
            '此功能正在开发中，敬请期待',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => switchTab(0),
            child: Text('返回拍照'),
          ),
        ],
      ),
    );
  }
}
