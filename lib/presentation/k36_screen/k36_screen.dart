import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k36_controller.dart';
import 'models/list_one_item_model.dart';
import 'widgets/list_one_item_widget.dart'; // ignore_for_file: must_be_immutable

class K36DeviceDetailesScreen extends GetWidget<K36Controller> {
  const K36DeviceDetailesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      title: "lbl62".tr,
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 16.h),
            child: Column(
              spacing: 16,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDeviceInfoSection(),
                CustomElevatedButton(
                  height: 58.h,
                  text: "lbl440".tr,
                  leftIcon: Container(
                    margin: EdgeInsets.only(right: 10.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgUtachometerfastalt,
                      height: 24.h,
                      width: 24.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  buttonStyle: CustomButtonStyles.none,
                  decoration:
                      CustomButtonStyles.gradientCyanToPrimaryTL24Decoration,
                  onPressed: () async {
                    final res =
                        await Get.toNamed(AppRoutes.k76Screen, arguments: 8);
                  },
                ),
                _buildAutoClaimSettingsSection(),
                _buildDataClaimSection(),
              ],
            ),
          ),
          _buildDeleteDeviceButtonSection()
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildDeviceInfoSection() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(36.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgFrame866181,
            height: 120.h,
            width: 122.h,
          ),
          Text(
            "lbl_scanfit".tr,
            style: CustomTextStyles.titleMediumManropePrimaryContainer,
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.fromLTRB(8.h, 8.h, 8.h, 6.h),
            decoration: AppDecoration.outlineGray200,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("lbl438".tr, style: CustomTextStyles.bodySmall10),
                Text("lbl_803".tr, style: CustomTextStyles.bodySmall10),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.fromLTRB(8.h, 8.h, 8.h, 6.h),
            decoration: AppDecoration.outlineGray200,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("lbl_id".tr, style: CustomTextStyles.bodySmall10),
                Text(
                  "lbl_86549685496894".tr,
                  style: CustomTextStyles.bodySmall10,
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("lbl439".tr, style: CustomTextStyles.bodySmall10),
                Text(
                  "msg_2023_03_24_18_09_23".tr,
                  style: CustomTextStyles.bodySmall10,
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAutoClaimSettingsSection() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        spacing: 26,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => controller.isAutoComfirn.value =
                !controller.isAutoComfirn.value,
            child: Container(
              padding: EdgeInsets.fromLTRB(24.h, 26.h, 24.h, 24.h),
              decoration: AppDecoration.outlineGray200,
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: _buildClaimNotificationSection(
                      one: "lbl441".tr,
                      notificationMessage: "msg43".tr,
                    ),
                  ),
                  Obx(() => CustomImageView(
                        imagePath: controller.isAutoComfirn.value
                            ? ImageConstant.imgSwitchPrimary
                            : ImageConstant.imgSwitch,
                        height: 30.h,
                        width: 50.h,
                      )),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () =>
                controller.isComfirnNot.value = !controller.isComfirnNot.value,
            child: Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 24.h),
              child: Row(
                children: [
                  Expanded(
                    child: _buildClaimNotificationSection(
                      one: "lbl442".tr,
                      notificationMessage: "msg_52".tr,
                    ),
                  ),
                  Obx(() => CustomImageView(
                        imagePath: controller.isComfirnNot.value
                            ? ImageConstant.imgSwitchPrimary
                            : ImageConstant.imgSwitch,
                        height: 30.h,
                        width: 50.h,
                      )),
                ],
              ),
            ),
          ),
          SizedBox(height: 28.h),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildDataClaimSection() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 24.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "lbl434".tr,
                        style: CustomTextStyles.titleSmallErrorContainer,
                      ),
                      Text(
                        "lbl_203".tr,
                        style: CustomTextStyles.bodySmallBluegray40010,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.showDeteleialog(),
                  child: Text("lbl443".tr,
                      style: CustomTextStyles.bodySmallPrimary10_1),
                ),
              ],
            ),
          ),
          Obx(
            () => ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:
                  controller.k36ModelObj.value.listOneItemList.value.length,
              itemBuilder: (context, index) {
                ListOneItemModel model =
                    controller.k36ModelObj.value.listOneItemList.value[index];
                return ListOneItemWidget(model);
              },
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildDeleteDeviceButtonSection() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: AppDecoration.outlinePrimary.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("lbl136".tr, style: CustomTextStyles.titleMediumPrimary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildClaimNotificationSection({
    required String one,
    required String notificationMessage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          one,
          style: CustomTextStyles.titleMediumErrorContainer16.copyWith(
            color: theme.colorScheme.errorContainer,
          ),
        ),
        Text(
          notificationMessage,
          style: CustomTextStyles.bodySmallBluegray40010.copyWith(
            color: appTheme.blueGray400,
          ),
        ),
      ],
    );
  }

  /// Navigates to the previous screen.
  onTapImgArrowleftone() {
    Get.back();
  }
}
