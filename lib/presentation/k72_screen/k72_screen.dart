// ✅ K72Screen：遮罩不再覆蓋 Header，掃描區域正確顯示
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pulsedevice/theme/custom_button_style.dart';
import 'package:pulsedevice/widgets/app_bar/appbar_leading_image.dart';
import 'package:pulsedevice/widgets/app_bar/appbar_subtitle.dart';
import 'package:pulsedevice/widgets/app_bar/appbar_trailing_image.dart';
import 'package:pulsedevice/widgets/custom_elevated_button.dart';
import '../../core/app_export.dart';
import 'controller/k72_controller.dart';

/// 新增家人頁面，掃描qr code
class K72Screen extends GetWidget<K72Controller> {
  const K72Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double headerHeight = 100.h;
    final double scanSize = Get.width * 0.6;

    return Scaffold(
      body: Stack(
        children: [
          // 相機畫面作為背景
          Positioned.fill(
            child: MobileScanner(
              controller: controller.scannerController,
              onDetect: controller.onDetect,
            ),
          ),

          // ✅ 遮罩與掃描框 (header 之下)
          Positioned(
            top: headerHeight / 2.5,
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildScanOverlay(scanSize),
          ),

          // ✅ Header 區塊
          _buildHeader(headerHeight),

          // ✅ 掃描結果與底部按鈕
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() {
                    final result = controller.scanResult.value;
                    return result.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: Text(
                              result,
                              style: TextStyle(
                                fontSize: 16.fSize,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  }),

                  /// 暫時註解選擇圖片功能
                  // CustomElevatedButton(
                  //   text: "lbl215".tr,
                  //   margin: EdgeInsets.symmetric(horizontal: 16.h),
                  //   leftIcon: Container(
                  //       margin: EdgeInsets.only(right: 10.h),
                  //       child: CustomImageView(
                  //         imagePath: ImageConstant.imgFi,
                  //         height: 24.h,
                  //         width: 24.h,
                  //         fit: BoxFit.contain,
                  //       )),
                  //   buttonStyle: CustomButtonStyles.fillGrayTL8,
                  //   buttonTextStyle:
                  //       CustomTextStyles.titleMediumPrimaryContainer16,
                  //   onPressed: () {
                  //     controller.pickImageAndScan();
                  //   },
                  // ),
                  SizedBox(height: 18.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(double height) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            ImageConstant.imgUnionBg2,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.only(top: 18.h, left: 16.h, right: 16.h),
            child: Row(
              children: [
                AppbarLeadingImage(
                  imagePath: ImageConstant.imgArrowLeft,
                  onTap: () => Get.back(),
                ),
                Expanded(
                  child: Center(
                    child: AppbarSubtitle(
                      text: "lbl202".tr,
                    ),
                  ),
                ),
                AppbarTrailingImage(
                  imagePath: ImageConstant.imgUQrcodeScan,
                  margin: EdgeInsets.only(right: 14.h),
                  onTap: () => controller.gok71Screen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanOverlay(double scanSize) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;
      final left = (width - scanSize) / 2;
      final top = (height - scanSize) / 2;

      return ClipRect(
        child: Stack(
          children: [
            ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.black54,
                BlendMode.srcOut,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      backgroundBlendMode: BlendMode.dstOut,
                    ),
                  ),
                  Positioned(
                    left: left,
                    top: top,
                    width: scanSize,
                    height: scanSize,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 四角框裝飾
            Positioned(
              left: left,
              top: top,
              width: scanSize,
              height: scanSize,
              child: Stack(
                children: [
                  _buildCorner(Alignment.topLeft, 0),
                  _buildCorner(Alignment.topRight, 90),
                  _buildCorner(Alignment.bottomLeft, 270),
                  _buildCorner(Alignment.bottomRight, 180),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildCorner(Alignment alignment, double rotate) {
    return Align(
      alignment: alignment,
      child: Transform.rotate(
        angle: rotate * pi / 180,
        child: SizedBox(
          width: 32.h,
          height: 32.h,
          child: CustomPaint(
            painter: _CornerPainter(),
          ),
        ),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.4);
    path.lineTo(0, 0);
    path.lineTo(size.width * 0.4, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
