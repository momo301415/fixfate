import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/presentation/five_dialog/controller/five_controller.dart';
import 'package:pulsedevice/presentation/five_dialog/five_dialog.dart';
import 'package:pulsedevice/presentation/three_dialog/controller/three_controller.dart';
import 'package:pulsedevice/presentation/three_dialog/three_dialog.dart';

class DialogHelper {
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
