import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/k91_bottomsheet/controller/k91_controller.dart';
import '../../core/app_export.dart';

// ignore_for_file: must_be_immutable
/// 吸菸 Bottomsheet
class K91Bottomsheet extends StatelessWidget {
  K91Bottomsheet(this.controller, {Key? key})
      : super(
          key: key,
        );

  K91Controller controller;

  @override
  Widget build(BuildContext context) {
    final options = controller.options;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 40.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...options.map((key) => Column(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(result: key.tr),
                    child: Text(
                      key.tr,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              )),
          GestureDetector(
            onTap: () async {
              String? result = await showDialog<String>(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("請輸入內容"),
                  content: TextField(
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(hintText: "請輸入文字"),
                    onSubmitted: (value) => Get.back(result: value),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text("取消"),
                    ),
                  ],
                ),
              );
              if (result != null && result.trim().isNotEmpty) {
                Get.back(result: result.trim());
              }
            },
            child: Text(
              "lbl54_1".tr,
              style: CustomTextStyles.bodyLargeGray500_1,
            ),
          ),
          SizedBox(height: 16.h),
          Divider(color: appTheme.gray200),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () => Get.back(),
            child: Text(
              "lbl50".tr,
              style: CustomTextStyles.bodyLargeGray500_1,
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  /// Navigates to the k39Screen when the action is triggered.
  onTapTxtLabelthree() {
    Get.toNamed(
      AppRoutes.k39Screen,
    );
  }
}
