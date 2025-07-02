import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  /// 控制是否顯示 K19 畫面
  final isK19Visible = false.obs;

  void showK19() => isK19Visible.value = true;
  void hideK19() => isK19Visible.value = false;
}
