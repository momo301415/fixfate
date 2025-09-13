import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../core/app_export.dart';

class CameraScreenController extends GetxController {
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
  
  @override
  Future<void> onInit() async {
    super.onInit();
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
      // 这里可以添加保存照片到相册的逻辑
    } catch (e) {
      Get.snackbar('错误', '拍照失败: $e');
    }
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
      final PermissionState permission = await PhotoManager.requestPermissionExtend();
      if (!permission.isAuth) {
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
    
    // 这里可以处理选中的照片
    Get.snackbar('成功', '已选择${selectedAssets.length}张照片');
    // 可以导航到下一个页面或处理选中的照片
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