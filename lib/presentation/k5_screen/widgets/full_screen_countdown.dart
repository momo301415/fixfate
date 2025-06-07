// lib/widgets/fullscreen_countdown.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/presentation/k5_screen/controller/countdown_controller.dart';

class FullscreenCountdown extends StatelessWidget {
  const FullscreenCountdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CountdownController controller =
        Get.find<CountdownController>(tag: 'k5_sport_countdown');

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Obx(() {
          final val = controller.remaining.value;
          if (val > 0) {
            // 剩 3、2、1 的時候，直接顯示數字
            return Text(
              '$val',
              style: const TextStyle(
                color: Color(0xFF58D8BE),
                fontSize: 200,
                fontWeight: FontWeight.bold,
              ),
            );
          } else {
            // val == 0 時，就顯示 "GO"
            return const Text(
              'GO',
              style: TextStyle(
                color: Color(0xFF58D8BE),
                fontSize: 200,
                fontWeight: FontWeight.bold,
              ),
            );
          }
        }),
      ),
    );
  }
}
