import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/presentation/bg_log_page/controller/bg_log_controller.dart';

class BgLogPage extends StatelessWidget {
  const BgLogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BgLogController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("背景 Log Viewer"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.loadLog,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: controller.clearLog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Obx(() => SingleChildScrollView(
              child: SelectableText(
                controller.logContent.value,
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            )),
      ),
    );
  }
}
