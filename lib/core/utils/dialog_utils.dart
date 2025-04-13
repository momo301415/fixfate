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

  static void showError(String message) {
    final controller = Get.put(FiveController());
    Get.dialog(FiveDialog(controller, message: message));
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
