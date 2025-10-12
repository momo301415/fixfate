import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../../core/app_export.dart';
import '../controller/camera_controller.dart';

class AnalyzingOverlayWidget extends StatefulWidget {
  final CameraScreenController controller;

  const AnalyzingOverlayWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<AnalyzingOverlayWidget> createState() => _AnalyzingOverlayWidgetState();
}

class _AnalyzingOverlayWidgetState extends State<AnalyzingOverlayWidget>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    // 创建无限循环的旋转动画控制器
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // 开始无限循环旋转
    _rotationController.repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // 当分析完成时停止动画
      if (!widget.controller.isAnalyzing.value) {
        _rotationController.stop();
      } else if (!_rotationController.isAnimating) {
        _rotationController.repeat();
      }

      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            // 背景图片 - 用户选择或拍摄的照片
            if (widget.controller.currentAnalyzingImagePaths.isNotEmpty &&
                widget.controller.currentAnalyzingImagePaths.length == 1)
              _buildBackgroundImage(),

            // 如果有多张图片，使用PageView显示
            if (widget.controller.currentAnalyzingImagePaths.isNotEmpty &&
                widget.controller.currentAnalyzingImagePaths.length > 1)
              _buildMultipleImagesBackground(),

            // 中央分析状态容器
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40.h),
                padding: EdgeInsets.all(24.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 旋转的loading图片
                    AnimatedBuilder(
                      animation: _rotationController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _rotationController.value * 2 * 3.14159,
                          child: CustomImageView(
                            imagePath: ImageConstant.imgAnLoading,
                            height: 60.h,
                            width: 60.h,
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 16.h),

                    // 分析状态文本
                  ],
                ),
              ),
            ),
            Positioned(
              top: 140.h,
              left: 0,
              right: 0,
              child: Text(
                textAlign: TextAlign.center,
                "照片辨识中...",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildBackgroundImage() {
    final imagePath = widget.controller.currentAnalyzingImagePaths.first;
    ImageProvider imageProvider = FileImage(File(imagePath));
    // Image.file(File(imagePath),);
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.3), // 添加半透明遮罩
        ),
      ),
    );
  }

  Widget _buildMultipleImagesBackground() {
    return Positioned.fill(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.h,
              ),
              itemCount: widget.controller.currentAnalyzingImagePaths.length,
              itemBuilder: (context, index) {
                final imagePath =
                    widget.controller.currentAnalyzingImagePaths[index];
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(imagePath)),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0.3), // 添加半透明遮罩
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.3), // 添加半透明遮罩
          )
        ],
      ),
    );
  }
}
