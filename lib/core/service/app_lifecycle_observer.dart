import 'package:flutter/widgets.dart';
import 'package:pulsedevice/core/global_controller.dart';

/// 智能App生命週期監聽器
/// 實現前景背景同步策略的動態切換
class AppLifecycleObserver extends WidgetsBindingObserver {
  final GlobalController gc;
  bool _isInForeground = true;
  static const String _tag = 'AppLifecycleObserver';

  AppLifecycleObserver(this.gc);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('🔄 [$_tag] App狀態變化: $state');

    switch (state) {
      case AppLifecycleState.resumed:
        await _onAppToForeground();
        break;
      case AppLifecycleState.paused:
        await _onAppToBackground();
        break;
      case AppLifecycleState.inactive:
        print('⚠️ [$_tag] App即將進入背景 (inactive)');
        break;
      case AppLifecycleState.detached:
        print('⚠️ [$_tag] App即將被終止 (detached)');
        break;
      case AppLifecycleState.hidden:
        print('⚠️ [$_tag] App被隱藏 (hidden)');
        break;
    }
  }

  /// 🎯 App回到前景 - 切換為前景同步模式
  Future<void> _onAppToForeground() async {
    if (!_isInForeground) {
      print('📱 [$_tag] ===== 切換到前景模式 =====');

      try {
        // 1. 停止GPS增強服務（省電）
        if (gc.locationEnhancementService.isLocationEnhancementEnabled) {
          gc.locationEnhancementService.stopLocationEnhancement();
          print('✅ [$_tag] GPS背景增強已停止（前景模式省電）');
        }

        // 2. 確保前景任務運行（如果藍牙已連接）
        if (gc.blueToolStatus.value == 2 && gc.userId.value.isNotEmpty) {
          await gc.startForegroundTask();
          print('✅ [$_tag] 前景定時器已啟動（每5分鐘）');
        }

        // 3. 立即執行一次同步
        var res = await gc.getBlueToothDeviceInfo();
        if (res && !gc.isSporting.value) {
          await gc.safeRunSync();
          print('✅ [$_tag] 前景同步已執行');
        }

        _isInForeground = true;
        print('🎯 [$_tag] 前景模式切換完成');
      } catch (e) {
        print('❌ [$_tag] 前景模式切換失敗: $e');
      }
    } else {
      print('📱 [$_tag] App回到前景（已在前景模式）');

      // 即使已在前景，也執行一次同步
      var res = await gc.getBlueToothDeviceInfo();
      if (res && !gc.isSporting.value) {
        await gc.safeRunSync();
      }
    }
  }

  /// 🎯 App切換到背景 - 切換為背景同步模式
  Future<void> _onAppToBackground() async {
    if (_isInForeground) {
      print('🌙 [$_tag] ===== 切換到背景模式 =====');

      try {
        // 1. 立即執行一次同步（切換前的最後同步）
        await gc.safeRunSync();
        print('✅ [$_tag] 背景切換前同步已執行');

        // 2. 🎯 App即將背景運行，主動請求Always權限
        if (gc.blueToolStatus.value == 2 && gc.userId.value.isNotEmpty) {
          final canUpgrade = await gc.canUpgradeLocationPermission();
          if (canUpgrade) {
            print('💡 [$_tag] App即將背景運行，主動請求Always權限...');
            await gc.triggerLocationPermissionUpgrade(context: 'App進入背景');
          }
        }

        // 3. 啟動GPS增強服務（背景保活）
        if (gc.locationEnhancementService != null &&
            gc.blueToolStatus.value == 2 &&
            gc.userId.value.isNotEmpty) {
          await gc.locationEnhancementService.startLocationEnhancement();
          print('✅ [$_tag] GPS背景增強已啟動');
        }

        // 注意：不停止ForegroundTask，讓它自然在背景運行
        // 這樣形成雙重保障：ForegroundTask + GPS增強

        _isInForeground = false;
        print('🎯 [$_tag] 背景模式切換完成');
      } catch (e) {
        print('❌ [$_tag] 背景模式切換失敗: $e');
      }
    } else {
      print('🌙 [$_tag] App切換到背景（已在背景模式）');
    }
  }

  /// 獲取當前模式狀態
  bool get isInForeground => _isInForeground;

  /// 手動觸發前景模式（測試用）
  Future<void> forceForegroundMode() async {
    _isInForeground = false;
    await _onAppToForeground();
  }

  /// 手動觸發背景模式（測試用）
  Future<void> forceBackgroundMode() async {
    _isInForeground = true;
    await _onAppToBackground();
  }
}
