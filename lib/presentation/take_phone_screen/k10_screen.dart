import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pulsedevice/widgets/app_bar/appbar_leading_image.dart';
import 'package:pulsedevice/widgets/app_bar/appbar_subtitle.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import 'controller/k10_controller.dart';

class ScanFoodScreen extends GetWidget<ScanFoodController> {
  const ScanFoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.teal50,
      body: SafeArea(
        top: false,
        child: Obx(() => _buildBody()),
      ),
    );
  }

  Widget _buildBody() {
    if (controller.isLoading.value) {
      return _buildLoadingView();
    }

    if (controller.errorMessage.isNotEmpty) {
      return _buildErrorView();
    }

    if (!controller.hasCameraPermission) {
      return _buildPermissionDeniedView();
    }

    return _buildScannerView();
  }

  Widget _buildScannerView() {
    // BaseScaffoldImageHeader()
    if (controller.controller == null) {
      return _buildScannerLoadingView();
    }

    return SafeArea(
      top: false,
      child: SizedBox(
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            _buildScannerBackground(),
            _buildHeaderStack(),
          ],
        ),
      ),
    );
  }

  Widget _buildScannerBackground() {
    return Container(
      height: double.maxFinite,
      child: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            controller: controller.controller!,
            onDetect: controller.onCodeDetect,
            errorBuilder: (context, error) {
              return _buildScannerErrorView(error);
            },
          ),
          _buildOverlayContent(),
        ],
      ),
    );
  }

  Widget _buildOverlayContent() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 40.h,
      ),
      // decoration: AppDecoration.column9,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 40.h),
          Text(
            "lbl377".tr,
            style: CustomTextStyles.bodySmallWhiteA70011,
          ),
          SizedBox(height: 198.h),
          _buildScannerFrame(),
          Spacer(),
          _buildBottomControls(),
        ],
      ),
    );
  }

  Widget _buildScannerFrame() {
    return CustomImageView(
      imagePath: ImageConstant.imgFrame86948WhiteA700,
      height: 240.h,
      width: 240.h,
    );
  }

  Widget _buildBottomControls() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.k15Screen);
          },
          child: CustomImageView(
            imagePath: ImageConstant.imgContrast,
            height: 48,
            width: 48,
          ),
        ),
        SizedBox(height: 16.h),
        _buildPhotoOptionsRow(),
      ],
    );
  }

  Widget _buildPhotoOptionsRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 56.h, vertical: 4.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOptionText("lbl364".tr),
          _buildScanButton(),
          _buildOptionText("lbl365".tr),
        ],
      ),
    );
  }

  Widget _buildOptionText(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Text(text, style: CustomTextStyles.bodySmall10),
    );
  }

  Widget _buildScanButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 4.h),
      padding: EdgeInsets.fromLTRB(40.h, 8.h, 40.h, 6.h),
      decoration: AppDecoration.outlinePrimary,
      child: Text(
        "lbl125".tr,
        style: CustomTextStyles.bodySmallPrimary10_1,
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
          Text('Requesting camera permission...'.tr),
        ],
      ),
    );
  }

  Widget _buildScannerLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16.h),
          Text('Initializing scanner...'.tr),
        ],
      ),
    );
  }

  Widget _buildPermissionDeniedView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, size: 64, color: Colors.grey),
            SizedBox(height: 24.h),
            Text(
              'Camera Access Required'.tr,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Text(
              'This app needs camera access to scan QR codes'.tr,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              onPressed: controller.requestCameraPermission,
              child: Text('Grant Permission'.tr),
            ),
          ],
        ),
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
              'Error'.tr,
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
              onPressed: () async {
                await controller.requestCameraPermission;
              },
              child: Text('Retry'.tr),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScannerErrorView(Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.close, size: 64, color: Colors.red),
          SizedBox(height: 16.h),
          Text('Camera Error'.tr),
          SizedBox(height: 8.h),
          Text('$error', textAlign: TextAlign.center),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () async {
              await controller.requestCameraPermission;
            },
            child: Text('Retry'.tr),
          ),
        ],
      ),
    );
  }

  void onTapImgArrowleftone() {
    Get.back();
  }
}
