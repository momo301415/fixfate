import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/app_export.dart';

class SnackbarHelper {
  static void showBlueSnackbar({String? title, String? message}) {
    Get.snackbar(
      '',
      '',
      backgroundColor: const Color.fromARGB(255, 90, 173, 242),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      titleText: title != null
          ? Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.h,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
      messageText: Text(
        message != null ? message : '',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.h,
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
