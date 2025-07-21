import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'location_enhancement_service.dart';

/// 定位增強背景同步測試助手
/// 用於測試和監控三重背景同步機制的效果
class LocationEnhancementTestHelper {
  static const String _tag = 'LocationTestHelper';

  /// 獲取三重背景同步狀態報告
  static Map<String, dynamic> getBackgroundSyncStatusReport() {
    final gc = Get.find<GlobalController>();

    Map<String, dynamic> report = {
      'timestamp': DateTime.now().toIso8601String(),
      'mechanisms': {},
    };

    // 1. ForegroundTask 狀態
    report['mechanisms']['foregroundTask'] = {
      'name': 'Flutter Foreground Task',
      'description': '前台5分鐘定時器',
      'status': 'unknown', // 需要從 flutter_foreground_task 獲取狀態
      'interval': '5分鐘',
    };

    // 2. BackgroundFetch 狀態
    report['mechanisms']['backgroundFetch'] = {
      'name': 'Background Fetch',
      'description': '系統原生背景任務',
      'status': 'configured',
      'interval': '系統決定',
    };

    // 3. LocationEnhancement 狀態
    try {
      final locationService = Get.find<LocationEnhancementService>();
      report['mechanisms']['locationEnhancement'] = {
        'name': 'GPS Location Enhancement',
        'description': 'GPS定時請求背景喚醒',
        'status': locationService.isLocationEnhancementEnabled
            ? 'enabled'
            : 'disabled',
        'syncCount': locationService.syncCount,
        'lastTrigger': locationService.lastSyncTrigger,
        'interval': '15分鐘',
        'serviceStatus': locationService.getServiceStatus(),
      };
    } catch (e) {
      report['mechanisms']['locationEnhancement'] = {
        'name': 'GPS Location Enhancement',
        'description': 'GPS定時請求背景喚醒',
        'status': 'error',
        'error': e.toString(),
      };
    }

    return report;
  }

  /// 觸發手動測試同步
  static Future<Map<String, dynamic>> triggerManualTestSync() async {
    final results = <String, dynamic>{
      'timestamp': DateTime.now().toIso8601String(),
      'tests': [],
    };

    try {
      final gc = Get.find<GlobalController>();

      // 測試1: 直接調用核心同步邏輯
      final test1Start = DateTime.now();
      await gc.safeRunSync();
      final test1Duration = DateTime.now().difference(test1Start);

      results['tests'].add({
        'name': 'Core Sync Test',
        'description': '直接調用safeRunSync()',
        'duration': '${test1Duration.inMilliseconds}ms',
        'status': 'completed',
      });

      // 測試2: 定位增強手動觸發
      try {
        final locationService = Get.find<LocationEnhancementService>();
        final test2Start = DateTime.now();
        await locationService.manualTriggerSync();
        final test2Duration = DateTime.now().difference(test2Start);

        results['tests'].add({
          'name': 'Location Enhancement Test',
          'description': '手動觸發GPS增強同步',
          'duration': '${test2Duration.inMilliseconds}ms',
          'status': 'completed',
        });
      } catch (e) {
        results['tests'].add({
          'name': 'Location Enhancement Test',
          'description': '手動觸發GPS增強同步',
          'status': 'failed',
          'error': e.toString(),
        });
      }
    } catch (e) {
      results['tests'].add({
        'name': 'Core Sync Test',
        'description': '直接調用safeRunSync()',
        'status': 'failed',
        'error': e.toString(),
      });
    }

    return results;
  }

  /// 顯示背景同步狀態對話框
  static void showBackgroundSyncStatusDialog(BuildContext context) {
    final report = getBackgroundSyncStatusReport();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('背景同步狀態'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('更新時間: ${report['timestamp']}'),
              const SizedBox(height: 16),

              // 顯示各個機制狀態
              ...((report['mechanisms'] as Map<String, dynamic>)
                  .entries
                  .map((entry) {
                final mechanism = entry.value as Map<String, dynamic>;
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mechanism['name'] ?? '未知',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(mechanism['description'] ?? ''),
                        Text('狀態: ${mechanism['status']}'),
                        if (mechanism['interval'] != null)
                          Text('間隔: ${mechanism['interval']}'),
                        if (mechanism['syncCount'] != null)
                          Text('同步次數: ${mechanism['syncCount']}'),
                        if (mechanism['lastTrigger'] != null &&
                            mechanism['lastTrigger'].toString().isNotEmpty)
                          Text('最後觸發: ${mechanism['lastTrigger']}'),
                      ],
                    ),
                  ),
                );
              }).toList()),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('關閉'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await triggerManualTestSync();
              showBackgroundSyncStatusDialog(context); // 重新顯示更新後的狀態
            },
            child: const Text('手動測試'),
          ),
        ],
      ),
    );
  }

  /// 持續監控背景同步效果（調試用）
  static StreamSubscription<void>? startContinuousMonitoring() {
    print('📊 [$_tag] 開始持續監控背景同步效果...');

    return Stream.periodic(const Duration(minutes: 1)).listen((_) {
      final report = getBackgroundSyncStatusReport();
      print('📊 [$_tag] 背景同步狀態報告:');
      print('   時間: ${report['timestamp']}');

      final mechanisms = report['mechanisms'] as Map<String, dynamic>;
      for (final entry in mechanisms.entries) {
        final mechanism = entry.value as Map<String, dynamic>;
        print('   ${mechanism['name']}: ${mechanism['status']}');
      }
    });
  }

  /// 停止持續監控
  static void stopContinuousMonitoring(StreamSubscription<void>? subscription) {
    subscription?.cancel();
    print('🛑 [$_tag] 已停止持續監控');
  }

  /// 生成測試建議
  static List<String> getTestingSuggestions() {
    return [
      '✅ 測試前台同步: 保持app在前台，觀察每5分鐘的自動同步',
      '✅ 測試背景同步: 將app切換到背景，觀察背景同步是否繼續',
      '✅ 測試定位權限: 檢查是否正確請求了定位權限',
      '✅ 測試GPS觸發: 在戶外移動，觀察是否有位置變化觸發的同步',
      '✅ 測試夜間模式: 在夜間時段觀察同步頻率是否降低',
      '✅ 測試權限拒絕: 拒絕定位權限後app是否正常降級到雙重機制',
      '✅ 測試網路異常: 在無網路環境下觀察錯誤處理',
      '✅ 測試長時間背景: 將app放置背景數小時，觀察同步是否持續',
    ];
  }

  /// 打印測試指南
  static void printTestingGuide() {
    print('🧪 [$_tag] ===== 三重背景同步測試指南 =====');
    print('');

    final suggestions = getTestingSuggestions();
    for (int i = 0; i < suggestions.length; i++) {
      print('${i + 1}. ${suggestions[i]}');
    }

    print('');
    print(
        '📊 使用 LocationEnhancementTestHelper.getBackgroundSyncStatusReport() 查看狀態');
    print('🔧 使用 LocationEnhancementTestHelper.triggerManualTestSync() 手動測試');
    print(
        '👁️  使用 LocationEnhancementTestHelper.showBackgroundSyncStatusDialog() 顯示狀態');
    print('');
    print('===============================================');
  }
}
