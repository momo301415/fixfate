import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/presentation/ruler_piker_test/controller/ruler_picker_test_controller.dart';
import 'package:pulsedevice/widgets/ruler_piker.dart';
import '../../core/app_export.dart';

class RulerPickerTestScreen extends GetWidget<RulerPickerTestScreenController> {
  final RxInt testValue = 100.obs;

  RulerPickerTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RulerPicker 測試')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 24.v),
        child: Column(
          children: [
            Obx(() => Text(
                  '當前數值：${testValue.value}',
                  style: TextStyle(fontSize: 20.fSize),
                )),
            SizedBox(height: 32.v),
            // RulerPicker(
            //   min: 80,
            //   max: 140,
            //   // rxValue: testValue,
            //   initialValue: 100.0,
            //   onValueChanged: (value) {
            //     testValue.value = value.toInt();
            //   },
            // ),
            SizedBox(height: 32.v),
            ElevatedButton(
              onPressed: () => testValue.value = 100,
              child: const Text('重設為 100'),
            ),
          ],
        ),
      ),
    );
  }
}
