import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class BgLogController extends GetxController {
  RxString logContent = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadLog();
  }

  Future<void> loadLog() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/bg_log.txt");

      if (await file.exists()) {
        final content = await file.readAsString();
        logContent.value = content;
      } else {
        logContent.value = '找不到背景 log 檔案';
      }
    } catch (e) {
      logContent.value = '讀取失敗: $e';
    }
  }

  Future<void> clearLog() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/bg_log.txt");
    if (await file.exists()) {
      await file.writeAsString('');
      logContent.value = '';
    }
  }
}
