import 'package:flutter/material.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';

import 'controller/k7_controller.dart';
// ignore_for_file: must_be_immutable

/// 運動紀錄-單筆頁面

class K7Screen extends GetWidget<K7Controller> {
  const K7Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      title: "lbl256".tr,
      child: Container(
        height: 796.h,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Opacity(
              opacity: 0.4,
              child: CustomImageView(
                imagePath: controller.record.sportType == "aerobic"
                    ? ImageConstant.imgIcon11
                    : ImageConstant.imgIcon12,
                height: 252.h,
                width: 254.h,
              ),
            ),
            Column(
              children: [
                SizedBox(height: 100.h),
                Text(
                    controller.record.sportType == "aerobic"
                        ? "lbl253".tr
                        : "lbl255".tr,
                    style: CustomTextStyles.displaySmallPrimary),
                SizedBox(height: 8.h),
                _buildDurationDisplay(),
                SizedBox(height: 32.h),
                _buildDetailsCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTimeBox(
            controller.record.hours.toString().padLeft(2, '0'), "lbl257".tr),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.h),
          child: Text(":", style: TextStyle(fontSize: 32.fSize)),
        ),
        _buildTimeBox(
            controller.record.minutes.toString().padLeft(2, '0'), "lbl249".tr),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.h),
          child: Text(":", style: TextStyle(fontSize: 32.fSize)),
        ),
        _buildTimeBox(
            controller.record.seconds.toString().padLeft(2, '0'), "lbl259".tr),
      ],
    );
  }

  Widget _buildTimeBox(String value, String unit) {
    return Column(
      children: [
        Text(value, style: CustomTextStyles.displaySmallPrimaryContainer),
        SizedBox(height: 4.v),
        Text(unit, style: CustomTextStyles.bodyLargePrimaryContainer16_1),
      ],
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        children: [
          _buildStatRow(
            iconPath: ImageConstant.imgUCalender,
            label: "lbl260".tr,
            value: controller.record.time.format(pattern: 'yyyy.MM.dd HH:mm'),
            unit: '',
          ),
          Divider(height: 1),
          _buildStatRow(
            iconPath: ImageConstant.imgFavorite,
            label: "lbl261".tr,
            value: controller.record.maxBpm.toString(),
            unit: "Bpm",
          ),
          Divider(height: 1),
          _buildStatRow(
            iconPath: ImageConstant.imgFavorite,
            label: "lbl262".tr,
            value: controller.record.avgBpm.toString(),
            unit: "Bpm",
          ),
          Divider(height: 1),
          _buildStatRow(
            iconPath: ImageConstant.imgFavorite,
            label: "lbl263".tr,
            value: controller.record.minBpm.toString(),
            unit: "Bpm",
          ),
          Divider(height: 1),
          _buildStatRow(
            iconPath: ImageConstant.imgURuler,
            label: "lbl264".tr,
            value: controller.record.distance.toString(),
            unit: "lbl193".tr,
          ),
          Divider(height: 1),
          _buildStatRow(
            iconPath: ImageConstant.imgUserGray500,
            label: "lbl218".tr,
            value: controller.record.step.toString(),
            unit: "lbl187".tr,
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow({
    required String iconPath,
    required String label,
    required String value,
    required String unit,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 10.v),
      child: Row(
        children: [
          CustomImageView(imagePath: iconPath, height: 20.h, width: 20.h),
          SizedBox(width: 8.h),
          Text(label, style: CustomTextStyles.bodyMedium15),
          Spacer(),
          Text(value, style: CustomTextStyles.headlineSmallPrimary),
          if (unit.isNotEmpty) ...[
            SizedBox(width: 4.h),
            Text(unit, style: CustomTextStyles.bodyLargePrimaryContainer16_1),
          ],
        ],
      ),
    );
  }
}
