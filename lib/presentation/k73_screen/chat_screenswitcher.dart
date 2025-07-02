import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/chat_screen_controller.dart';
import 'package:pulsedevice/presentation/k19_screen/k19_screen.dart';
import 'package:pulsedevice/presentation/k73_screen/k73_screen.dart';

class ChatScreenSwitcher extends StatefulWidget {
  const ChatScreenSwitcher({Key? key}) : super(key: key);

  @override
  State<ChatScreenSwitcher> createState() => _ChatScreenSwitcherState();
}

class _ChatScreenSwitcherState extends State<ChatScreenSwitcher> {
  final controller = Get.put(ChatScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const K73Screen(), // 主畫面

          Obx(() => IgnorePointer(
                ignoring: !controller.isK19Visible.value,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  offset: controller.isK19Visible.value
                      ? Offset.zero
                      : const Offset(0, -1),
                  child: const K19Screen(),
                ),
              )),
        ],
      ),
    );
  }
}
