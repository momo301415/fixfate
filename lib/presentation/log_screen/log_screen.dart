import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/presentation/log_screen/controller/log_controller.dart';
import 'package:pulsedevice/presentation/log_screen/log_detail_screen.dart';

class LogScreen extends GetView<LogController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log 列表'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Obx(() {
        if (controller.logs.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.logs.length,
          itemBuilder: (context, index) {
            final item = controller.logs[index];
            final parsed = json.decode(item.rawLogData) as Map<String, dynamic>;
            final createdAt =
                item.createdAt.format(pattern: 'yyyy/MM/dd HH:mm');

            return ExpansionTile(
              title: Text('時間: $createdAt'),
              children: parsed.keys.map((category) {
                return ListTile(
                  title: Text(category),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Get.to(() => LogDetailScreen(
                        logItem: item,
                        category: category,
                        dataList: parsed[category],
                      )),
                );
              }).toList(),
            );
          },
        );
      }),
    );
  }
}
