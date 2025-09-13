import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pulsedevice/widgets/app_bar/appbar_leading_image.dart';
import 'package:pulsedevice/widgets/app_bar/appbar_subtitle.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import 'controller/camera_controller.dart';
import 'dart:typed_data';

class ScanFoodScreen extends GetWidget<CameraScreenController> {
  const ScanFoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeaderStack(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return _buildLoadingView();
              }
              
              if (controller.errorMessage.value.isNotEmpty) {
                return _buildErrorView();
              }
              
              return _buildBody();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: Obx(() {
              switch (controller.currentTabIndex.value) {
                case 0:
                  return _buildCameraView();
                case 1:
                  return _buildAlbumView();
                case 2:
                  return controller.buildTextSelectionView();
                default:
                  return _buildCameraView();
              }
            }),
          ),
        ],
      ),
    );
  }

  // Tab栏
  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.h, vertical: 16.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => GestureDetector(
              onTap: () => controller.switchTab(0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: controller.currentTabIndex.value == 0
                    ? AppDecoration.outlinePrimary.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      )
                    : null,
                child: Text(
                  "拍照",
                  textAlign: TextAlign.center,
                  style: controller.currentTabIndex.value == 0
                      ? CustomTextStyles.bodySmallPrimary10_1
                      : CustomTextStyles.bodySmall10,
                ),
              ),
            )),
          ),
          Expanded(
            child: Obx(() => GestureDetector(
              onTap: () => controller.switchTab(1),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: controller.currentTabIndex.value == 1
                    ? AppDecoration.outlinePrimary.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      )
                    : null,
                child: Text(
                  "相册",
                  textAlign: TextAlign.center,
                  style: controller.currentTabIndex.value == 1
                      ? CustomTextStyles.bodySmallPrimary10_1
                      : CustomTextStyles.bodySmall10,
                ),
              ),
            )),
          ),
          Expanded(
            child: Obx(() => GestureDetector(
              onTap: () => controller.switchTab(2),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: controller.currentTabIndex.value == 2
                    ? AppDecoration.outlinePrimary.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      )
                    : null,
                child: Text(
                  "文字",
                  textAlign: TextAlign.center,
                  style: controller.currentTabIndex.value == 2
                      ? CustomTextStyles.bodySmallPrimary10_1
                      : CustomTextStyles.bodySmall10,
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }

  // 相机视图
  Widget _buildCameraView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (!controller.isCameraInitialized.value) {
                return Container(
                  decoration: AppDecoration.fillGray.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder16,
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              
              return Container(
                decoration: AppDecoration.fillGray.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder16,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.h),
                  child: CameraPreview(controller.cameraController!),
                ),
              );
            }),
          ),
          SizedBox(height: 32.h),
          _buildCameraControls(),
        ],
      ),
    );
  }

  // 相册视图
  Widget _buildAlbumView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.h),
            decoration: AppDecoration.fillWhiteA.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.photo_library, size: 20),
                    SizedBox(width: 8.h),
                    Text("所有照片", style: theme.textTheme.titleSmall),
                    Spacer(),
                    Obx(() => Text(
                      "已选择 ${controller.selectedAssets.length} 张",
                      style: CustomTextStyles.bodySmall10,
                    )),
                  ],
                ),
                SizedBox(height: 16.h),
                Obx(() {
                  if (controller.isLoadingAlbum.value) {
                    return Container(
                      height: 300.h,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  
                  if (controller.albumAssets.isEmpty) {
                    return Container(
                      height: 300.h,
                      child: Center(
                        child: Text("暂无照片", style: CustomTextStyles.bodySmall10),
                      ),
                    );
                  }
                  
                  return Container(
                    height: 300.h,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8.h,
                        mainAxisSpacing: 8.h,
                      ),
                      itemCount: controller.albumAssets.length,
                      itemBuilder: (context, index) {
                        final asset = controller.albumAssets[index];
                        return _buildAlbumItem(asset);
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          _buildAlbumControls(),
        ],
      ),
    );
  }



  // 相册项目
  Widget _buildAlbumItem(AssetEntity asset) {
    return GestureDetector(
      onTap: () => controller.toggleAssetSelection(asset),
      child: Obx(() {
        final isSelected = controller.isAssetSelected(asset);
        final selectedIndex = isSelected ? controller.getSelectedIndex(asset) : 0;
        
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.h),
            border: isSelected 
                ? Border.all(color: theme.primaryColor, width: 2)
                : null,
          ),
          child: Stack(
            children: [
              ClipRRect(
                 borderRadius: BorderRadius.circular(8.h),
                 child: FutureBuilder<Uint8List?>(
                   future: asset.thumbnailDataWithSize(ThumbnailSize(200, 200)),
                   builder: (context, snapshot) {
                     if (snapshot.hasData && snapshot.data != null) {
                       return Image.memory(
                         snapshot.data!,
                         width: double.infinity,
                         height: double.infinity,
                         fit: BoxFit.cover,
                       );
                     }
                     return Container(
                       color: Colors.grey[300],
                       child: Icon(Icons.image, color: Colors.grey),
                     );
                   },
                 ),
               ),
              if (isSelected)
                Positioned(
                  top: 4.h,
                  right: 4.h,
                  child: Container(
                    width: 20.h,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$selectedIndex',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  // 相机控制
  Widget _buildCameraControls() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(width: 48.h), // 占位
          GestureDetector(
            onTap: controller.takePicture,
            child: Container(
              width: 64.h,
              height: 64.h,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: theme.primaryColor, width: 4),
              ),
              child: Center(
                child: Container(
                  width: 48.h,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.k15Screen),
            child: Container(
              width: 48.h,
              height: 48.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.photo_library,
                color: theme.primaryColor,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 相册控制
  Widget _buildAlbumControls() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 16.h),
      child: ElevatedButton(
        onPressed: controller.confirmSelection,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.h),
          ),
        ),
        child: Obx(() => Text(
          controller.selectedAssets.isEmpty 
              ? "请选择照片" 
              : "确认选择 (${controller.selectedAssets.length}/3)",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        )),
      ),
    );
  }

  Widget _buildHeaderStack() {
    return SizedBox(
      height: 120.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 背景圖：不包 SafeArea，保留圓角
          Image.asset(
            ImageConstant.imgUnionBg2,
            fit: BoxFit.fill,
          ),

          // 標題與功能鍵內容：SafeArea 處理瀏海擠壓
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: SizedBox(
              height: 40.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: AppbarSubtitle(text: "lbl360".tr),
                  ),
                  Positioned(
                    left: 0,
                    child: AppbarLeadingImage(
                      imagePath: ImageConstant.imgArrowLeft,
                      onTap: () => Get.back(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16.h),
          Text('正在初始化相机...'),
        ],
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 64, color: Colors.red),
            SizedBox(height: 24.h),
            Text(
              '错误',
              style: theme.textTheme.titleLarge,
            ),
            SizedBox(height: 16.h),
            Text(
              controller.errorMessage.value,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              onPressed: controller.initializeCamera,
              child: Text('重试'),
            ),
          ],
        ),
      ),
    );
  }
}
