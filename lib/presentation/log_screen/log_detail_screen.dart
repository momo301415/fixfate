import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/presentation/log_screen/model/log_item.dart';

class LogDetailScreen extends StatelessWidget {
  final LogItem logItem;
  final String category;
  final List<dynamic> dataList;

  const LogDetailScreen({
    required this.logItem,
    required this.category,
    required this.dataList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Created At: ${logItem.createdAt.format(pattern: 'yyyy/MM/dd HH:mm:ss')}'),
              const SizedBox(height: 8),
              Text('總筆數：${dataList.length} 筆'),
              const SizedBox(height: 12),
              ...dataList.map((e) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      const JsonEncoder.withIndent('  ').convert(e),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
