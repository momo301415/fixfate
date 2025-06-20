import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/presentation/five_dialog/controller/five_controller.dart';
import 'package:pulsedevice/presentation/five_dialog/five_dialog.dart';
import 'package:pulsedevice/presentation/three_dialog/controller/three_controller.dart';
import 'package:pulsedevice/presentation/three_dialog/three_dialog.dart';

class DialogHelper {
  final gc = Get.find<GlobalController>();
  static void showThreeDialog() {
    final controller = Get.put(ThreeController());

    Get.dialog(PositionedDialogWrapper(child: ThreeDialog(controller)),
        barrierDismissible: false);
  }

  static void showError(String message, {VoidCallback? onOk}) {
    final controller = Get.put(FiveController());
    Get.dialog(FiveDialog(
      controller,
      message: message,
      onOk: onOk,
    ));
  }

  static void onTapDialogTitle(
    BuildContext context,
    Widget className,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: className,
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
        );
      },
    );
  }

  /// Common click event for bottomsheet
  static void onTapBottomSheetTitle(
    BuildContext context,
    Widget className,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return className;
      },
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  static Future<T?> showCustomBottomSheet<T>(
    BuildContext context,
    Widget className,
  ) {
    return showModalBottomSheet<T>(
      context: context,
      builder: (context) => className,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  /// ✅ 共用 dialog（透明背景、支援回傳值）
  static Future<T?> showCustomDialog<T>(
    BuildContext context,
    Widget className,
  ) {
    return showDialog<T>(
      context: Get.context!,
      builder: (context) => AlertDialog(
        content: className,
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
      ),
    );
  }

  static Future<Map<String, dynamic>?> showFamilyNickNameDialog() {
    final nicknameController = TextEditingController();

    return Get.dialog<Map<String, dynamic>>(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '家人新增',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                '為家人添加暱稱吧',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: nicknameController,
                decoration: const InputDecoration(
                  labelText: '請輸入對方暱稱',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Get.back(result: {"confirm": false}),
                    child: const Text(
                      '取消',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back(result: {
                        "confirm": true,
                        "nickname": nicknameController.text.trim(),
                      });
                    },
                    child: const Text(
                      '確定',
                      style: TextStyle(
                        color: Colors.cyan,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Future<bool?> showFamilyRequestDialog(String requesterName) {
    return Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '家人新增',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                '$requesterName 想要讀取您的健康資訊，\n您願意分享給他嗎？',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Get.back(result: false),
                    child: const Text(
                      '不願意',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.back(result: true),
                    child: const Text(
                      '願意',
                      style: TextStyle(
                        color: Colors.cyan,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Future<bool?> showFamilyConfirmDialog() {
    return Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '家人新增',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                '家人已經綁定成功',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Get.back(result: true),
                    child: const Text(
                      '確定',
                      style: TextStyle(
                        color: Colors.cyan,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Future<bool?> showFamilyDeleteDialog() {
    return Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '確認刪除',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                '刪除家人後需要重新加入，\n確定要刪除嗎？',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Get.back(result: false),
                    child: const Text(
                      '取消',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.back(result: true),
                    child: const Text(
                      '確定刪除',
                      style: TextStyle(
                        color: Colors.cyan,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}

class PositionedDialogWrapper extends StatelessWidget {
  final Widget child;
  final double topRatio; // 位置控制，預設為 25% 高

  const PositionedDialogWrapper({
    Key? key,
    required this.child,
    this.topRatio = 0.25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * topRatio),
          child: child,
        ),
      ),
    );
  }
}
