// lib/controllers/countdown_controller.dart
import 'dart:async';
import 'dart:ui';
import 'package:get/get.dart';

class CountdownController extends GetxController {
  /// 幾秒開始倒數 (例如 3)
  final int initialCount;

  /// 倒數顯示到 GO 後要做的事 (關 Dialog + 開始運動)
  final VoidCallback onFinish;

  /// Rx 值：>0 時表示倒數秒數；==0 時表示最後一秒要顯示 "GO"
  final RxInt remaining = 0.obs;

  Timer? _timer;

  CountdownController({
    required this.initialCount,
    required this.onFinish,
  }) {
    remaining.value = initialCount;
  }

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remaining.value > 1) {
        // 普通倒數情況：3→2→……
        remaining.value--;
      } else if (remaining.value == 1) {
        // 剛從 1 進入：把 remaining 設 0，代表顯示 GO
        remaining.value = 0;

        // 先取消 periodic 不讓它繼續 tick
        timer.cancel();
        _timer = null;

        // 等一秒後再執行 onFinish 並刪除自己
        Future.delayed(const Duration(seconds: 1), () {
          onFinish();
          if (Get.isRegistered<CountdownController>()) {
            Get.delete<CountdownController>();
          }
        });
      }
      // 如果 remaining.value 已經變 0，就交給上面 Future 去做 onFinish，不需要再做任何動作
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
