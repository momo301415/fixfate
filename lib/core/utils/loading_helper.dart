import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class LoadingHelper {
  static void show({String? message}) {
    if (Get.isDialogOpen == true) return;

    Get.dialog(
      PopScope(
        canPop: false,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SpinKitFadingCircle(
                color: Colors.blue,
                size: 50.0,
              ),
              if (message != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    message,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black45,
    );
  }

  static void hide() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}
