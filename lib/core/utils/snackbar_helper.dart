import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/app_export.dart';

class SnackbarHelper {
  static void showBlueSnackbar({String? title, String? message}) {
    Get.showSnackbar(
      GetSnackBar(
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent, // 背景設為透明
        messageText: Stack(
          alignment: Alignment.centerLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                ImageConstant.imgUnionFullBg, // ⬅️ 你的背景圖片路徑
                fit: BoxFit.cover,
                width: double.infinity,
                height: 80.h, // 根據圖片高度自行調整
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (message != null)
                    Text(
                      message,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.h,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showErrorSnackbar({String? title, String? message}) {
    Get.snackbar(
      '',
      '',
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      titleText: title != null
          ? Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
      messageText: Text(
        message != null ? message : '',
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
      ),
    );
  }
}
