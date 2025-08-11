import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/custom_outlined_button.dart';
import 'controller/k71_controller.dart';
// ignore_for_file: must_be_immutable

/// 分享健康數據頁面
class K71Screen extends GetWidget<K71Controller> {
  const K71Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      title: "lbl213".tr,
      child: Container(
        height: 796.h,
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 796.h,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [_buildColumnqrcode()],
              ),
            )
          ],
        ),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgTelevision,
          margin: EdgeInsets.only(right: 31.h),
          onTap: () {
            controller.go72Screen();
          },
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildColumnqrcode() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 16.h,
        top: 72.h,
        right: 16.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 36.h,
      ),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        spacing: 28,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            final path = controller.qrPath.value;
            if (path.isEmpty) {
              return const CircularProgressIndicator(); // 或替代圖片
            } else {
              return Image.network(
                path,
                height: 150.h,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 80),
              );
            }
          }),
          Text(
            "msg_qrcode".tr,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: CustomTextStyles.bodyMedium_1,
          ),
          // CustomOutlinedButton(
          //   onPressed: () {
          //     controller.copyQrcode();
          //   },
          //   text: "lbl214".tr,
          //   leftIcon: Container(
          //     margin: EdgeInsets.only(right: 4.h),
          //     child: CustomImageView(
          //       imagePath: ImageConstant.imgArrowup,
          //       height: 20.h,
          //       width: 20.h,
          //       fit: BoxFit.contain,
          //     ),
          //   ),
          //   buttonTextStyle: CustomTextStyles.titleMediumPrimary,
          // )
        ],
      ),
    );
  }
}
