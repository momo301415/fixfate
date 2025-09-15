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
      body: Stack(
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return _buildLoadingView();
            }

            if (controller.errorMessage.value.isNotEmpty) {
              return _buildErrorView();
            }

            return _buildBody();
          }),
          _buildHeaderStack(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Obx(
            () {
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
            },
          ),
          Positioned(
            bottom: 106.h,
            left: 0,
            right: 0,
            child: _buildTabBar(),
          ),
        ],
      ),
    );
  }

  // Tab栏
  Widget _buildTabBar() {
    return Container(
      height: 40.h,
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
     
        borderRadius: BorderRadius.circular(8.h),
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => GestureDetector(
                  onTap: () => controller.switchTab(0),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.h),
                    height: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: controller.currentTabIndex.value == 0
                              ? theme.primaryColor
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "拍照",
                        style: TextStyle(
                          color: controller.currentTabIndex.value == 0
                              ? theme.primaryColor
                              : Colors.grey,
                          fontSize: 16,
                          fontWeight: controller.currentTabIndex.value == 0
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                )),
          ),
          Expanded(
            child: Obx(() => GestureDetector(
                  onTap: () => controller.switchTab(1),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: controller.currentTabIndex.value == 1
                              ? theme.primaryColor
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "相册",
                        style: TextStyle(
                          color: controller.currentTabIndex.value == 1
                              ? theme.primaryColor
                              : Colors.grey,
                          fontSize: 16,
                          fontWeight: controller.currentTabIndex.value == 1
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                )),
          ),
          Expanded(
            child: Obx(() => GestureDetector(
                  onTap: () => controller.switchTab(2),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: controller.currentTabIndex.value == 2
                              ? theme.primaryColor
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "文字",
                        style: TextStyle(
                          color: controller.currentTabIndex.value == 2
                              ? theme.primaryColor
                              : Colors.grey,
                          fontSize: 16,
                          fontWeight: controller.currentTabIndex.value == 2
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
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
      width: double.infinity,
      child: Obx(() {
        if (!controller.isCameraInitialized.value) {
          return Container(
            decoration: AppDecoration.fillGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder16,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16.h),
                  Text('请将下拍摄对象，清晰拍照', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          );
        }

        return Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            CameraPreview(
              controller.cameraController!,
            ),
            // 扫描框
            UnconstrainedBox(
              child: CustomImageView(
                imagePath: ImageConstant.imgFrame86948WhiteA700,
                height: 240.h,
                width: 240.h,
              ),
            ),
            // 提示文字
            Positioned(
              top: 140.h,
              left: 0,
              right: 0,
              child: Text(
                '请将下拍摄对象，清晰拍照',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  backgroundColor: Colors.black54,
                ),
              ),
            ),
            Positioned(
                bottom:176.h,
                child: GestureDetector(
                  onTap: controller.takePicture,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgContrast,
                    height: 48.h,
                    width: 50.h,
                  ),
                ))
          ],
        );
      }),
    );
  }

  // 相册视图
  Widget _buildAlbumView() {
    return Container(
      width: double.infinity,
      color: appTheme.teal50,
      child: Column(
        children: [
          // 相册头部信息
          Container(
            padding: EdgeInsets.all(16.h),
            margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
            decoration: AppDecoration.fillWhiteA.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder16,
            ),
            child: Row(
              children: [
                Icon(Icons.photo_library, size: 20, color: theme.primaryColor),
                SizedBox(width: 8.h),
                Text("所有照片", style: theme.textTheme.titleSmall),
                Spacer(),
                Obx(() => Text(
                      "已选择 ${controller.selectedAssets.length} 张",
                      style: CustomTextStyles.bodySmall10,
                    )),
              ],
            ),
          ),
          // 相册网格
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.h),
              padding: EdgeInsets.all(16.h),
              decoration: AppDecoration.fillWhiteA.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder16,
              ),
              child: Obx(() {
                if (controller.isLoadingAlbum.value) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16.h),
                        Text('正在加载相册...'),
                      ],
                    ),
                  );
                }

                if (controller.albumAssets.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.photo_library_outlined,
                            size: 64, color: Colors.grey),
                        SizedBox(height: 16.h),
                        Text("暂无照片", style: CustomTextStyles.bodySmall10),
                        SizedBox(height: 8.h),
                        ElevatedButton(
                          onPressed: controller.loadAlbumAssets,
                          child: Text('重新加载'),
                        ),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.h,
                    mainAxisSpacing: 8.h,
                  ),
                  itemCount: controller.albumAssets.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final asset = controller.albumAssets[index];
                    return _buildAlbumItem(asset);
                  },
                );
              }),
            ),
          ),
          // 底部确认按钮
          Container(
            padding: EdgeInsets.all(16.h),
            child: _buildAlbumControls(),
          ),
          SizedBox(height: 140.h),
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
        final selectedIndex =
            isSelected ? controller.getSelectedIndex(asset) : 0;

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
      height: 48.h,
      child: Obx(() => ElevatedButton(

            onPressed: controller.selectedAssets.isEmpty
                ? null
                : controller.confirmSelection,
            style: ElevatedButton.styleFrom(
              backgroundColor: controller.selectedAssets.isEmpty
                  ? Colors.grey
                  : theme.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.h),
              ),
              elevation: 0,
            ),
            child: Text(
              controller.selectedAssets.isEmpty
                  ? "新增"
                  : "新增 (${controller.selectedAssets.length})",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          )),
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
